//variables for the stars
int mult = 1000;
int numStars = 100;
float starSize = 2; //size of the stars
PVector[] starPos = new PVector [numStars]; //star positions

void initStars() {
  for (int i = 1; i < numStars; i++) {
    starPos[i] =  (PVector.random3D());
    starPos[i].mult(mult);
  }
}

void starBackground() {
  for (int i=1; i < numStars; i++) {  //Background stars
    fill(255f -(float)i/numStars*255, 255, 255);
    float currentSize = random(starSize, starSize*2);
    ellipse(starPos[i].x, starPos[i].y, currentSize, currentSize);

    //original code, ruins frameRate
    /*
    pushMatrix();
     fill(255. -(float)i/numStars*255, 255, 255);
     translate(starPos[i].x, starPos[i].y, starPos[i].z);
     sphere(random(starSize, starSize*2));
    popMatrix(
     */
  }
}
