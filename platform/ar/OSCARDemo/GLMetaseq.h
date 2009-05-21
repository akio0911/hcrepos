#ifndef __GL_METASEQ_H__
#define __GL_METASEQ_H__

/*=========================================================================================
 
 GLMetaseq.h (Ver2.01d)
 
 ÉÅÉ^ÉZÉRÉCÉAÇ≈çÏê¨ÇµÇΩÉÇÉfÉã(*.mqo)ÇOpenGLè„Ç…ì«Ç›çûÇﬁä÷êîÇÇ‹Ç∆ÇﬂÇΩC/C++ópÉwÉbÉ_Ç≈Ç∑ÅD
 Ç±ÇÃÉwÉbÉ_ÇégÇ§è„Ç≈à»â∫ÇÃì_Ç…íçà”ÇµÇƒÇ≠ÇæÇ≥Ç¢ÅD
 
 Å@	Å@ÅEàµÇ¶ÇÈÉeÉNÉXÉ`ÉÉÇÕ24bitÉrÉbÉgÉ}ÉbÉvâÊëú
 Å@ÅEÉeÉNÉXÉ`ÉÉâÊëúÇÃÉTÉCÉYÇÕÅuàÍï”Ç™2ÇÃnèÊÉTÉCÉY(64,128,256Åc)ÇÃê≥ï˚å`ÅvÇ…å¿ÇÈ
 
 Å@Åiç≈í·å¿ïKóvÇ»ã@î\ÇµÇ©é¿ëïÇµÇƒÇ¢Ç»Ç¢ÇÃÇ≈ÅCÉÅÉ^ÉZÉRÉCÉAÇ∆ìØÇ∂ï\é¶î\óÕÇÕä˙ë“ÇµÇ»Ç¢Ç≈Ç≠ÇæÇ≥Ç¢Åj
 
 
 Å°ëOÉoÅ[ÉWÉáÉìÇ©ÇÁÇÃéÂÇ»ïœçXÅEâ¸ó«ì_
 
 ÅEÉ}ÉeÉäÉAÉãê›íËÇÃèîê›íËÇ…ëŒâûÇµÇ‹ÇµÇΩÅiÇ¬Ç‚Ç¬Ç‚ÇµÇΩÉIÉuÉWÉFÉNÉgÇ»Ç«Ç™ï\é¶Ç≈Ç´Ç‹Ç∑Åj
 ÅEÉpÅ[ÉcÇÃâ¬éãÅEïsâ¬éãÇ…ëŒâûÇµÇ‹ÇµÇΩ
 ÅEòAî‘MQOÇÃì«Ç›çûÇ›Ç…ëŒâûÇµÇ‹ÇµÇΩ
 ÅEå^íËã`Ç™ëÂïùïœçXÇ…Ç»ÇËÇ‹ÇµÇΩ
 ÅEñ@ê¸ÉxÉNÉgÉãÇÃåvéZÇ™ä‘à·Ç¡ÇƒÇ¢ÇΩÇÃÇèCê≥ÇµÇ‹ÇµÇΩ
 ÅEWindowsàÀë∂ÇÃç\ë¢ëÃÅiBITMAPFILEHEADERÇ»Ç«ÅjÇÉRÅ[ÉhíÜÇ≈égÇ§ÇÃÇÇ‚ÇﬂÇ‹ÇµÇΩ
 
 (Ver2.01dÇ≈ÇÃèCê≥)
 ÅEÉ}ÉeÉäÉAÉãèÓïÒÇÃÇ»Ç¢ÉIÉuÉWÉFÉNÉgÇ≈ì«Ç›çûÇ›ÉGÉâÅ[Ç…Ç»ÇÈÉoÉOÇèCê≥
 ÅEÉeÉNÉXÉ`ÉÉÉtÉ@ÉCÉãÇÃê‚ëŒÉpÉXéwíËÇ…ëŒâû
 
 
 Å°égÇ¢ï˚
 
 ÅEÉÇÉfÉãÇÃçÏê¨ÅiARToolKitÇÃèÍçáÇÕÅCargInit()ÇÃå„Ç≈égÇ¡ÇƒÇ≠ÇæÇ≥Ç¢Åj
 
 MQO_MODEL model;
 model = mqoCreateModel("mario.mqo",1.0);
 
 ÅEÉÇÉfÉãÇÃåƒÇ—èoÇµ
 
 mqoCallModel(model);
 
 
 Å°égÇ¢ï˚ÅiòAî‘ÉtÉ@ÉCÉãÅj
 
 ÅEòAî‘ÉVÅ[ÉPÉìÉXÇÃçÏê¨ÅiARToolKitÇÃèÍçáÇÕÅCargInit()ÇÃå„Ç≈égÇ¡ÇƒÇ≠ÇæÇ≥Ç¢Åj
 
 Å@ó·ÅFmario0.mqo Å` mario9.mqo Çì«Ç›çûÇﬁ
 
 MQO_SEQUENCE seq;
 seq = mqoCreateSequence("mario",10,1.0);
 
 ÅEòAî‘ÉVÅ[ÉPÉìÉXÇÃéwíËÉtÉåÅ[ÉÄÇÃåƒÇ—èoÇµÅiiÇÕÉtÉåÅ[ÉÄî‘çÜÅj
 
 mqoCallSequence(seq,i);
 
 
 Å°ARToolKitÇ≈àµÇ§èÍçáÇÃíçà”ì_
 
 Å@OpenGLÇÃèâä˙èÛë‘Ç≈ÇÕYé≤ÇÕè„ï˚å¸ÅCZé≤ÇÕéËëOÇ…å¸Ç¢ÇƒÇ¢Ç‹Ç∑ÅD
 Å@ÉÅÉ^ÉZÉRÉCÉAÇÃçÏê¨âÊñ Ç≈Ç‡ìØólÇ≈Ç∑ÅDÇ±ÇÍÇ…ëŒÇµÇƒÅC
 Å@ARToolKitÇÃÉ}Å[ÉJç¿ïWånÇ≈ÇÕZé≤Ç™è„Çå¸Ç¢ÇƒÇ¢Ç‹Ç∑ÅD
 
 Å@ÉÅÉ^ÉZÉRÉAÇ≈å©ÇƒÇ¢ÇÈéûÇ∆ìØÇ∂ÇÊÇ§Ç…É}Å[ÉJè„Ç…ï\é¶Ç≥ÇπÇÈÇΩÇﬂÇ…ÇÕ
 Å@à»â∫ÇÃÇ¢Ç∏ÇÍÇ©ÇÃï˚ñ@Ç≈ëŒèàÇµÇƒÇ≠ÇæÇ≥Ç¢ÅD
 Å@Å@ÅEÉÇÉfÉãÇåƒÇ—èoÇ∑ëOÇ…Xé≤é¸ÇËÇ…90ìxâÒì]Ç≥ÇπÇƒÇ®Ç≠ÅC
 Å@Å@ÅEmqoMakeObjects()ÇÃíÜÇ≈ÅCÇ†ÇÁÇ©Ç∂ÇﬂXé≤é¸ÇËÇ…90ìxâÒì]ÇµÇƒÇ®Ç≠ÅC
 å„é“Ç…Ç¬Ç¢ÇƒÇÕÅCÉRÉÅÉìÉgÉAÉEÉgÇµÇƒÇ‹Ç∑ÇÃÇ≈ìKãXÇ¢Ç∂Ç¡ÇƒÇ≠ÇæÇ≥Ç¢ÅD
 
 
 çƒîzïzÅEâ¸ïœÇÕé©óRÇ≈Ç∑ÅD
 Copyright (c) çHäwÉiÉr, 2008-. (Release 08/02/21)
 website: http://www1.bbiq.jp/kougaku/
 
 =========================================================================================*/


