#ifdef _WIN32
#include <windows.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#ifndef __APPLE__
#include <GL/gl.h>
#include <GL/glut.h>
#else
#include <OpenGL/gl.h>
#include <GLUT/glut.h>
#endif
#include <AR/gsub.h>
#include <AR/video.h>
#include <AR/param.h>
#include <AR/ar.h>

#include "GLMetaseq.h"

/*
GLfloat light0pos[] = {0.0, 3.0, 5.0, 1.0};
GLfloat light1pos[] = {5.0, 3.0, 0.0, 1.0};

GLfloat green[] = {0.0, 1.0, 0.0, 1.0};
*/
//
// Camera configuration.
//
#ifdef _WIN32
char			*vconf = "Data¥¥WDM_camera_flipV.xml";
#else
char			*vconf = "";
#endif

int             xsize, ysize;
int             thresh = 100;
int             count = 0;

//char           *cparam_name    = "Data/camera_para.dat";
char           *cparam_name    = "Data/camera_usb_para.dat";
ARParam         cparam;

/*
char           *patt_name_hiro      = "Data/patt.hiro";
char           *patt_name_kanji      = "Data/patt.kanji";
char           *patt_name_sample1      = "Data/patt.sample1";
char           *patt_name_sample2      = "Data/patt.sample2";
 */
#define PATT_ID_COUNT 1//4
/*
char           *patt_name[PATT_ID_COUNT]      = {
	"Data/patt.hiro",
	"Data/patt.kanji",
	"Data/patt.sample1",
	"Data/patt.sample2"
};
 */
char           *patt_name[PATT_ID_COUNT]      = {
//	"Data/patt.hiro"
	"Data/patt.hiro.osc2009"
};
char *mqo_name = "Data/mqo_model/greta_022.mqo";
//char *mqo_name = "Data/mqo_model/miku/output_1.mqo";
//char *mqo_name = "Data/mqo_model/greta_021.mqo";
char           *seq_name       = "Data/mqo_model/miku/output_";
int             patt_id[PATT_ID_COUNT];
//double          patt_width     = 80.0;
double          patt_width     = 188.0;
double          patt_center[2] = {0.0, 0.0};
//double          patt_center[2] = {40.0, 40.0};
double          patt_trans[3][4];

GLfloat angle = 0.0;

MQO_MODEL model;
MQO_SEQUENCE mqo_seq;
int n_frame = 35;

static void   init(void);
static void   cleanup(void);
static void   keyEvent( unsigned char key, int x, int y);
static void   mainLoop(void);
static void   draw( int i );
static void MouseEvent(int button, int state, int x, int y);
static void mySetLight(void);

void mySetLight(void)
{

	GLfloat light_diffuse[] = {0.9, 0.9, 0.9, 1.0};
	GLfloat light_specular[] = {1.0, 1.0, 1.0, 1.0};
	GLfloat light_ambient[] = {0.3, 0.3, 0.3, 0.1};
	GLfloat light_position[] = {100.0, -200.0, 200.0, 0.0};

	glLightfv(GL_LIGHT0, GL_DIFFUSE, light_diffuse);
	glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
	glLightfv(GL_LIGHT0, GL_AMBIENT, light_ambient);
	glLightfv(GL_LIGHT0, GL_POSITION, light_position);
	 /*
	glLightfv(GL_LIGHT0, GL_POSITION, light0pos);
	glLightfv(GL_LIGHT1, GL_POSITION, light1pos);
	*/
	glShadeModel(GL_SMOOTH);
	glEnable(GL_LIGHT0);
	glEnable(GL_LIGHTING);
	/*
	glLightfv(GL_LIGHT1, GL_DIFFUSE, green);
	glLightfv(GL_LIGHT1, GL_SPECULAR, green);
	 */
}
/*
void mySetMaterial(void)
{
	GLfloat mat_diffuse[] = {1.0, 1.0, 1.0, 1.0};
	GLfloat mat_specular[] = {0.0, 0.0, 1.0, 1.0};
	GLfloat mat_ambient[] = {0.0, 0.0, 1.0, 1.0};
	GLfloat shininess[] = {50.0};

	glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);
	glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
	glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
	glMaterialfv(GL_FRONT, GL_SHININESS, shininess);
}
*/
void KeyUp(unsigned char key, int x, int y)
{
	printf("一般キーを離した\n");
}

