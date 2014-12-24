/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.simple;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.widget.Toast;

public class SimpleService extends Service {
  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    Toast.makeText(this, "Hello from a Service", Toast.LENGTH_LONG).show();
    return START_NOT_STICKY;
  }
  @Override
  public IBinder onBind(Intent intent) {
    return null;
  }
}
