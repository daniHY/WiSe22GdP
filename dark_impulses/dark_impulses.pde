PImage startScreen; // welcome screen
PImage daybg; // day background
PImage nightbg; //night background switches when bunny becomes evil
PImage bunny; // main character
PImage ebunny; // main character´s dark side because he ate too much carrots
PImage obstacle;
PImage obstacle2;
PImage carrot;
PImage heart; // showing how many lives you have
PImage gameover;
PImage again;
PImage yes;
PImage no;

int START=1, PLAY=2, LOSE=3, WIN=4;
int STATES=START;
int dx = 0, dx2 = 1000; // x coordinates for the day background

int oypo, oxpo;//obstacles positions
int speed=2;
int select;

int bxpo, bypo;
boolean jump=false;

void setup() {
  size(1000, 500);
  //load all images
  startScreen = loadImage("startScreen.jpg");
  startScreen.resize(1000, 500);
  daybg = loadImage("daybg.jpg");
  daybg.resize(1000, 500);
  nightbg = loadImage("nightbg.jpg");
  nightbg.resize(1000, 500);
  bunny = loadImage("bunny.png");
  bunny.resize(200, 200);
  ebunny = loadImage("ebunny.png");
  ebunny.resize(200, 200);
  obstacle = loadImage("obstacle.png");
  //obstacle.resize(500, 500);
  obstacle2 = loadImage("obstacle2.png");
  obstacle2.resize(500, 500);
  carrot = loadImage("carrot.png");
  heart = loadImage("heart.png");
  gameover = loadImage("gameover.png");
  again = loadImage("again.png");
  yes = loadImage("yes.png");
  no = loadImage("no.png");
  oxpo=width;
}

void draw() {
  if (STATES==PLAY) {
    backg();
    obs();
    image(bunny, bxpo, bypo);
    bunnymov();
  }


  // creating a welcome screen, starts if ENTER is pressed
  if (STATES==START) {
    image(startScreen, 0, 0);
    stroke(225);
    textSize(25);
    text ("Press ENTER to start", 50, 50);
  }
}

void backg() {
  // making an endless background
  image(daybg, dx, 0);
  image(daybg, dx2, 0);
  dx-=speed;
  dx2-=speed;
  if (dx < -1000) {
    dx = 1000;
  }
  if (dx2 < -1000) {
    dx2 = 1000;
  }
}

void obs() {

  // endless obstacles
  image(obstacle, oxpo, 52);
  oxpo-=speed;

  if (oxpo<0-obstacle.width) {
    select=int(random(3));
  }
  if (select==1) {
    oxpo=width;
    image(obstacle, oxpo, oypo);
    oxpo-=speed;
  } else if (select==2 ) {
    oxpo=width;
    image(obstacle2, oxpo, oypo);
    oxpo-=speed;
  }
  println(bypo);
}


void bunnymov() {
  if (jump==true&&bypo>50) {
    bypo-=8;
    
  }
  else if(bypo==58||bypo!=278) {
    bypo+=8;
    jump=false;
  }
}



void collide() {
  
}


void gameover_screen() {
}

void keyPressed() {
  if (keyCode == ENTER&&STATES==START) {
    STATES=PLAY;
    oxpo=width;
    oypo=52;
    bypo=278;
    bxpo=70;
  }
  if (keyCode==UP) jump=true;
  if (keyCode==LEFT) bxpo-=15;
  if(keyCode==RIGHT) bxpo+=15;
}