void SpecialKeyDown(int key, int x, int y)
{
	printf("特殊キーを押した\n");
	switch (key) {
		case GLUT_KEY_UP: printf("↑を押した\n"); break;
		case GLUT_KEY_DOWN: printf("↓を押した\n"); break;
		case GLUT_KEY_LEFT: printf("←を押した\n"); break;
		case GLUT_KEY_RIGHT: printf("→を押した\n"); break;
		default: break;
	}
}

void SpecialKeyUp(int key, int x, int y)
{
	printf("特殊キーを離した\n");
	switch (key) {
		case GLUT_KEY_UP: printf("↑を離した\n"); break;
		case GLUT_KEY_DOWN: printf("↓を離した\n"); break;
		case GLUT_KEY_LEFT: printf("←を離した\n"); break;
		case GLUT_KEY_RIGHT: printf("→を離した\n"); break;
		default: break;
	}
}

int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	init();

    arVideoCapStart();
	glutKeyboardUpFunc(KeyUp);
	glutSpecialFunc(SpecialKeyDown);
	glutSpecialUpFunc(SpecialKeyUp);
//    argMainLoop( NULL, keyEvent, mainLoop );
    argMainLoop( MouseEvent, keyEvent, mainLoop );
	return (0);
}

static void   keyEvent( unsigned char key, int x, int y)
{
    /* quit if the ESC key is pressed */
    if( key == 0x1b ) {
        printf("*** %f (frame/sec)¥n", (double)count/arUtilTimer());
        cleanup();
        exit(0);
    }
	if(key == 'd'){
		arDebug = 1 - arDebug;
	}
}

/* main loop */
static void mainLoop(void)
{
    ARUint8         *dataPtr;
    ARMarkerInfo    *marker_info;
    int             marker_num;
    int             j, k;
	int l;
	static int isFirst = 1;

    /* grab a vide frame */
    if( (dataPtr = (ARUint8 *)arVideoGetImage()) == NULL ) {
        arUtilSleep(2);
        return;
    }
    if( count == 0 ) arUtilTimerReset();
    count++;

    argDrawMode2D();

    /* detect the markers in the video frame */
    if( arDetectMarker(dataPtr, thresh, &marker_info, &marker_num) < 0 ) {
        cleanup();
        exit(0);
    }

	argDispImage(dataPtr, 0, 0);
	argDispImage(dataPtr, 1, 1);

	if(arDebug && arImage != NULL){
		argDispImage(arImage, 2, 1);
	}else{
		argDispImage(dataPtr, 2, 1);
	}
	printf("arDebug = %d, arImage = %p\n", arDebug, arImage);

    arVideoCapNext();

    /* check for object visibility */
	for(l=0; l<PATT_ID_COUNT; l++){
		k = -1;
		for( j = 0; j < marker_num; j++ ) {
			if( patt_id[l] == marker_info[j].id ) {
				if( k == -1 ) k = j;
				else if( marker_info[k].cf < marker_info[j].cf ) k = j;
			}
		}
		if( k != -1 ) {
			/* get the transformation between the marker and the real camera */

			if(isFirst){
				arGetTransMat(&marker_info[k], patt_center, patt_width, patt_trans);
			}else{
				arGetTransMatCont(&marker_info[k], patt_trans, patt_center, patt_width, patt_trans);
			}
			isFirst = 0;
			draw(l);
			break;
		}
	}

    argSwapBuffers();

	angle += 0.5;
}

static void init( void )
{
    ARParam  wparam;
	int i;

    /* open the video path */
    if( arVideoOpen( vconf ) < 0 ) exit(0);
    /* find the size of the window */
    if( arVideoInqSize(&xsize, &ysize) < 0 ) exit(0);
    printf("Image size (x,y) = (%d,%d)¥n", xsize, ysize);

    /* set the initial camera parameters */
    if( arParamLoad(cparam_name, 1, &wparam) < 0 ) {
        printf("Camera parameter load error !!¥n");
        exit(0);
    }
    arParamChangeSize( &wparam, xsize, ysize, &cparam );
    arInitCparam( &cparam );
    printf("*** Camera Parameter ***¥n");
    arParamDisp( &cparam );

	for(i = 0; i < PATT_ID_COUNT; i++){
		if( (patt_id[i]=arLoadPatt(patt_name[i])) < 0 ) {
			printf("pattern load error !!¥n");
			exit(0);
		}
	}

    /* open the graphics window */
    argInit( &cparam, 1.0, 0, 0, 0, 0 );
//    argInit( &cparam, 1.0, 0, 2, 1, 0 );

//	mqoInit();

	if((model = mqoCreateModel(mqo_name, 1.0)) == NULL){
		printf("モデルの読み込みに失敗しました\n");
//		return -1;
		return;
	}

	printf("シーケンスの読み込み中...");
	mqo_seq = mqoCreateSequence(seq_name, n_frame, 0.1);
	if(mqo_seq.n_frame <= 0){
		printf("シーケンスの読み込みに失敗しました\n");
		return;
	}
	printf("完了\n");
}

