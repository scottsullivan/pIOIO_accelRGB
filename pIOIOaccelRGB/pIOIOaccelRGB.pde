// - - - - - - - - - - - - - - - - - - - - - - -
// PIOIO ACCELEROMETER RGBLED
// MIT License (MIT)
// Copyright (c) 2014 Scott Sullivan
// - - - - - - - - - - - - - - - - - - - - - - -

// - - - - - - - - - - - - - - - - - - - - - - - 
// LIBRARIES
// - - - - - - - - - - - - - - - - - - - - - - - 
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

import ketai.sensors.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// ANDROID IMPORT
// - - - - - - - - - - - - - - - - - - - - - - - 
import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// GLOBAL VARIABLES
// - - - - - - - - - - - - - - - - - - - - - - - 
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ, colorX, colorY, colorZ;
PwmOutput ledR, ledG, ledB; 

// - - - - - - - - - - - - - - - - - - - - - - - 
// SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void setup() {
  sensor = new KetaiSensor(this);
  sensor.start();
  new PIOIOManager(this).start();

  orientation(PORTRAIT);
  textAlign(LEFT, CENTER);
  textSize(36);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// DRAW LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void draw() {
  colorX = map(accelerometerX, -11, 11, 0, 1);
  colorY = map(accelerometerY, -11, 11, 0, 1);
  colorZ = map(accelerometerZ, -11, 11, 0, 1);

  background(colorX*255, colorY*255, colorZ*255);

  text(
    "Red: " + round(colorX * 255) + " x: " + nfp(accelerometerX, 1, 3) + "\n" +
    "Green: " + round(colorY * 255) + " y: " + nfp(accelerometerY, 1, 3) + "\n" +
    "Blue: " + round(colorZ * 255) + " z: " + nfp(accelerometerZ, 1, 3), 50, 0, width, height);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// ACCELEROMETER EVENT
// - - - - - - - - - - - - - - - - - - - - - - - 
void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

