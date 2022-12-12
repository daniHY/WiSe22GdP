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

int oypo, oxpo, oxpo2, oxpo3;//obstacles coodinates
int speed=2;

int bxpo, bypo;//bunny's x&y coodinates
boolean jump=false;
boolean newob=false;
int randompo;

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
  obstacle.resize(500, 500);
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

    image(bunny, bxpo, bypo, bunny.width, bunny.height);

    bunnymov();
    collide();
 
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

  image(obstacle, oxpo, 160);
  oxpo-=speed;


  if (oxpo<=width*0.25) {

    image(obstacle, oxpo2, 160);
    oxpo2-=speed;
  }


  //reset obstacles position(infinte obstacles)
  if (oxpo<=0-obstacle.width&&oxpo2<=0-obstacle.width) {
    oxpo2=width;
    oxpo=width;
  }
}


void bunnymov() {
  if (jump==true&&bypo>50) {
    bypo-=8;
  } else if (bypo==58||bypo!=278) {
    bypo+=8;
    jump=false;
  }
}



void collide() {
  if (bxpo==oxpo||bxpo==oxpo2) {
    if (bypo+bunny.height/2>278) {
      println("contacted");
      bxpo-=speed;
    }
    
  }
}


void gameover_screen() {
}

void keyPressed() {
  //reset all numbers when start the game
  if (keyCode == ENTER&&STATES==START) {
    STATES=PLAY;
    oxpo=width;
    oxpo2=width;
    oxpo3=width;
    oypo=52;
    bypo=278;
    bxpo=70;
  }
  if (keyCode==UP) jump=true;
  if (keyCode==LEFT) bxpo-=15;
  if (keyCode==RIGHT) bxpo+=15;
}