////////////////////////////////////////////////////////////////////////////////////////////
// ÉwÉbÉ_
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#ifdef __APPLE__
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>
#else
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>
#endif


////////////////////////////////////////////////////////////////////////////////////////////
// É}ÉNÉçíËã`

#define SIZE_STR	256		// ï∂éöóÒÉoÉbÉtÉ@ÇÃÉTÉCÉY
#define N_OBJ		30		// 1å¬ÇÃÉtÉ@ÉCÉãì‡Ç…Ç†ÇÈÉIÉuÉWÉFÉNÉgÅiÉpÅ[ÉcÅjÇÃç≈ëÂêî

// ç≈ëÂílÉ}ÉNÉç
#ifndef MAX
#define MAX(a, b)  (((a) > (b)) ? (a) : (b))
#endif



////////////////////////////////////////////////////////////////////////////////////////////
// å^íËã`


/*=========================================================================
 Åyå^íËã`ÅzÅ@MQOÉÇÉfÉã
 =========================================================================*/

#ifndef DEFINE_MQO_MODEL
#define DEFINE_MQO_MODEL
typedef GLuint MQO_MODEL;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@MQOÉVÅ[ÉPÉìÉX
 =========================================================================*/

#ifndef DEFINE_MQO_SEQUENCE
#define DEFINE_MQO_SEQUENCE
typedef struct tagMQO_SEQUENCE {
	MQO_MODEL	model;		// ÉÇÉfÉã
	int			n_frame;	// ÉtÉåÅ[ÉÄêî
} MQO_SEQUENCE;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@OpenGLópêFç\ë¢ëÃ (4êFfloat)
 =========================================================================*/

#ifndef DEFINE_glCOLOR4f
#define DEFINE_glCOLOR4f
typedef struct tag_glCOLOR4f{
	GLfloat r;
	GLfloat g;
	GLfloat b;
	GLfloat a;
} glCOLOR4f;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@OpenGLópÇQéüå≥ç¿ïWç\ë¢ëÃ (float)
 =========================================================================*/

#ifndef DEFINE_glPOINT2f
#define DEFINE_glPOINT2f
typedef struct tag_glPOINT2f {
	GLfloat x;
	GLfloat y;
} glPOINT2f;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@OpenGLópÇRéüå≥ç¿ïWç\ë¢ëÃ (float)
 =========================================================================*/
#ifndef DEFINE_glPOINT3f
#define DEFINE_glPOINT3f
typedef struct tag_glPOINT3f{
	GLfloat x;
	GLfloat y;
	GLfloat z;
} glPOINT3f;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@ñ èÓïÒç\ë¢ëÃ
 =========================================================================*/
#ifndef DEFINE_MQO_FACE
#define DEFINE_MQO_FACE
typedef struct tagMQO_FACE{
	int			n;		// 1Ç¬ÇÃñ Çç\ê¨Ç∑ÇÈí∏ì_ÇÃêîÅi3Å`4Åj
	int			m;		// ñ ÇÃçﬁéøî‘çÜ
	int			v[4];	// í∏ì_î‘çÜÇäiî[ÇµÇΩîzóÒ
	glPOINT2f	uv[4];	// UVÉ}ÉbÉv
} MQO_FACE;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@çﬁéøèÓïÒç\ë¢ëÃ
 =========================================================================*/

#ifndef DEFINE_MQO_MATERIAL
#define DEFINE_MQO_MATERIAL
typedef struct tagMQO_MATERIAL{
	glCOLOR4f	col;				// êF
	GLfloat		dif[4];				// ägéUåı
	GLfloat		amb[4];				// é¸àÕåı
	GLfloat		emi[4];				// é©å»è∆ñæ
	GLfloat		spc[4];				// îΩéÀåı
	GLfloat		power;				// îΩéÀåıÇÃã≠Ç≥
	int			useTex;				// ÉeÉNÉXÉ`ÉÉÇÃóLñ≥
	char		texFile[SIZE_STR];	// ÉeÉNÉXÉ`ÉÉÉtÉ@ÉCÉã
	GLuint		texName;			// ÉeÉNÉXÉ`ÉÉñº
	GLubyte		*texImage;			// ÉeÉNÉXÉ`ÉÉâÊëú
} MQO_MATERIAL;
#endif


/*=========================================================================
 Åyå^íËã`ÅzÅ@ÉIÉuÉWÉFÉNÉgç\ë¢ëÃÅiÉpÅ[ÉcÇPå¬ÇÃÉfÅ[É^Åj
 =========================================================================*/

typedef struct tagMQO_OBJECT {
	int			visible;	// â¬éã
	int			n_face;		// ñ êî
	int			n_vertex;	// í∏ì_êî
	MQO_FACE		*F;			// ñ îzóÒ
	glPOINT3f	*V;			// í∏ì_îzóÒ
} MQO_OBJECT;



////////////////////////////////////////////////////////////////////////////////////////////
// ÉvÉçÉgÉ^ÉCÉvêÈåæ

void mqoGetDirectory(const char *path_file, char *path_dir);
GLubyte* mqoLoadTexture(char *filename,int *tex_size);
void mqoRegistTexture(GLuint* tex_name,GLubyte* tex_img,int tex_size);
void mqoReleaseTexture(void *pImage);
void mqoSnormal(glPOINT3f A, glPOINT3f B, glPOINT3f C, glPOINT3f *normal);
void mqoReadMaterial(FILE *fp, MQO_MATERIAL M[]);
void mqoReadVertex(FILE *fp, glPOINT3f V[]);
void mqoReadFace(FILE *fp, MQO_FACE F[]);
void mqoReadObject(FILE *fp, MQO_OBJECT *obj);
void mqoMakePolygon(MQO_FACE *F, glPOINT3f V[], MQO_MATERIAL M[]);
void mqoMakeObjects(MQO_OBJECT obj[], int n_obj, MQO_MATERIAL M[]);
MQO_MODEL	 mqoCreateModel(char *filename, double scale);
MQO_SEQUENCE mqoCreateSequence(char *basename, int n_file, double scale);
void mqoCallModel(MQO_MODEL model);
void mqoCallSequence(MQO_SEQUENCE seq, int i);
void mqoDeleteModel(MQO_MODEL model);
void mqoDeleteSequence(MQO_SEQUENCE seq);



////////////////////////////////////////////////////////////////////////////////////////////
// ä÷êîñ{ëÃ


/*=========================================================================
 Åyä÷êîÅzmqoGetDirectory
 ÅyópìrÅzÉtÉ@ÉCÉãñºÇä‹ÇﬁÉpÉXï∂éöóÒÇ©ÇÁÉfÉBÉåÉNÉgÉäÇÃÉpÉXÇÃÇ›ÇíäèoÇ∑ÇÈ
 Åyà¯êîÅz
 *path_file	ÉtÉ@ÉCÉãñºÇä‹ÇﬁÉpÉXï∂éöóÒÅiì¸óÕÅj
 *path_dir	ÉtÉ@ÉCÉãñºÇèúÇ¢ÇΩÉpÉXï∂éöóÒÅièoóÕÅj
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzó·ÅF
 "C:/data/file.bmp" Å® "C:/data/"
 "data/file.mqo"    Å® "data/"
 =========================================================================*/

void mqoGetDirectory(const char *path_file, char *path_dir)
{
	char *pStr;
	int len;
	
	pStr = MAX( strrchr(path_file,'\\'), strrchr(path_file,'/') );
	len = MAX((int)(pStr-path_file)+1,0);
	strncpy(path_dir,path_file,len);
	path_dir[len] = '\0';
}


/*=========================================================================
 Åyä÷êîÅzmqoLoadTexture
 ÅyópìrÅzÉrÉbÉgÉ}ÉbÉvÉtÉ@ÉCÉãÇ©ÇÁÉeÉNÉXÉ`ÉÉâÊëúÇçÏê¨Ç∑ÇÈ
 Åyà¯êîÅz
 *filename	ÉtÉ@ÉCÉãñº
 *tex_size	ÉeÉNÉXÉ`ÉÉÇÃÉTÉCÉYÅiàÍï”ÇÃí∑Ç≥ÅjÇï‘Ç∑
 
 ÅyñﬂílÅzÉeÉNÉXÉ`ÉÉâÊëúÇ÷ÇÃÉ|ÉCÉìÉ^Åié∏îséûÇÕNULLÅj
 ÅyédólÅz24bitÉrÉbÉgÉ}ÉbÉvå¿íË
 ÉTÉCÉYÇÕÅuàÍï”Ç™2ÇÃnèÊÇÃê≥ï˚å`ÅvÇ…å¿íË
 =========================================================================*/

GLubyte* mqoLoadTexture(char *filename,int *tex_size)
{
	FILE *fp;
	int	y,x,size;
	GLubyte	*pImage, *pRead;
	
	if ( (fp=fopen(filename,"rb"))==NULL ) return NULL;
	
	fseek(fp,14+4,SEEK_SET);		// âÊëúïùÇ™äiî[Ç≥ÇÍÇƒÇ¢ÇÈà íuÇ‹Ç≈ÉVÅ[ÉN
	fread(&size,sizeof(int),1,fp);	// BiWidthÇÃèÓïÒÇæÇØéÊìæ
	fseek(fp,14+40,SEEK_SET);		// âÊëfÉfÅ[É^Ç™äiî[Ç≥ÇÍÇƒÇ¢ÇÈà íuÇ‹Ç≈ÉVÅ[ÉN
	
	// ÉÅÉÇÉäÇÃämï€
	pImage = (GLubyte*)malloc(sizeof(unsigned char)*size*size*4);
	if (pImage==NULL) return NULL;
	
	for (y=0; y<size; y++){
		pRead = pImage + (size-1-y)*4*size;
		for (x=0; x<size; x++) {
			fread( &pRead[2], sizeof(GLubyte), 1, fp);	// B
			fread( &pRead[1], sizeof(GLubyte), 1, fp);	// G	
			fread( &pRead[0], sizeof(GLubyte), 1, fp);	// R
			pRead[3] = 255;								// A
			pRead += 4;
		}
	}
	fclose(fp);
	*tex_size = size;
	
	return pImage;
}


/*=========================================================================
 Åyä÷êîÅzmqoRegistTexture
 ÅyópìrÅzÉeÉNÉXÉ`ÉÉÇÃìoò^
 Åyà¯êîÅz
 *tex_name	ÉeÉNÉXÉ`ÉÉñº
 *tex_img	ÉeÉNÉXÉ`ÉÉâÊëúÇ÷ÇÃÉ|ÉCÉìÉ^
 tex_size	ÉeÉNÉXÉ`ÉÉÇÃÉTÉCÉYÅiàÍï”ÇÃí∑Ç≥Åj
 
 ÅyñﬂílÅzÇ»Çµ
 =========================================================================*/

void mqoRegistTexture(GLuint* tex_name,GLubyte* tex_img,int tex_size)
{
	glPixelStorei(GL_UNPACK_ALIGNMENT,1);
	glGenTextures(1,tex_name);				// ÉeÉNÉXÉ`ÉÉÇê∂ê¨
	glBindTexture(GL_TEXTURE_2D,*tex_name);	// ÉeÉNÉXÉ`ÉÉÇÃäÑÇËìñÇƒ
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, tex_size, tex_size,
				 0, GL_RGBA, GL_UNSIGNED_BYTE, tex_img);
}



