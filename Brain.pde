class Brain {
  int inputs = 6;
  int outputs = 2;
  float[][] weights = new float[inputs][outputs];
  float[] opArr = new float[outputs];  
  Brain() {
    for (int o = 0; o<outputs; o++) {
      for (int i = 0; i<inputs; i++) {
        weights[i][o] = random(-1, 1);
      }
    }
  }

  int think(float eX, float eY, float pY, float vertDist, float horDist) {
    for (int o = 0; o<outputs; o++) {
      float sum = 0;
      for (int i = 0; i<inputs; i++) {
        float val;
        if (i == 0) {
          val = weights[i][o]*eX;
        } else if (i == 1) {
          val = weights[i][o]*eY;
        } else if (i == 2) {
          val = weights[i][o]*pY;
        } else if (i == 3) {
          val = weights[i][o]*vertDist;
        } else if (i == 4) {
          val = weights[i][o]*horDist;
        } else {
          val = weights[i][o]*1;
        }
        sum = sum + val;
      }
      opArr[o] = sum;
    }
    opArr[0] = sigmoid(opArr[0]);
    opArr[1] = sigmoid(opArr[1]);
    if (opArr[0]>0.7) {
      return 1;
    } else if(opArr[1]>0.7){
      return 2;
    }
    else{
      return 0;
    }
  }

  float sigmoid(float sum) {
    float ans = 1/(1+exp(-sum));
    return ans;
  }
};
