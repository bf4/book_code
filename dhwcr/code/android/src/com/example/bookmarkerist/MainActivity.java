/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
package com.example.bookmarkerist;

import java.util.ArrayList;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

public class MainActivity extends Activity {
    ArrayAdapter<String> adapter;
    ListView bookmarks;
    EditText url;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        url = (EditText)findViewById(R.id.url);
        adapter = new ArrayAdapter<String>(
            this, android.R.layout.simple_list_item_1);
        bookmarks = (ListView)findViewById(R.id.bookmarks);
        bookmarks.setAdapter(adapter);
    }
    public void addBookmark(View v) {
        adapter.add(url.getText().toString());
        adapter.notifyDataSetChanged();
        url.setText("");
    }
    // ... rest of class ...
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