/*=========================================================================
 Åyä÷êîÅzmqoReleaseTexture
 ÅyópìrÅzÉeÉNÉXÉ`ÉÉâÊëúÇÃäJï˙
 Åyà¯êîÅz
 *pImageÅ@ÉeÉNÉXÉ`ÉÉâÊëúÇ÷ÇÃÉ|ÉCÉìÉ^
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzfree()ÇµÇƒÇÈÇæÇØ
 =========================================================================*/

void mqoReleaseTexture(void *pImage)
{
	free(pImage);
}



/*=========================================================================
 Åyä÷êîÅzmqoSnormal
 ÅyópìrÅzñ@ê¸ÉxÉNÉgÉãÇãÅÇﬂÇÈ
 Åyà¯êîÅz
 A		3éüå≥ç¿ïWè„ÇÃì_A
 B		3éüå≥ç¿ïWè„ÇÃì_B
 C		3éüå≥ç¿ïWè„ÇÃì_C
 *normal	ÉxÉNÉgÉãBAÇ∆ÉxÉNÉgÉãBCÇÃñ@ê¸ÉxÉNÉgÉãÅiâEÇÀÇ∂ï˚å¸Åj
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzÉÅÉ^ÉZÉRÉCÉAÇ…Ç®Ç¢Çƒñ Çç\ê¨Ç∑ÇÈí∏ì_ÇÃî‘çÜÇÕÅCï\é¶ñ Ç©ÇÁå©Çƒ
 éûåvâÒÇËÇ…ãLèqÇµÇƒÇ†ÇÈÅDÇ¬Ç‹ÇËÅCí∏ì_A,B,C Ç™Ç†Ç¡ÇΩÇ∆Ç´ÅC
 ãÅÇﬂÇÈÇ◊Ç´ñ@ê¸ÇÕBAÇ∆BCÇÃäOêœÇ…ÇÊÇ¡ÇƒãÅÇﬂÇÁÇÍÇÈ
 =========================================================================*/

