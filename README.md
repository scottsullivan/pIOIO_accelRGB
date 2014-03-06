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
  * Connect the shorter lead (negative, cathode) of the LED to ground (GND) on the IOIO board
  * Connect the longer lead (positive, anode) of the LED to the #1 pin on the IOIO board

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
```
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ, colorX, colorY, colorZ;
PwmOutput ledR, ledG, ledB; 
```

### Step 3: Processing setup
