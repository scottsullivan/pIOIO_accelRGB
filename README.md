pIOIO_accelRGB
==============

<img src="http://imgur.com/l81OXXe.jpg" />

For this project we're going to use <a href="http://processing.org/">Processing</a>, a language built on Java to build an Android application that will read the X, Y, and Z values from the devices accelerometer and use those variables to control the color of the screen and that color will be mirrored by a RGB LED via the IOIO board. 

The IOIO is a microcontroller and has very similar capabilities to an Arduino, except this microcontroller specifically plays nicely with Android devices. In this post, we'll be using the IOIO board for <a href="https://github.com/ytai/ioio/wiki/PWM-Output">pulse-width-modulated digital output</a> which is basically a way of faking analog output. We can also use the IOIO for standard digital output and analog input.

If you're not familiar with using Processing to write Android applications check out this <a href="http://processing.org/tutorials/android/">Android Processing Tutorial</a> by Jer Thorp and the <a href="http://wiki.processing.org/w/Android">Android Processing Wiki.</a> We'll specificially be using the <a href="https://github.com/PinkHatSpike/pioio">PIOIO</a> library for Processing by PinkHatSpike and the <a href="https://code.google.com/p/ketai/">Ketai</a> library by Daniel Sauter.

Here's what it will look like (<a href="https://vimeo.com/88788316">link to Vimeo page</a>):
<a href="https://vimeo.com/88788316"><img src="http://imgur.com/6fU2TuC.jpg" title="Video link" /></a>

### Hardware used
Before we dig in to the code, you'll need to pick up this hardware. You can get most of it from <a href="https://www.sparkfun.com/">Sparkfun</a>.
  * <a href="https://www.sparkfun.com/products/11343">IOIO-OTG</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9434">Bluetooth USB Module Mini</a> from Sparkfun
  * <a href="http://www.adafruit.com/products/328">Lithium Ion Polymer Battery - 3.7v 2500mAh</a> from Adafruit
  * <a href="https://www.sparkfun.com/products/12043">Breadboard - Mini Modular (White)</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9140">Jumper Wires Premium 6" M/F</a> from Sparkfun
  * <a href="http://www.nteinc.com/specs/30100to30199/pdf/nte30115.pdf">RGB LED</a> from NTE
  * <a href="http://www.makershed.com/Make_1_4_Watt_Resistor_Kit_365pc_p/mkee4.htm">One 150Ω resistor</a>
  * <a href="http://www.makershed.com/Make_1_4_Watt_Resistor_Kit_365pc_p/mkee4.htm">Two 100Ω resistors</a>
  * A white ping pong ball to diffuse the light
  * <a href="http://www.amazon.com/Samsung-Nexus-Android-Phone-Sprint/dp/B0050DDVUI">Nexus S 4G</a> by Samsung (any Android phone will do)

### LED wiring
The wiring for this project is a little complicated but not too hard!
  * Connect first lead (#1) of the RGB LED to a 150Ω resistor and then to pin 12 on the IOIO board
  * Connect the longest lead (#2) (negative, cathode) of the LED to ground (GND) on the IOIO board
  * Connect third lead (#3) of the RGB LED to a 100Ω resistor and then to pin 13 on the IOIO board
  * Connect fourth lead (#4) of the RGB LED to a 100Ω resistor and then to pin 14 on the IOIO board
<a href="http://imgur.com/AGBUwzz"><img src="http://i.imgur.com/AGBUwzz.jpg" title="RGB LED PINS" /></a>

[Imgur](http://i.imgur.com/AGBUwzz.jpg)

### Step 1: Importing Libraries / Android
First we have to add appropriate IOIO libraries, Ketai library and parts of the Android API. Before you can import the PIOIO and Ketai libraries to your Processing sketch, you have to download the libraries from <a href="https://github.com/PinkHatSpike/pioio">here</a> and <a href="https://code.google.com/p/ketai/">here</a> and put them in your libraries folder. After the libraries are in the libraries folder we can bring them in to our project, this happens before the setup loop.
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

### Step 4: Processing draw loop
The draw loop is run ~60 times per second default and is in the `void draw()` function. In the draw loop, we're setting what draws to the screen and adjusting the color variables.

4a. Update the color variables based on the accelerometer input. The accelerometer on my phone had a range of about -11 to +11. We're re-mapping that input to a range between zero and one using Processing's `map()` functionality.
```
  colorX = map(accelerometerX, -11, 11, 0, 1);
  colorY = map(accelerometerY, -11, 11, 0, 1);
  colorZ = map(accelerometerZ, -11, 11, 0, 1);
```
4b. Change the background color of the Android application based on the color variables. The color variables are multiplied by 255 for 24-bit RGB colors.
```
  background(colorX*255, colorY*255, colorZ*255);
```
4c. Draw text to the screen. Writing the Red, Green, and Blue values (using `round()` to keep them whole numbers. And displaying the corresponding X, Y, and Z accelerometer inputs using `nfp()` to dynamically adjust the + or - signifier.
```
  text(
    "Red: " + round(colorX * 255) + " x: " + nfp(accelerometerX, 1, 3) + "\n" +
    "Green: " + round(colorY * 255) + " y: " + nfp(accelerometerY, 1, 3) + "\n" +
    "Blue: " + round(colorZ * 255) + " z: " + nfp(accelerometerZ, 1, 3), 50, 0, width, height);
```

### Step 5: Reading the accelerometer
Now we write a function to read the accelerometer data from the Android device, this is a standard Ketai function `void onAccelerometerEvent()` with the variables `float x, float y, float z`.

```
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
```

### Step 6: IOIO thread setup
The IOIO functionality resides in a separate paralell thread that is structured similarly to the Processing `void setup()` and `void draw()` functions. The IOIO setup is in the `void ioioSetup(IOIO ioio)` function and is basically Java and only executes if it's connected to the IOIO. The function declaration is followed by `throws ConnectionLostException` before the opening curly bracket.

In the IOIO thread setup we link our `ledR`, `ledG` and `ledB` variables to pins 12 (R), 14 (G), and 13 (B) on the board and declare that it is to be used for pulse-width-modulated (PWM) digital output. The `1000` after the pin number sets the number of cycles per second.

```
  ledR = ioio.openPwmOutput(12, 1000);
  ledG = ioio.openPwmOutput(14, 1000);
  ledB = ioio.openPwmOutput(13, 1000);
```
**WARNING: Most RGB LEDs are set up so that the Blue anode pin is on the outside, mine happen to have the Green anode pin on the outside. Check the documentation for your specific RGB LED to be sure you're connecting the right pins.**

### Step 7: IOIO thread loop
The IOIO thread loop mirrors the functionality of the `void draw()` processing funtion, is also basically Java and also only executes if it's connected to the IOIO. The function declaration is also followed by `throws ConnectionLostException` before the opening curly bracket.

6a. The try block is empty.
```
  try {
  }
```
6b. The catch block is an exception handler and throws an error if there is an interruption.
```
  catch(InterruptedException e) {
   }
```
### Run on device
Now you should be good to go. Before you run the application be sure to go to the Android menu in the Processing IDE and select "Sketch Permissions" and check off BLUETOOTH, BLUETOOTH_ADMIN, and INTERNET.

<img src="http://i.imgur.com/5WoRRN9.png" title="sketch permissions" />

And that's it! Run the sketch and you should now be able to move your device around and see the color and accelerometer readouts as well as the screen and RGB LED changing color! 

<a href="http://blog.safaribooksonline.com/"><img src="http://i.imgur.com/Br3caNj.jpg" title="Safari Books Online" /></a>