void mqoSnormal(glPOINT3f A, glPOINT3f B, glPOINT3f C, glPOINT3f *normal)
{
	double norm;
	glPOINT3f vec0,vec1;
	
	// ÉxÉNÉgÉãBA
	vec0.x = A.x - B.x; 
	vec0.y = A.y - B.y;
	vec0.z = A.z - B.z;
	
	// ÉxÉNÉgÉãBC
	vec1.x = C.x - B.x;
	vec1.y = C.y - B.y;
	vec1.z = C.z - B.z;
	
	// ñ@ê¸ÉxÉNÉgÉã
	normal->x = vec0.y * vec1.z - vec0.z * vec1.y;
	normal->y = vec0.z * vec1.x - vec0.x * vec1.z;
	normal->z = vec0.x * vec1.y - vec0.y * vec1.x;
	
	// ê≥ãKâª
	norm = normal->x * normal->x + normal->y * normal->y + normal->z * normal->z;
	norm = sqrt ( norm );
	
	normal->x /= norm;
	normal->y /= norm;
	normal->z /= norm;
}



/*=========================================================================
 Åyä÷êîÅzmqoReadMaterial
 ÅyópìrÅzÉ}ÉeÉäÉAÉãèÓïÒÇÃì«Ç›çûÇ›
 Åyà¯êîÅz
 fp		ÉtÉ@ÉCÉãÉ|ÉCÉìÉ^
 M		É}ÉeÉäÉAÉãîzóÒ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoCreateModel(), mqoCreateSequence()ÇÃÉTÉuä÷êîÅD
 =========================================================================*/

