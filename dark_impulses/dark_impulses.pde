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
String time;
int initialTime;
int interval=5000; //five seconds
int carrotCounter = 0; //counts collected carrots

int life=3;

void setup() {
  size(1000, 500);
  //load all images
  startScreen = loadImage("startScreen.jpg");
  startScreen.resize(1000, 500);
  daybg = loadImage("daybg.jpg");
  daybg.resize(1000, 500);
  nightbg = loadImage("nightbg.jpg");
  nightbg.resize(1000, 500);
  bunny = loadImage("bunny1.png");
  ebunny = loadImage("ebunny.png");
  ebunny.resize(200, 200);
  obstacle = loadImage("obstacle1.png");
  obstacle2 = loadImage("obstacle3.png");
  carrot = loadImage("carrot1.png");
  heart = loadImage("heart1.png");
  gameover = loadImage("gameover.png");
  again = loadImage("again.png");
  yes = loadImage("yes.png");
  no = loadImage("no.png");
  oxpo=width;

  //set timer for carrots
  initialTime=millis();
}

void draw() {
  // creating a welcome screen, starts if ENTER is pressed
  if (STATES==START) {
    background(0);
    image(startScreen, 0, 0);
    stroke(225);
    textSize(25);
    text ("Press ENTER to start", 50, 50);
  } else if (STATES==LOSE) { 
    image(gameover,50,0);
    image(again,50,100);
    text("ENTER  TO CONTINUE ",width/2,400);
  } else if (STATES==WIN) {
  } else if (STATES==PLAY) {
    backg();
    obs();
    carr();
    image(bunny, bxpo, bypo, bunny.width, bunny.height);
    bunnymov();
    collide();
    carrCount();
    println(oxpo, oxpo2);
    //life number display
    if (life==3) {
      for (int i=0; i<3; i++) {
        int hxpo=30+i*50;
        image(heart, hxpo, 30);
      }
    } else if (life==2) {
      for (int i=0; i<2; i++) {
        int hxpo=30+i*50;
        image(heart, hxpo, 30);
      }
    } else  if (life==1) {
      int hxpo=30;
      image(heart, hxpo, 30);
    } 
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

  image(obstacle, oxpo, oypo);
  oxpo-=speed;


  if (oxpo<=width*0.25) {

    image(obstacle, oxpo2, oypo);
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
  } else if (bypo==58||bypo!=295) {
    bypo+=8;
    jump=false;
  }
}



void collide() {
  //collidtion between bunny and obstacles
  float bunnyr=bxpo+bunny.width/2;
  float bunnyl=bxpo-bunny.width/2;
  float bunnyb=bypo+bunny.height/2;
  float obr=oxpo+obstacle.width/2, obr2=oxpo2+obstacle.width/2;
  float obl=oxpo-obstacle.width/2, obl2=oxpo2-obstacle.width/2;
  float obt=oypo-obstacle.height/2;

  if (bunnyr>=obl && bunnyl<=obr) {
    if (bunnyb>=obt) {
      bxpo-=speed;
    }
  }
  if (bunnyr>=obl2 && bunnyl<=obr2) {
    if (bunnyb>=obt) {
      bxpo-=speed;
    }
  }
  //if bunny runs out of the screen player loses 1 life
  if (bunnyr<0) {
    life-=1;
    bxpo=70;
  }
  if (life==0) STATES=LOSE;
}


void keyPressed() {
  //reset all numbers when start the game
  if (keyCode == ENTER&&STATES==START) {
    STATES=PLAY;
    oxpo=width;
    oxpo2=width;
    oxpo3=width;
    oypo=285;
    bypo=295;
    bxpo=70;
    life=3;
  }
  if(keyCode==ENTER&&STATES==LOSE)
    STATES=START;
  
  //bunny
  if (keyCode==UP) jump=true;
  if (keyCode==LEFT) bxpo-=15;
  if (keyCode==RIGHT) bxpo+=15;
}

void carr() {
  //carrot spawns randomly
  if (millis()-initialTime>interval) {
    time = nf(int(millis()/1000), 3);
    initialTime=millis();
    image(carrot, random(width), random(height));
  }
}

void carrCount() {
  text("Carrots collected: " + carrotCounter, width-250, 30);
}
