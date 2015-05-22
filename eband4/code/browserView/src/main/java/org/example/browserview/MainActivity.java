/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.browserview;

import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
// ...
import android.webkit.WebView;
// ...
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

public class MainActivity extends Activity {
   private EditText urlText;
   private Button goButton;
   private WebView webView;
   // ...

   @Override
   public void onCreate(Bundle savedInstanceState) {
      // ...
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);

      // Get a handle to all user interface elements
      urlText = (EditText) findViewById(R.id.url_field);
      goButton = (Button) findViewById(R.id.go_button);
      webView = (WebView) findViewById(R.id.web_view);
      // ...

      // Setup event handlers
      goButton.setOnClickListener(new OnClickListener() {
         public void onClick(View view) {
            openBrowser();
         }
      });
      urlText.setOnEditorActionListener(new OnEditorActionListener() {
         public boolean onEditorAction(TextView v, int actionId,
               KeyEvent event) {
            if (actionId == EditorInfo.IME_ACTION_GO) {
               openBrowser();
               InputMethodManager imm = (InputMethodManager)
                     getSystemService(INPUT_METHOD_SERVICE);
               imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
               return true;
            }
            return false;
         }
      });
   }

   /** Open a browser on the URL specified in the text box */
   private void openBrowser() {
      webView.getSettings().setJavaScriptEnabled(true);
      webView.loadUrl(urlText.getText().toString());
   }
}