void mqoReadMaterial(FILE *fp, MQO_MATERIAL M[])
{
	GLfloat		dif, amb, emi, spc;
	glCOLOR4f	c;
	char		buf[SIZE_STR];
	char		*pStrEnd, *pStr;
	int			len;
	int			i = 0;
	
	while (1) {
		fgets(buf,SIZE_STR,fp);	// çsì«Ç›çûÇ›
		if (strstr(buf,"}")) break;
		
		pStr = strstr(buf,"col(");	// çﬁéøñºì«Ç›îÚÇŒÇµ
		sscanf( pStr,
			   "col(%f %f %f %f) dif(%f) amb(%f) emi(%f) spc(%f) power(%f)",
			   &c.r, &c.g, &c.b, &c.a, &dif, &amb, &emi, &spc, &M[i].power );
		
		// í∏ì_ÉJÉâÅ[
		M[i].col = c;
		
		// ägéUåı
		M[i].dif[0] = dif * c.r;
		M[i].dif[1] = dif * c.g;
		M[i].dif[2] = dif * c.b;
		M[i].dif[3] = dif * c.a;
		
		// é¸àÕåı
		M[i].amb[0] = amb * c.r;
		M[i].amb[1] = amb * c.g;
		M[i].amb[2] = amb * c.b;
		M[i].amb[3] = amb * c.a;
		
		// é©å»è∆ñæ
		M[i].emi[0] = emi * c.r;
		M[i].emi[1] = emi * c.g;
		M[i].emi[2] = emi * c.b;
		M[i].emi[3] = emi * c.a;
		
		// îΩéÀåı
		M[i].spc[0] = spc * c.r;
		M[i].spc[1] = spc * c.g;
		M[i].spc[2] = spc * c.b;
		M[i].spc[3] = spc * c.a;
		
		
		// texÅFñÕólÉ}ÉbÉsÉìÉOñº
		if ( (pStr = strstr(buf,"tex(")) != NULL ) {
			M[i].useTex = TRUE;
			
			pStrEnd = strstr(pStr,"\")");
			len = pStrEnd - (pStr+5);
			strncpy(M[i].texFile,pStr+5,len);
			M[i].texFile[len] = '\0';
			
		} else {
			M[i].useTex = FALSE;
			M[i].texFile[0] = '\0';
			M[i].texImage = NULL;
		}
		
		i++;
	}
	
}



/*=========================================================================
 Åyä÷êîÅzmqoReadVertex
 ÅyópìrÅzí∏ì_èÓïÒÇÃì«Ç›çûÇ›
 Åyà¯êîÅz
 fp		ÉtÉ@ÉCÉãÉ|ÉCÉìÉ^
 V		í∏ì_îzóÒ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoReadObject()ÇÃÉTÉuä÷êîÅD
 =========================================================================*/

void mqoReadVertex(FILE *fp, glPOINT3f V[])
{
	char buf[SIZE_STR];
	int  i=0;
	
	while (1) {
		fgets(buf,SIZE_STR,fp);
		if (strstr(buf,"}")) break;
		sscanf(buf,"%f %f %f",&V[i].x,&V[i].y,&V[i].z);
		i++;
	}
}



/*=========================================================================
 Åyä÷êîÅzmqoReadFace
 ÅyópìrÅzñ èÓïÒÇÃì«Ç›çûÇ›
 Åyà¯êîÅz
 fp		ÉtÉ@ÉCÉãÉ|ÉCÉìÉ^
 F		ñ îzóÒ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoReadObject()ÇÃÉTÉuä÷êîÅD
 =========================================================================*/

void mqoReadFace(FILE *fp, MQO_FACE F[])
{
	char buf[SIZE_STR];
	char *pStr;
	int  i=0;
	
	while (1) {
		fgets(buf,SIZE_STR,fp);
		if (strstr(buf,"}")) break;
		
		// ñ Çç\ê¨Ç∑ÇÈí∏ì_êî
		sscanf(buf,"%d",&F[i].n);
		
		// í∏ì_(V)ÇÃì«Ç›çûÇ›
		if ( (pStr = strstr(buf,"V(")) != NULL ) {
			switch (F[i].n) {
				case 3:
					sscanf(pStr,"V(%d %d %d)",&F[i].v[0],&F[i].v[1],&F[i].v[2]);
					break;
				case 4:
					sscanf(pStr,"V(%d %d %d %d)",&F[i].v[0],&F[i].v[1],&F[i].v[2],&F[i].v[3]);
					break;
				default:
					break;
			}		
		}
		
		// É}ÉeÉäÉAÉã(M)ÇÃì«Ç›çûÇ›
		F[i].m = 0;
		if ( (pStr = strstr(buf,"M(")) != NULL ) {
			sscanf(pStr,"M(%d)",&F[i].m);
		}
		
		// UVÉ}ÉbÉv(UV)ÇÃì«Ç›çûÇ›
		if ( (pStr = strstr(buf,"UV(")) != NULL ) {
			switch (F[i].n) {
				case 3:	// í∏ì_êî3
					sscanf(pStr,"UV(%f %f %f %f %f %f)",
						   &F[i].uv[0].x, &F[i].uv[0].y,
						   &F[i].uv[1].x, &F[i].uv[1].y,
						   &F[i].uv[2].x, &F[i].uv[2].y
						   );
					break;
					
				case 4:	// í∏ì_êî4
					sscanf(pStr,"UV(%f %f %f %f %f %f %f %f)",
						   &F[i].uv[0].x, &F[i].uv[0].y,
						   &F[i].uv[1].x, &F[i].uv[1].y,
						   &F[i].uv[2].x, &F[i].uv[2].y,
						   &F[i].uv[3].x, &F[i].uv[3].y
						   );
					break;
				default:
					break;
			}		
		}
		
		i++;
	}
	
}



/*=========================================================================
 Åyä÷êîÅzmqoReadObject
 ÅyópìrÅzÉIÉuÉWÉFÉNÉgèÓïÒÇÃì«Ç›çûÇ›
 Åyà¯êîÅz
 fp		ÉtÉ@ÉCÉãÉ|ÉCÉìÉ^
 obj		ÉIÉuÉWÉFÉNÉgèÓïÒ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoCreateModel(), mqoCreateSequence()ÇÃÉTÉuä÷êîÅD
 Ç±ÇÃä÷êîÇ≈ÇPå¬ÇÃÉIÉuÉWÉFÉNÉgèÓïÒÇ™ì«Ç›çûÇ‹ÇÍÇÈÅD
 =========================================================================*/

