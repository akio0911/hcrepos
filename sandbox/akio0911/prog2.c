#include <GLUT/glut.h>
#include <stdlib.h>

GLdouble vertex[][3] = {
  {0.0, 0.0, 0.0,},
  {1.0, 0.0, 0.0,},
  {1.0, 1.0, 0.0,},
  {0.0, 1.0, 0.0,},
  {0.0, 0.0, 1.0,},
  {1.0, 0.0, 1.0,},
  {1.0, 1.0, 1.0,},
  {0.0, 1.0, 1.0,},
};

int edge[][2] = {
  {0, 1},
  {1, 2},
  {2, 3},
  {3, 0},
  {4, 5},
  {5, 6},
  {6, 7},
  {7, 4},
  {0, 4},
  {1, 5},
  {2, 6},
  {3, 7},
};

void idle(void)
{
  glutPostRedisplay();
}

void display(void)
{
  int i;
  static int r = 0;

  glClear(GL_COLOR_BUFFER_BIT);

  glLoadIdentity();

  gluLookAt(3.0, 4.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

  glRotated((double)r, 0.0, 1.0, 0.0);

  glColor3d(0.0, 0.0, 0.0);
  glBegin(GL_LINES);
  for(i = 0; i < 12; i++){
    glVertex3dv(vertex[edge[i][0]]);
    glVertex3dv(vertex[edge[i][1]]);
  }
  glEnd();

  glutSwapBuffers();

  if(++r >=360) r = 0;
}

void resize(int w, int h)
{
  glViewport(0, 0, w, h);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(30.0, (double)w / (double)h, 1.0, 100.0);

  glMatrixMode(GL_MODELVIEW);
}

void mouse(int button, int state, int x, int y)
{
  switch(button){
  case GLUT_LEFT_BUTTON:
    if(state == GLUT_DOWN){
      glutIdleFunc(idle);
    }
    else{
      glutIdleFunc(0);
    }
    break;
  case GLUT_RIGHT_BUTTON:
    if(state == GLUT_DOWN){
      glutPostRedisplay();
    }
    break;
  default:
    break;
  }
}

void keyboard(unsigned char key, int x, int y)
{
  switch(key){
  case 'q':
  case 'Q':
  case '\033':
    exit(0);
  default:
    break;
  }
}

void init(void)
{
  glClearColor(1.0, 1.0, 1.0, 1.0);
}

int main(int argc, char *argv[])
{
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
  glutCreateWindow(argv[0]);
  glutDisplayFunc(display);
  glutReshapeFunc(resize);
  glutMouseFunc(mouse);
  glutKeyboardFunc(keyboard);
  init();
  glutMainLoop();
  return 0;
}
