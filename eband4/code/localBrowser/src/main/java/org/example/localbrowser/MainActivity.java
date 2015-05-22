/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.localbrowser;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.JavascriptInterface;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
   private static final String TAG = "LocalBrowser";
   private final Handler handler = new Handler(); 
   private WebView webView;
   private TextView textView;
   private Button button;

   /** Object exposed to JavaScript */
   private class AndroidBridge {
      @JavascriptInterface // Required in Android 4.2+
      public void callAndroid(final String arg) { // must be final
         handler.post(new Runnable() {
            public void run() {
               Log.d(TAG, "callAndroid(" + arg + ")");
               textView.setText(arg);
            }
         });
      }
   }

   @Override
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);

      // Find the Android controls on the screen
      webView = (WebView) findViewById(R.id.web_view);
      textView = (TextView) findViewById(R.id.text_view);
      button = (Button) findViewById(R.id.button);
      // Rest of onCreate follows...

      // Turn on JavaScript in the embedded browser
      webView.getSettings().setJavaScriptEnabled(true);

      // Expose a Java object to JavaScript in the browser
      webView.addJavascriptInterface(new AndroidBridge(),
            "android");

      // Set up a function to be called when JavaScript tries
      // to open an alert window
      webView.setWebChromeClient(new WebChromeClient() {
         @Override
         public boolean onJsAlert(final WebView view,
               final String url, final String message,
               JsResult result) {
            Log.d(TAG, "onJsAlert(" + view + ", " + url + ", "
                  + message + ", " + result + ")");
            Toast.makeText(MainActivity.this, message, Toast.LENGTH_LONG).show();
            result.confirm();
            return true; // I handled it
         }
      });

      // Load the web page from a local asset
      webView.loadUrl("file:///android_asset/index.html");

      // This function will be called when the user presses the
      // button on the Android side
      button.setOnClickListener(new OnClickListener() {
         public void onClick(View view) {
            Log.d(TAG, "onClick(" + view + ")");
            webView.loadUrl("javascript:callJS('Hello from Android')");
         }
      });
   }
}