void mqoReadObject(FILE *fp, MQO_OBJECT *obj)
{
	char buf[SIZE_STR];
	
	while (1) {
		fgets(buf,SIZE_STR,fp);
		if (strstr(buf,"}")) break;
		
		// visible
		if (strstr(buf,"visible ")) {
			sscanf(buf," visible %d", &obj->visible);
		}
		
		// vertex
		if (strstr(buf,"vertex ")) {
			sscanf(buf," vertex %d", &obj->n_vertex);
			obj->V = (glPOINT3f*) calloc( obj->n_vertex, sizeof(glPOINT3f) );
			mqoReadVertex(fp, obj->V);
		}
		
		// face
		if (strstr(buf,"face ")) {
			sscanf(buf," face %d", &obj->n_face);
			obj->F = (MQO_FACE*) calloc( obj->n_face, sizeof(MQO_FACE) );
			mqoReadFace(fp, obj->F);
		}
		
	}
	
}



/*=========================================================================
 Åyä÷êîÅzmqoMakePolygon
 ÅyópìrÅzÉ|ÉäÉSÉìÇÃçÏê¨
 Åyà¯êîÅz
 *F		ñ èÓïÒ
 V[]		í∏ì_îzóÒ
 M[]		É}ÉeÉäÉAÉãîzóÒ
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoMakeObjects()ÇÃÉTÉuä÷êîÅD
 Ç±ÇÃä÷êîÇ≈ÇPñáÇÃÉ|ÉäÉSÉìÇ™çÏÇÁÇÍÇÈÅD
 =========================================================================*/

void mqoMakePolygon(MQO_FACE *F, glPOINT3f V[], MQO_MATERIAL M[])
{
	glPOINT3f	normal;			// ñ@ê¸ÉxÉNÉgÉã
	int			mid = F->m;		// çﬁéøî‘çÜ
	int			i;
	int			useTex;
	
	// ñ@ê¸ÉxÉNÉgÉãÇåvéZ
	mqoSnormal(V[F->v[0]],V[F->v[1]],V[F->v[2]],&normal);
	
	// çﬁéøê›íË
	if ( M != NULL ) {
		// çﬁéøèÓïÒÇ™Ç†ÇÈèÍçá
		glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, M[mid].dif);
		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, M[mid].amb);
		glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, M[mid].spc);
		glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, M[mid].emi);;
		glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, M[mid].power);
		glColor4f(M[mid].col.r, M[mid].col.g, M[mid].col.b, M[mid].col.a);
		useTex = M[F->m].useTex;
		
	} else {
		// çﬁéøèÓïÒÇ™Ç»Ç¢èÍçá
		glColor4f( 1.0, 1.0, 1.0, 1.0 );
		useTex = FALSE;
	}
	
	// É|ÉäÉSÉìê∂ê¨
	if ( useTex ) {
		
		// ÉeÉNÉXÉ`ÉÉÇ™Ç†ÇÈÇ∆Ç´
		glEnable(GL_TEXTURE_2D);
		// glEnable(GL_BLEND);
		// glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glBindTexture(GL_TEXTURE_2D,M[F->m].texName);
		glEnable( GL_NORMALIZE );
		if (F->n==3) glBegin(GL_TRIANGLES);
		if (F->n==4) glBegin(GL_QUADS);
		glNormal3f(normal.x, normal.y, normal.z);	// ñ ñ@ê¸
		for (i=0; i<F->n; i++) {
			glTexCoord2f( F->uv[i].x, F->uv[i].y);
			glVertex3f(V[F->v[i]].x, V[F->v[i]].y, V[F->v[i]].z);
		}
		glEnd();
		glDisable(GL_NORMALIZE);
		// glDisable(GL_BLEND);
		glDisable(GL_TEXTURE_2D);
		
	} else {
		
		// ÉeÉNÉXÉ`ÉÉÇ™Ç»Ç¢Ç∆Ç´
		glEnable(GL_NORMALIZE);
		if (F->n==3) glBegin(GL_TRIANGLES);
		if (F->n==4) glBegin(GL_QUADS);
		glNormal3f(normal.x, normal.y, normal.z);	// ñ ñ@ê¸
		for (i=0; i<F->n; i++) {
			glVertex3f(V[F->v[i]].x, V[F->v[i]].y, V[F->v[i]].z);
		}
		glEnd();
		glDisable(GL_NORMALIZE);
		
	}
	
}


/*=========================================================================
 Åyä÷êîÅzmqoMakeObjects
 ÅyópìrÅzÉIÉuÉWÉFÉNÉgÇÃÉfÅ[É^Ç©ÇÁÉ|ÉäÉSÉìÉÇÉfÉãÇçÏê¨Ç∑ÇÈ
 Åyà¯êîÅz
 obj		ÉIÉuÉWÉFÉNÉgîzóÒ
 n_obj	ÉIÉuÉWÉFÉNÉgÇÃå¬êî
 M		É}ÉeÉäÉAÉãîzóÒ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzmqoCreateModel(), mqoCreateSequence()ÇÃÉTÉuä÷êîÅD
 ÉIÉuÉWÉFÉNÉgèÓïÒÅCÉ}ÉeÉäÉAÉãèÓïÒÇå≥Ç…É|ÉäÉSÉìÉÇÉfÉãÇçÏê¨Ç∑ÇÈÅD
 =========================================================================*/

void mqoMakeObjects(MQO_OBJECT obj[], int n_obj, MQO_MATERIAL M[])
{
	int i,j;
	
	glPushMatrix();
	//glRotatef(90.0f, 1.f, 0.f, 0.f); // ÅyARToolKitópÅz
	
	for (i=0; i<n_obj; i++) {
		for (j=0; j<obj[i].n_face; j++) {
			if (obj[i].visible) {
				mqoMakePolygon( &obj[i].F[j], obj[i].V, M);
			}
		}
	}
	
	glPopMatrix();
	
}



