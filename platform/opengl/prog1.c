// % gcc -framework OpenGL -framework GLUT -framework Foundation prog1.c

#include <GL/glut.h>

void display(void)
{
}

int main(int argc, char *argv[])
{
  glutInit(&argc, argv);
  glutCreateWindow(argv[0]);
  glutDisplayFunc(display);
  glutMainLoop();
  return 0;
}
