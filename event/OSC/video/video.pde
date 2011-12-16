// SlideShow_2

// by Classiclll

// Created 25 August 2005

// Modified 3 Sept. 2005

//

// based on

// WebPicViewer

// by Thoru <http://www.thoruman.com>

// Created 26 August 2005



int maxNum = 12;

PImage[] slideImg = new PImage[maxNum];

int pNum = 1;

int adv = 31;

int tnt = 255;



void setup() {

  int i;

  int maxWH=0;

  for (i=0; i<maxNum; i++){

    slideImg[i] = loadImage("P" + str(i) + ".jpg");

    maxWH = max(maxWH,slideImg[i].width,slideImg[i].height);

  }

  size(maxWH+60, maxWH+60);

  noStroke();

}



void draw(){

  if (tnt<256) {

    background(0);

    tint(255, 255-tnt);

    putImage(slideImg,pNum);

    tint(255, tnt);

    tnt = (tnt+adv>255 ? 255 : tnt+adv);

    putImage(slideImg,(mouseX > width / 2 ? pNum+1 : pNum-1) );

  }

}



void mousePressed(){

  tnt=0;

  if (mouseX > width / 2) {

    pNum = (pNum < maxNum-1 ? pNum+1 : 0 );

  } else {

    pNum = (pNum > 0 ? pNum-1 : maxNum-1 );

  }

  adv = int(max(1, 64*float(mouseY)/height));

}



void putImage(PImage[] target, int i){

  i = (i>=maxNum ? 0 : (i<0 ? maxNum-1 : i) );

  image(target[i], (width-target[i].width)/2, (height-target[i].height)/2);

}