/*=========================================================================
 Åyä÷êîÅzmqoCreateModel
 ÅyópìrÅzMQOÉtÉ@ÉCÉãÇ©ÇÁMQOÉÇÉfÉãÇçÏê¨Ç∑ÇÈ
 Åyà¯êîÅz
 filename	MQOÉtÉ@ÉCÉã
 scale		ägëÂó¶Åi1.0Ç≈ÇªÇÃÇ‹Ç‹Åj
 
 ÅyñﬂílÅzMQO_MODELÅiMQOÉÇÉfÉãÅj
 =========================================================================*/

MQO_MODEL mqoCreateModel(char *filename, double scale)
{
	FILE			*fp;
	MQO_OBJECT		obj[N_OBJ];
	MQO_MATERIAL	*M = NULL;
	MQO_MODEL		displist;
	
	char	buf[SIZE_STR];
	char	path_dir[SIZE_STR];	// ÉfÉBÉåÉNÉgÉäÇÃÉpÉX
	char	path_tex[SIZE_STR];	// ÉeÉNÉXÉ`ÉÉÉtÉ@ÉCÉãÇÃÉpÉX
	int		n_mat = 0;			// É}ÉeÉäÉAÉãêî
	int		n_obj = 0;			// ÉIÉuÉWÉFÉNÉgêî
	int		tex_size;			// ÉeÉNÉXÉ`ÉÉÉTÉCÉY
	int		i;
	
	// MaterialÇ∆ObjectÇÃì«Ç›çûÇ›
	fp = fopen(filename,"r");
	if (fp==NULL) return -1;
	
	i = 0;
	while ( !feof(fp) ) {
		fgets(buf,SIZE_STR,fp);
		
		// Material
		if (strstr(buf,"Material")) {
			sscanf(buf,"Material %d", &n_mat);
			M = (MQO_MATERIAL*) calloc( n_mat, sizeof(MQO_MATERIAL) );
			mqoReadMaterial(fp,M);
		}
		
		// Object
		if (strstr(buf,"Object")) {
			mqoReadObject(fp, &obj[i]);
			i++;
		}
	}
	n_obj = i;
	fclose(fp);
	
	// ÉpÉXÇÃéÊìæ
	mqoGetDirectory(filename, path_dir);
	
	// ÉeÉNÉXÉ`ÉÉÇÃìoò^
	for (i=0; i<n_mat; i++) {
		if (M[i].useTex) {
			if (strstr(M[i].texFile,":")) {
				strcpy(path_tex, M[i].texFile);	// ê‚ëŒÉpÉXÇÃèÍçá
			} else {
				sprintf(path_tex,"%s%s",path_dir,M[i].texFile);	// ëäëŒÉpÉXÇÃèÍçá
			}
			M[i].texImage = mqoLoadTexture(path_tex,&tex_size);
			mqoRegistTexture(&(M[i].texName), M[i].texImage, tex_size);
			mqoReleaseTexture(M[i].texImage);
		}
	}
	
	// É|ÉäÉSÉìÇÃê∂ê¨ÅiÉfÉBÉXÉvÉåÉCÉäÉXÉgÇÃçÏê¨Åj
	displist = glGenLists(1);
	glNewList(displist, GL_COMPILE);
	glScaled(scale, scale, scale);	// ÉXÉPÅ[Éãïœä∑
	mqoMakeObjects(obj,n_obj,M);	// ÉIÉuÉWÉFÉNÉgÇÃï`âÊ
	glEndList();
	
	// ÉIÉuÉWÉFÉNÉgÇÃÉfÅ[É^ÇÃäJï˙
	for (i=0; i<n_obj; i++) {
		free(obj[i].V);
		free(obj[i].F);
	}
	
	// É}ÉeÉäÉAÉãÇÃäJï˙
	free(M);
	
	return displist;
}



/*=========================================================================
 Åyä÷êîÅzmqoCreateSequence
 ÅyópìrÅzòAî‘ÇÃMQOÉtÉ@ÉCÉãÇ©ÇÁMQOÉVÅ[ÉPÉìÉXÇçÏê¨Ç∑ÇÈ
 Åyà¯êîÅz
 basename	ÉtÉ@ÉCÉãñºÇ©ÇÁòAî‘êîéöÇ∆".mqo"ÇèúÇ¢ÇΩÉxÅ[ÉXÉtÉ@ÉCÉãñº
 n_file		ÉtÉ@ÉCÉãêî
 scale		ägëÂó¶Åi1.0Ç≈ÇªÇÃÇ‹Ç‹Åj
 
 ÅyñﬂílÅzMQO_SEQUENCEÅiMQOÉVÅ[ÉPÉìÉXÅj
 ÅyédólÅzdata0.mqo, data1.mqo, ... Ç∆Ç¢Ç§ä¥Ç∂ÇÃòAî‘ÇÃMQOÉtÉ@ÉCÉãÇì«Ç›çûÇÒÇ≈
 MQOÉVÅ[ÉPÉìÉXÇçÏê¨Ç∑ÇÈÅDÉ}ÉeÉäÉAÉãèÓïÒÇÕ1î‘ñ⁄ÇÃÉtÉ@ÉCÉãÇ©ÇÁÇÃÇ›
 ì«Ç›çûÇﬁÅD
 =========================================================================*/

