/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li>Saves Images to the Gallery</li>
 * </ul>
 * <p>Updated: 2012-03-22 Daniel Sauter/j.duran</p>
 */

void onCameraPreviewEvent()
{
  cam.read();
}

void exit() 
{
  cam.stop();
}

