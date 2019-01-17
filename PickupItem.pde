class PickupItem {
  
  PVector pos;
  float size;
  PImage img;
  
  
  PickupItem(PVector _pos, float _size, PImage _img) {
    pos = _pos;
    size = _size;
    img = _img;
  }
  
  void switchPos () {
    pos = new PVector(random(-500, 1300), random(-500, 1300));
  }
  
  void update() {
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y, size, size);
  }
  
}
