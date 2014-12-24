/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.simple;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

public class SimpleReceiver extends BroadcastReceiver {
  @Override
  public void onReceive(Context context, Intent intent) {
    String message = "I shouldn't exist";
    if (Intent.ACTION_POWER_CONNECTED.equals(intent.getAction())) {
      message = "Yum! Power tastes good.";
    } else if (Intent.ACTION_POWER_DISCONNECTED.equals(intent.getAction())) {
      message = "Being unplugged makes me hangry.";
    }
    Toast.makeText(context, message, Toast.LENGTH_LONG).show();
  }
}
