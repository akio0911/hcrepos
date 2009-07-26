#include <GLUT/glut.h>

void display(void)
{
  glClear(GL_COLOR_BUFFER_BIT);
  glBegin(GL_POLYGON);
  glColor3d(1.0, 0.0, 0.0);
  glVertex2d(-0.9, -0.9);
  glColor3d(0.0, 1.0, 0.0);
  glVertex2d(0.9, -0.9);
  glColor3d(0.0, 0.0, 1.0);
  glVertex2d(0.9, 0.9);
  glColor3d(1.0, 1.0, 0.0);
  glVertex2d(-0.9, 0.9);
  glEnd();
  glFlush();
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
  init();
  glutMainLoop();
  return 0;
}
