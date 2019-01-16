class Explosion {

  ArrayList<Explosion> explosions;
  PImage[] images;
  PVector pos = new PVector();
  PVector siz = new PVector();//using this for the height and width
  float scale = 0.1;
  int count;
  int currentFrame;
  int framesPerImage = 5;//speed of animation with lower numbers going faster 


//need to call this to make an explosion
  Explosion(PVector _pos, PVector _siz, ArrayList<Explosion> _e, PImage[] _images, int _framesPerImage) {
    explosions = _e;
    explosions.add(this);
    pos = _pos;
    siz = _siz;
    images = _images;
    framesPerImage = _framesPerImage;
    count = 0;
  }

 //don't confuse this with the main sketch's draw method
  void draw() {
     //have we gone through an complete animation?   
    if (checkActive()){
      image(images[currentFrame], pos.x, pos.y, siz.x, siz.y);
    }
    else {
       explosions.remove(this);//this removes it from the list if we are done exploding 
    }
  }

//this checks to see if we have completed one cycle of an explosion
  boolean checkActive() {
    count ++;
    currentFrame = count/framesPerImage;
    return currentFrame < images.length;
  }
}
