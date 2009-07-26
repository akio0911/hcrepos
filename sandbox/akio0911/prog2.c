#include <GLUT/glut.h>

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

void display(void)
{
  int i;

  glClear(GL_COLOR_BUFFER_BIT);

  glColor3d(0.0, 0.0, 0.0);
  glBegin(GL_LINES);
  for(i = 0; i < 12; i++){
    glVertex3dv(vertex[edge[i][0]]);
    glVertex3dv(vertex[edge[i][1]]);
  }
  glEnd();

  glFlush();
}

void resize(int w, int h)
{
  glViewport(0, 0, w, h);

  glLoadIdentity();
  gluPerspective(30.0, (double)w / (double)h, 1.0, 100.0);
  glTranslated(0.0, 0.0, -5.0);
}

void init(void)
{
  glClearColor(1.0, 1.0, 1.0, 1.0);
}

int main(int argc, char *argv[])
{
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGBA);
  glutCreateWindow(argv[0]);
  glutDisplayFunc(display);
  glutReshapeFunc(resize);
  init();
  glutMainLoop();
  return 0;
}