MQO_SEQUENCE mqoCreateSequence(char *basename, int n_file, double scale)
{
	FILE			*fp;
	MQO_OBJECT		obj[N_OBJ];
	MQO_MATERIAL	*M = NULL;
	MQO_SEQUENCE	seq;
	
	int		i,k;
	char	buf[SIZE_STR];
	int		n_mat = 0;			// É}ÉeÉäÉAÉãêî
	int		n_obj;				// ÉIÉuÉWÉFÉNÉgêî
	char	path_dir[SIZE_STR];	// ÉfÉBÉåÉNÉgÉäÇÃÉpÉX
	char	path_tex[SIZE_STR];	// ÉeÉNÉXÉ`ÉÉÉtÉ@ÉCÉãÇÃÉpÉX
	int		tex_size;
	char	filename[SIZE_STR];
	
	// ÉfÉBÉXÉvÉåÉCÉäÉXÉgÇÃçÏê¨
	seq.model = glGenLists(n_file);
	seq.n_frame = n_file;
	
	for (k=0; k<n_file; k++) {
		sprintf(filename,"%s%d.mqo",basename,k);
		
		//-------------------------------------------------------------------------
		// MaterialÇ∆ObjectÇÃì«Ç›çûÇ›
		fp = fopen(filename,"r");
		if (fp==NULL) {
			seq.n_frame = 0;
			return seq;
		}
		
		i = 0;
		while ( !feof(fp) ) {
			fgets(buf,SIZE_STR,fp);
			
			// Material
			if ( strstr(buf,"Material") != NULL ) {
				sscanf(buf,"Material %d", &n_mat);
				M = (MQO_MATERIAL*) calloc( n_mat, sizeof(MQO_MATERIAL) );
				mqoReadMaterial(fp,M);
			}
			
			// Object
			if ( strstr(buf,"Object") != NULL ) {
				mqoReadObject(fp, &obj[i]);
				i++;
			}
		}
		n_obj = i;
		fclose(fp);
		
		//-------------------------------------------------------------------------
		// èââÒÇæÇØÉeÉNÉXÉ`ÉÉÇìoò^
		//		if (k==0) {
		if (1) {
			
			//-------------------------------------------------------------------------
			// ÉpÉXÇÃéÊìæ
			mqoGetDirectory(filename, path_dir);
			
			//-------------------------------------------------------------------------
			// ÉeÉNÉXÉ`ÉÉÇÃìoò^
			for (i=0; i<n_mat; i++) {
				if (M[i].useTex) {
					if ( strstr(M[i].texFile,":") ) {
						strcpy(path_tex, M[i].texFile);	// ê‚ëŒÉpÉXÇÃèÍçá
					} else {
						sprintf(path_tex,"%s%s",path_dir,M[i].texFile);	// ëäëŒÉpÉXÇÃèÍçá
					}
					M[i].texImage = mqoLoadTexture(path_tex,&tex_size);
					mqoRegistTexture(&(M[i].texName),M[i].texImage,tex_size);
					mqoReleaseTexture(M[i].texImage);
				}
			}
		}
		
		//-------------------------------------------------------------------------
		// É|ÉäÉSÉìÇÃê∂ê¨ÅiÉfÉBÉXÉvÉåÉCÉäÉXÉgÇÃçÏê¨Åj
		glNewList(seq.model + k, GL_COMPILE);
		glScaled(scale, scale, scale);	// ÉXÉPÅ[Éãïœä∑
		mqoMakeObjects(obj,n_obj,M);	// ÉIÉuÉWÉFÉNÉgÇÃï`âÊ
		glEndList();
		
		//-------------------------------------------------------------------------
		// ÉIÉuÉWÉFÉNÉgÇÃÉfÅ[É^ÇÃäJï˙
		for (i=0; i<n_obj; i++) {
			free(obj[i].V);
			free(obj[i].F);
		}
		
	}
	
	// É}ÉeÉäÉAÉãÇÃäJï˙
	free(M);
	
	return seq;
}



/*=========================================================================
 Åyä÷êîÅzmqoCallModel
 ÅyópìrÅzMQOÉÇÉfÉãÇOpenGLÇÃâÊñ è„Ç…åƒÇ—èoÇ∑
 Åyà¯êîÅz
 model		MQOÉÇÉfÉã
 
 ÅyñﬂílÅzÇ»Çµ
 =========================================================================*/

void mqoCallModel(MQO_MODEL model)
{
	glCallList(model);
}



/*=========================================================================
 Åyä÷êîÅzmqoCallSequence
 ÅyópìrÅzMQOÉVÅ[ÉPÉìÉXÇOpenGLÇÃâÊñ Ç…åƒÇ—èoÇ∑
 Åyà¯êîÅz
 seq		MQOÉVÅ[ÉPÉìÉX
 i		ÉtÉåÅ[ÉÄî‘çÜ
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzMQOÉVÅ[ÉPÉìÉXÇÃíÜÇ©ÇÁéwíËÇµÇΩÉtÉåÅ[ÉÄî‘çÜÇÃÉÇÉfÉãÇåƒÇ—èoÇ∑ÅD
 =========================================================================*/

void mqoCallSequence(MQO_SEQUENCE seq, int i)
{
	if ( i>=0 && i<seq.n_frame ) {
		glCallList(seq.model+i);
	}
}



/*=========================================================================
 Åyä÷êîÅzmqoDeleteModel
 ÅyópìrÅzMQOÉÇÉfÉãÇçÌèúÇ∑ÇÈ
 Åyà¯êîÅz
 model	MQOÉÇÉfÉã
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzàµÇ¢Ç∆ÇµÇƒÇÕÉfÉBÉXÉvÉåÉCÉäÉXÉgÇÃçÌèúÇ∆ìØã`ÅD
 =========================================================================*/
void mqoDeleteModel(MQO_MODEL model)
{
	glDeleteLists(model,1);
}



/*=========================================================================
 Åyä÷êîÅzmqoDeleteSequence
 ÅyópìrÅzMQOÉVÅ[ÉPÉìÉXÇçÌèúÇ∑ÇÈ
 Åyà¯êîÅz
 seq		MQOÉVÅ[ÉPÉìÉX
 
 ÅyñﬂílÅzÇ»Çµ
 ÅyédólÅzàµÇ¢Ç∆ÇµÇƒÇÕÉfÉBÉXÉvÉåÉCÉäÉXÉgÇÃçÌèúÇ∆ìØã`ÅD
 =========================================================================*/

void mqoDeleteSequence(MQO_SEQUENCE seq)
{
	glDeleteLists(seq.model, seq.n_frame);
}


#endif