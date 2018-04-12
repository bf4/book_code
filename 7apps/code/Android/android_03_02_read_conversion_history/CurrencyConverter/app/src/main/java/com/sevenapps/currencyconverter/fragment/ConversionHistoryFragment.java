/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.fragment;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.LoaderManager;
import android.support.v4.app.ListFragment;
import android.support.v4.content.AsyncTaskLoader;
import android.support.v4.content.Loader;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.sevenapps.currencyconverter.R;
import com.sevenapps.currencyconverter.data.DatabaseHelper;
import com.sevenapps.currencyconverter.model.ConversionRateHistoryRecord;

import java.util.ArrayList;

public class ConversionHistoryFragment extends Fragment
  implements LoaderManager.LoaderCallbacks<ArrayList<ConversionRateHistoryRecord>> {

  private static int HISTORY_LOADER_ID = 1;
  private RecyclerView recyclerView;

  @Override public View onCreateView(
    LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
    return inflater.inflate(R.layout.conversion_history_list, container, false);
  }

  @Override public void onStart() {
    super.onStart();
    recyclerView = (RecyclerView) getView().findViewById(R.id.recycler_view);
    recyclerView.setHasFixedSize(true);
    recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
    getLoaderManager().initLoader(HISTORY_LOADER_ID, null, this).forceLoad();
  }

  //---------------------------
  // Loader Manager
  //---------------------------

  private static class HistoryRecordLoader
    extends AsyncTaskLoader<ArrayList<ConversionRateHistoryRecord>> {
    public HistoryRecordLoader(Context context) { super(context); }
    @Override public ArrayList<ConversionRateHistoryRecord> loadInBackground() {
      DatabaseHelper databaseHelper = new DatabaseHelper(getContext());
      ArrayList<ConversionRateHistoryRecord> records =
        databaseHelper.getAllHistoryRecords();
      return records;
    }
  }

  // Callbacks

  @Override public Loader onCreateLoader(int id, Bundle args) {
    if (id == HISTORY_LOADER_ID) {
      return new HistoryRecordLoader(getActivity());
    }
    return null;
  }

  @Override public void onLoadFinished(
    Loader<ArrayList<ConversionRateHistoryRecord>> loader,
    ArrayList<ConversionRateHistoryRecord> records) {
    recyclerView.setAdapter(new ConversionHistoryAdapter(records));
  }

  @Override public void onLoaderReset(
    Loader<ArrayList<ConversionRateHistoryRecord>> loader) {  }

  //---------------------------
  // Recycler View Adapter
  //---------------------------

  private static class ConversionHistoryAdapter
    extends RecyclerView.Adapter<ConversionHistoryAdapter.HistoryRecordViewHolder> {

    private ArrayList<ConversionRateHistoryRecord> records;

    public static class HistoryRecordViewHolder extends RecyclerView.ViewHolder {
      private final TextView label;
      private final TextView dateLabel;

      public HistoryRecordViewHolder(View itemView) {
        super(itemView);
        label = (TextView) itemView.findViewById(R.id.history_label);
        dateLabel = (TextView) itemView.findViewById(R.id.date_label);
      }
    }

    public ConversionHistoryAdapter(ArrayList<ConversionRateHistoryRecord> records) {
      this.records = records;
    }

    @Override public int getItemCount() {
      return (records == null) ? 0 : records.size();
    }

    @Override
    public HistoryRecordViewHolder onCreateViewHolder(ViewGroup parent, int i) {
      View view = LayoutInflater.from(parent.getContext())
        .inflate(R.layout.conversion_history_item, parent, false);

      return new HistoryRecordViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HistoryRecordViewHolder viewHolder, int i) {
      ConversionRateHistoryRecord record = records.get(i);
      viewHolder.label.setText(record.toHTML());
      viewHolder.dateLabel.setText(record.date.toString());
    }

  }
}
