pIOIO_accelRGB
==============

Android-Processing IOIO example using the accelerometer from the Android device to control an RGB LED

### How to use Processing in Android Mode
   * <a href="http://processing.org/tutorials/android/">Android Processing Tutorial</a> by Jer Thorp
   * <a href="http://wiki.processing.org/w/Android">Android Processing Wiki</a>

### IOIO Processing library
  * <a href="https://github.com/PinkHatSpike/pioio">PIOIO</a> by PinkHatSpike

### Ketai Processing library
  * <a href="https://code.google.com/p/ketai/">Ketai</a> by Daniel Sauter

### Hardware used
  * <a href="https://www.sparkfun.com/products/11343">IOIO-OTG</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9434">Bluetooth USB Module Mini</a> from Sparkfun
  * <a href="http://www.adafruit.com/products/328">Lithium Ion Polymer Battery - 3.7v 2500mAh</a> from Adafruit
  * <a href="https://www.sparkfun.com/products/12043">Breadboard - Mini Modular (White)</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9140">Jumper Wires Premium 6" M/F</a> from Sparkfun
  * <a href="http://www.amazon.com/Samsung-Nexus-Android-Phone-Sprint/dp/B0050DDVUI">Nexus S 4G</a> by Samsung (any Android phone will do)
  * <a href="http://www.nteinc.com/specs/30100to30199/pdf/nte30115.pdf">RGB LED</a> from NTE
  * A white ping pong ball to diffuse the light

### LED wiring
  * Connect first lead (#1) of the RGB LED to a 150Ω resistor and then to pin 12 on the IOIO board
  * Connect the longest lead (#2) (negative, cathode) of the LED to ground (GND) on the IOIO board
  * Connect third lead (#3) of the RGB LED to a 100Ω resistor and then to pin 13 on the IOIO board
  * Connect third lead (#3) of the RGB LED to a 100Ω resistor and then to pin 13 on the IOIO board
<a href="http://imgur.com/qWdZKr2"><img src="http://i.imgur.com/qWdZKr2.jpg" title="RGB LED PINS" /></a>

## The Code

### Step 1: Importing Libraries / Android
First we have to add appropriate IOIO libraries, Ketai, and parts of the Android API, this happens before the setup loop.
```
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

import ketai.sensors.*;

import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;
```

### Step 2: Adding global variables
Also before the setup loop, we name our LED leads, create variables for the accelerometer and the colors, and set up the Ketai sensor library.

2a. Instantiate the Ketai sensor to read the accelerometer.
```
KetaiSensor sensor;
```
2b. Create float variables for our accelerometer axes and their corresponding colors.
```
float accelerometerX, accelerometerY, accelerometerZ, colorX, colorY, colorZ;
```
2c. Name the our three LED variables and specify that it's a pulse-width-modulated (PWM) digital output.
```
PwmOutput ledR, ledG, ledB; 
```

### Step 3: Processing setup
The setup chunk is ran once at the begining of the sketch and is in the `void setup()` funtion, here we start the PIOIO communication and declare the size of our sketch as well as choose the orientation of our sketch.

3a. Set the size of the Android application, you can specify specific pixel dimensions or have it auto-detect the display width and display height of the device. P3D is the render mode, in case later you need something to be 3D.
```
  size(displayWidth, displayHeight, P3D);
```
3b. Instantiate Ketai sensor.
```
  sensor = new KetaiSensor(this);
  sensor.start();
```
3c. Instantiate pIOIO
```
  new PIOIOManager(this).start();
```
3c. Set the orientation of the Android application, here it's portrait but you could also choose `orientation(LANDSCAPE)` or not include this if you don't want to lock the orientation.
```
  orientation(PORTRAIT);
```
3d. Set the text that will be displayed on the screen to be left-aligned and centered vertically.
```
  textAlign(LEFT, CENTER);
```
3e. Set the size of the text to be 36 pixels.
```
  textSize(36);
```
