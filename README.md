Qt Bubble Level v1.3.1
======================

Qt Bubble Level is a simple Qt Quick application that uses accelerometer 
sensor information to calculate the inclination of the device and presents 
this as a traditional Bubble level. The application provides a calibration 
feature to handle any possible errors in accelerometer readings. The UI is 
made using Qt Quick and the engine gets the accelerometer data via the 
Qt Mobility QAccelerometer sensor.  The application is compatible with
Symbian^1, Symbian Anna, Maemo and MeeGo 1.2 Harmattan.


FILES
-------------------------------------------------------------------------------

src/main.cpp

- The main file of the application. In practise, creates a Qt Mobility sensor 
  and QDeclarativeView and connects a set of signals to the appropriate slots. 
  The integration of QML and Qt code is done in the main function. 
  
src/taskswitcher.cpp

- Provides a minimise feature via DBus to minimise the application.

src/accelerometerfilter.h

- Provides accelerometer data via Qt Mobility. 

src/settings.h

- Provides saving and reading of angle calibration in a platform-independent 
  way.

src/bubblelevel.qml

- Main QML file, implements the main layout for the graphics. Contains the
  location of task switcher and exit button. The location of the glass tube is 
  also set here. Also contains the function which is used as slot connected in 
  main.cpp.

src/button.qml

- Implements the functionality of a button with a minor press animation.

src/tube.qml

- Contains the graphics for bubble, scale, and reflection. These are drawn on
  different layers to provide the effect that the bubble is inside the glass 
  tube. The conversion of device inclination to bubble position is made here.

src/debian/

- The directory which contains files related to Debian (Maemo) packaging.

install/

- The compiled installation package is located here.


CLASSES USED
-------------------------------------------------------------------------------

The most important Qt classes used in the application are listed here.

 QDeclarativeView     - used to interpret QML files
 QAccelerometer       - used to get accelerometer data from the device
 QAccelerometerFilter - used to convert accelerometer data from radians to
                        degrees and to signal accelerometer data to the UI
 QSettings            - used to save and restore the correction factor from 
                        the device's memory

                        
KNOWN ISSUES
-------------------------------------------------------------------------------

- None.
  
  
BUILD & INSTALLATION INSTRUCTIONS
-------------------------------------------------------------------------------

Preparations
~~~~~~~~~~~~

Check that you have the latest Qt/Qt SDK installed in the development 
environment and on the device.


Build & installation instructions using Qt SDK
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open the Qt PRO file.
   File > Open File or Project, select pro-file.

2. Select target(s), for example 'Qt 4.7.4 for Symbian Anna (Qt SDK)', and
   press the Finish button.

3. Press the Run button to build the project and create the Symbian install 
   package. The application is installed on the device.


RUNNING THE APPLICATION
-------------------------------------------------------------------------------

Launch Qt Bubble Level on your device. The bubble in the glass tube will show 
the level of the device's x-axis relative to gravity. When the device is 
tilted to either direction 20 degrees or more, the bubble will be at the 
corresponding end of the tube.

The accelerometer sensor of the device can be calibrated by pressing the tool
icon beside the QtBubbleLevel sign, placing the device on a level surface, and 
tapping the Calibrate button. The calibration data will be saved into the
device's memory and it will be applied on the next startup of the application.

The application can be minimised with the icon in the upper left corner, or 
closed with the X in the upper right corner.


COMPATIBILITY
-------------------------------------------------------------------------------

- Qt SDK 1.1
- Qt 4.7.4
- Qt 4.7.3 for Symbian^1
- Qt Mobility 1.2.1
- Qt Mobility 1.1.3 for Symbian^1

Tested on:

- Nokia N900
- Nokia N950
- Nokia N8-00
- Nokia E7-00
- Nokia N97 mini
- Nokia 5800 XpressMusic

Developed with:
- Qt SDK 1.1


VERSION HISTORY
-------------------------------------------------------------------------------

1.3.1 Use of Qt Quick 1.1 elements.
1.3 Added MeeGo 1.2 Harmattan support.
1.2 Improved the usability of the calibration feature. Added Symbian^1 support.
1.1 Added Qt Mobility and Symbian^3 support. Added the calibration feature.
1.0 Initial version. Supports only Maemo, the accelerometer information is 
    read using the native Maemo interface. Published in FN Projects only.