/* cleanup function called when program exits */
static void cleanup(void)
{
    arVideoCapStop();
    arVideoClose();
    argCleanup();
	mqoDeleteModel(model);
	mqoDeleteSequence(mqo_seq);
//	mqoCleanup();
}

static void draw( int i )
{
#ifdef _COMMENT_OUT_
    double    gl_para[16];
    GLfloat   mat_ambient[]     = {0.0, 0.0, 1.0, 1.0};
    GLfloat   mat_flash[]       = {0.0, 0.0, 1.0, 1.0};
    GLfloat   mat_flash_shiny[] = {50.0};
    GLfloat   light_position[]  = {100.0,-200.0,200.0,0.0};
    GLfloat   ambi[]            = {0.1, 0.1, 0.1, 0.1};
    GLfloat   lightZeroColor[]  = {0.9, 0.9, 0.9, 0.1};

    argDrawMode3D();
    argDraw3dCamera( 0, 0 );
    glClearDepth( 1.0 );
    glClear(GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);

    /* load the camera transformation matrix */
    argConvGlpara(patt_trans, gl_para);
    glMatrixMode(GL_MODELVIEW);
    glLoadMatrixd( gl_para );

    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    glLightfv(GL_LIGHT0, GL_AMBIENT, ambi);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightZeroColor);
    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_flash);
    glMaterialfv(GL_FRONT, GL_SHININESS, mat_flash_shiny);
    glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
    glMatrixMode(GL_MODELVIEW);
    glTranslatef( 0.0, 0.0, 25.0 );
    glutSolidCube(50.0);
    glDisable( GL_LIGHTING );

    glDisable( GL_DEPTH_TEST );
#endif
	static int k = 0;
    double    gl_para[16];

    argDrawMode3D();
    argDraw3dCamera( 0, 0 );

    argConvGlpara(patt_trans, gl_para);
    glMatrixMode(GL_MODELVIEW);
    glLoadMatrixd( gl_para );
	/*
    glTranslatef( 0.0, 0.0, 20.0 );
	switch(i){
		case 0: glColor3f(0.0, 0.0, 1.0); break;
		case 1: glColor3f(0.0, 1.0, 0.0); break;
		case 2: glColor3f(0.0, 1.0, 1.0); break;
		case 3: glColor3f(1.0, 0.0, 0.0); break;
	}
	glLineWidth(3.0);
	glutWireCube(40.0);
	 */
	/*
	glLineWidth(2.0);
	glColor3f(0.0, 0.0, 1.0);
	glBegin(GL_LINES);
	glVertex3f(0.0, 0.0, 0.0);
	glVertex3f(0.0, 0.0, 200.0);
	glEnd();
	 */
	/*
	glLineWidth(2.0);
	glColor3f(0.5, 0.5, 0.5);
	glBegin(GL_POLYGON);
	glVertex3f(-patt_width/2.0, -patt_width/2.0, 0.0);
	glVertex3f( patt_width/2.0, -patt_width/2.0, 0.0);
	glVertex3f( patt_width/2.0,  patt_width/2.0, 0.0);
	glVertex3f(-patt_width/2.0,  patt_width/2.0, 0.0);
	glEnd();
	 */
	/*
	glLineWidth(2.0);
	glColor3f(0.0, 0.0, 1.0);
    glTranslatef( 0.0, 0.0, patt_width/2.0 );
//	glutWireSphere(patt_width/2.0, 10, 10);
//	glutWireCube(patt_width);
	glutWireTeapot(patt_width);
	 */
	/*
	glTranslatef(40.0, 40.0, 10.0);
	glScalef(2.0, 1.0, 1.0);
	glLineWidth(2.0);
	glColor3f(1.0, 0.0, 0.0);
	glutWireCube(20.0);
	 */
	/*
	glTranslatef(0.0, 0.0, 30.0);
	glRotatef(90.0, 1.0, 0.0, 0.0);
	glRotatef(angle, 0.0, 1.0, 0.0);
	glColor3f(0.0, 0.0, 0.0);
	glutWireTeapot(40.0);
	 */
	/*
	glLineWidth(2.0);
	glColor3f(1.0, 0.0, 0.0);

	glPushMatrix();
	glTranslatef(-40.0, 40.0, 10.0);
	glutWireCube(20.0);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(40.0, 40.0, 10.0);
	glutWireCube(20.0);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(-40.0, -40.0, 10.0);
	glutWireCube(20.0);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(40.0, -40.0, 10.0);
	glutWireCube(20.0);
	glPopMatrix();
	 */
	/*
	glClear(GL_DEPTH_BUFFER_BIT);
//	glEnable(GL_DEPTH_TEST);

	glPushMatrix();
	glTranslatef(40.0, 0.0, 20.0);
	glColor3f(0.0, 1.0, 0.0);
	glutSolidSphere(20.0, 20, 20);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(0.0, 0.0, 10.0);
	glColor3f(1.0, 0.0, 0.0);
	glutSolidCube(20.0);
	glPopMatrix();

//	glDisable(GL_DEPTH_TEST);
	 */
	/*
	glEnable(GL_LIGHTING);
	glTranslatef(40.0, 0.0, 20.0);
	glColor3f(0.0, 1.0, 0.0);
	glutSolidSphere(20.0, 20, 20);
	glDisable(GL_LIGHTING);
*/
	/*
	glClear(GL_DEPTH_BUFFER_BIT);
	glEnable(GL_DEPTH_TEST);

	mySetLight();
	glEnable(GL_LIGHTING);

	glPushMatrix();
	glTranslatef(0.0, 0.0, 30.0);
	glRotatef(90.0, 1.0, 0.0, 0.0);
	mySetMaterial();
	glutSolidTeapot(40.0);
	glPopMatrix();

	glDisable(GL_LIGHTING);
	glDisable(GL_DEPTH_TEST);
	 */
	glClear(GL_DEPTH_BUFFER_BIT);
	glEnable(GL_DEPTH_TEST);
	/*
	mySetLight();
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	 */

