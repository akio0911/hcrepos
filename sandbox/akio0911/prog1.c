#include <stdio.h>
#include <GLUT/glut.h>

#define MAXPOINTS 100
GLint point[MAXPOINTS][2];
int pointnum = 0;
int rubberband = 0;

void display(void)
{
  int i;

  glClear(GL_COLOR_BUFFER_BIT);

  if(pointnum > 1){
    glColor3d(0.0, 0.0, 0.0);
    glBegin(GL_LINES);
    for(i = 0; i < pointnum; i++){
      glVertex2iv(point[i]);
    }
    glEnd();
  }

  glFlush();
}

void resize(int w, int h)
{
  glViewport(0, 0, w, h);
  glLoadIdentity();
  glOrtho(-0.5, (GLdouble)w - 0.5,
	  (GLdouble)h - 0.5, -0.5,
	  -1.0, 1.0);
}

void mouse(int button, int state, int x, int y)
{
  switch(button){
  case GLUT_LEFT_BUTTON:
    point[pointnum][0] = x;
    point[pointnum][1] = y;
    if(state == GLUT_UP){
      glColor3d(0.0, 0.0, 0.0);
      glBegin(GL_LINES);
      glVertex2iv(point[pointnum - 1]);
      glVertex2iv(point[pointnum]);
      glEnd();
      glFlush();

      rubberband = 0;
    }else{
    }
    if(pointnum < MAXPOINTS - 1) ++pointnum;
    break;
  case GLUT_MIDDLE_BUTTON:
    printf("middle");
    break;
  case GLUT_RIGHT_BUTTON:
    printf("right");
    break;
  default:
    break;
  }

  printf("button is ");

  switch(state){
  case GLUT_UP:
    printf("up");
    break;
  case GLUT_DOWN:
    printf("down");
    break;
  default:
    break;
  }

  printf(" at (%d,%d)\n", x, y);
}

void motion(int x, int y)
{
  static GLint savepoint[2];

  glEnable(GL_COLOR_LOGIC_OP);
  glLogicOp(GL_INVERT);

  glBegin(GL_LINES);
  if(rubberband){
    glVertex2iv(point[pointnum - 1]);
    glVertex2iv(savepoint);
  }
  glVertex2iv(point[pointnum - 1]);
  glVertex2i(x, y);
  glEnd();

  glFlush();

  glLogicOp(GL_COPY);
  glDisable(GL_COLOR_LOGIC_OP);

  savepoint[0] = x;
  savepoint[1] = y;

  rubberband = 1;
}

void init(void)
{
  glClearColor(1.0, 1.0, 1.0, 1.0);
}

int main(int argc, char *argv[])
{
  glutInitWindowPosition(100, 100);
  glutInitWindowSize(320, 240);
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA);
  glutCreateWindow(argv[0]);
  glutDisplayFunc(display);
  glutReshapeFunc(resize);
  glutMouseFunc(mouse);
  glutMotionFunc(motion);
  init();
  glutMainLoop();
  return 0;
}
