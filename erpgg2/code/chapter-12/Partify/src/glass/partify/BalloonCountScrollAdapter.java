/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.partify;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TextView;

import com.google.android.glass.widget.CardScrollAdapter;

public class BalloonCountScrollAdapter extends CardScrollAdapter {
  public final static int MAX_BALLOONS = 10;
  private final Context   context;
  public BalloonCountScrollAdapter(Context context) {
    super();
    this.context = context;
  }
  public int getCount() {
    return MAX_BALLOONS;
  }
  public Object getItem(int position) {
    return Integer.valueOf(position);
  }
  public int getPosition(Object item) {
    if( item instanceof Integer ) {
      int idInt = (Integer) item;
      if (idInt >= 0 && idInt < getCount()) {
        return idInt;
      }
    }
    return AdapterView.INVALID_POSITION;
  }
  public View getView(int position, View convertView, ViewGroup parent) {
    if( convertView == null ) {
      convertView = LayoutInflater.from(context)
          .inflate(R.layout.balloon_count, parent);
    }
    TextView countView = (TextView)convertView.findViewById(R.id.count);
    countView.setText(position + " balloons");
    return convertView;
  }
}
