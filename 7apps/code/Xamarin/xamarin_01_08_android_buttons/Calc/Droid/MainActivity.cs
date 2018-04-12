/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;

using Android.App;
using Android.Support.V7.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using Android.Support.V7.Widget;

namespace Calc.Droid {
  [Activity(Label = "Calc", MainLauncher = true, Icon = "@drawable/icon")]
  public class MainActivity : AppCompatActivity {

    public static string[] buttons = { 
      "C", "+/-", "%", "÷",
      "7", "8", "9", "×",
      "4", "5", "6", "-",
      "1", "2", "3", "+",
      "0", ".", "="
    };

    RecyclerView recyclerView;

    protected override void OnCreate(Bundle bundle) {
      base.OnCreate(bundle);

      SetContentView(Resource.Layout.Main);
    }

    protected override void OnStart() {
      base.OnStart();
      recyclerView = FindViewById<RecyclerView>(Resource.Id.recycler_view);
      recyclerView.HasFixedSize = false;
      recyclerView.SetLayoutManager(new GridLayoutManager(this, 4));
      recyclerView.SetAdapter(new ButtonAdapter(buttons));
    }
  }

  public class ButtonAdapter : RecyclerView.Adapter {

    public class ButtonViewHolder : RecyclerView.ViewHolder {
      public TextView textView;

      public ButtonViewHolder(View view) : base(view) {
        textView = (TextView)view;
      }
    }

    string[] buttons;

    public ButtonAdapter(string[] buttons) {
      this.buttons = buttons;
    }

    public override RecyclerView.ViewHolder OnCreateViewHolder(ViewGroup parent,
                                                               int viewType) {
      var view = LayoutInflater.From(parent.Context).
        Inflate(Resource.Layout.CalcButton, parent, false);

      return new ButtonViewHolder(view);
    }

    public override void OnBindViewHolder(RecyclerView.ViewHolder holder,
                                          int position) {
      var button = buttons[position];
      var viewHolder = holder as ButtonViewHolder;
      viewHolder.textView.Text = button;
    }

    public override int ItemCount {
      get { return this.buttons.Length; }
    }

  }

}


