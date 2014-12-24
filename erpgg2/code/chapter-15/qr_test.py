# Imports the monkeyrunner modules used by this program
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
# Connect to Glass and return with a MonkeyDevice object
device = MonkeyRunner.waitForConnection()
# Install QRCamera APK, presuming it's built
device.installPackage('../chapter-13/QRCamera/bin/QRCamera.apk')
# Run the Activity component and wait for launch
package = 'glass.qr'
activity = '.QRCameraActivity'
device.startActivity(component="%(package)s/%(activity)s" % locals())
MonkeyRunner.sleep(2)
# Open Exit Menu and wait for launch
device.press('DPAD_CENTER', MonkeyDevice.DOWN_AND_UP)
MonkeyRunner.sleep(3)
# Keep a screenshot of the Exit menu
result = device.takeSnapshot()
result.writeToFile('menu.png','png')
# Stop the app process
device.shell('am force-stop ' + package)