//	const GLfloat SCALE = 6.0;
	const GLfloat SCALE = 64.0;
	const GLfloat TRANSLATE_X = 120.0f;
/*
	glPushMatrix();
	glRotatef(90.0, 1.0, 0.0, 0.0);
	glScalef(SCALE, SCALE, SCALE);
	glTranslatef(-TRANSLATE_X, 0.0, 0.0);
	mySetLight();
	mqoCallModel(model);
	glPopMatrix();
*/
	/*
	glPushMatrix();
	glRotatef(90.0, 1.0, 0.0, 0.0);
	glScalef(SCALE, SCALE, SCALE);
	glTranslatef(TRANSLATE_X, 0.0, 0.0);
	mySetLight();
	mqoCallModel(model);
	glPopMatrix();
*/

	const GLfloat SCALE_CHARA = 3.0;
	glPushMatrix();
	glRotatef(90.0, 1.0, 0.0, 0.0);
	glScalef(SCALE_CHARA, SCALE_CHARA, SCALE_CHARA);
//	glTranslatef(TRANSLATE_X, 0.0, 0.0);
	mySetLight();
	mqoCallModel(model);
	glPopMatrix();
/*
	glPushMatrix();
	glRotatef(90.0, 1.0, 0.0, 0.0);
	glScalef(SCALE_CHARA, SCALE_CHARA, SCALE_CHARA);
	//	glTranslatef(TRANSLATE_X, 0.0, 0.0);
	mySetLight();
	mqoCallSequence(mqo_seq, k);
	glPopMatrix();
*/
	for(GLfloat translate_y = -40.0f; translate_y <= 40.0f; translate_y += 10.0f) {
		for(GLfloat translate_x = -40.0f; translate_x <= 40.0f; translate_x += 10.0f) {
			glPushMatrix();
			glRotatef(90.0, 1.0, 0.0, 0.0);
			glScalef(SCALE_CHARA, SCALE_CHARA, SCALE_CHARA);
			glTranslatef(translate_x, translate_y, 0.0);
			mySetLight();
			mqoCallSequence(mqo_seq, k);
			glPopMatrix();
		}
	}

	k++;
	if(k >= n_frame) k = 0;

	glDisable(GL_LIGHTING);
	glDisable(GL_DEPTH_TEST);
}

void MouseEvent(int button, int state, int x, int y)
{
	printf("ボタン:%d, 状態:%d, 座標:(x,y)=(%d,%d)\n", button, state, x, y);
	if(button == GLUT_LEFT_BUTTON && state == GLUT_DOWN)
	{
		printf("マウスの左ボタンが押された\n");
	}
}
