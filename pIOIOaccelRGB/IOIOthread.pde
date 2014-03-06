// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD SETUP
// - - - - - - - - - - - - - - - - - - - - - - -
void ioioSetup(IOIO ioio) throws ConnectionLostException {
  // LED_PIN supports PWM on original IOIO and Droidalyzer/IOIOMint
  // on IOIO-OTG change pin and attach external LED
  ledR = ioio.openPwmOutput(12, 1000);
  ledG = ioio.openPwmOutput(14, 1000);
  ledB = ioio.openPwmOutput(13, 1000);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void ioioLoop(IOIO ioio) throws ConnectionLostException {
  ledR.setDutyCycle(colorX);
  ledG.setDutyCycle(colorY);
  ledB.setDutyCycle(colorZ);

  try {
    Thread.sleep(20);
  }
  catch(InterruptedException e) {
  }
}
