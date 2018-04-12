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
  [Activity (Label = "Calc", MainLauncher = true, Icon = "@drawable/icon")]
  public class MainActivity : AppCompatActivity	{

    public static string[] buttons = { 
      "C", "+/-", "%", "÷",
      "7", "8", "9", "×",
      "4", "5", "6", "-",
      "1", "2", "3", "+",
      "0", ".", "="
    };

    RecyclerView recyclerView;
    TextView displayTextView;

    protected override void OnCreate(Bundle bundle) {
      base.OnCreate (bundle);

      SetContentView (Resource.Layout.Main);
		}

    protected override void OnStart() {
      base.OnStart();
      recyclerView = FindViewById<RecyclerView>(Resource.Id.recycler_view);
      displayTextView = FindViewById<TextView>(Resource.Id.calculator_display);
      ConfigureRecyclerView();
    }

    void ButtonPressed(object sender, string button) {
      displayTextView.Text = button;
    }

    void ConfigureRecyclerView() {
      recyclerView.HasFixedSize = false;
      var layoutManager = new GridLayoutManager(this, 4);
      layoutManager.SetSpanSizeLookup(new ButtonSpanSizeLookup(buttons.Length - 1));
      recyclerView.SetLayoutManager(layoutManager);
      recyclerView.SetAdapter(new ButtonAdapter(buttons, ButtonPressed));
    }
	}

  public class ButtonAdapter : RecyclerView.Adapter {

    public class ButtonViewHolder : RecyclerView.ViewHolder {
      public TextView textView;

      public ButtonViewHolder(View view, Action<string> clickHandler) : base(view) {
        textView = (TextView)view;
        textView.Click += (sender, e) => clickHandler(textView.Text);
      }
    }

    string[] buttons;
    public event EventHandler<string> buttonClickEvent;

    public ButtonAdapter(string[] buttons, EventHandler<string> handler) {
      this.buttons = buttons;
      buttonClickEvent = handler;
    }

    public override RecyclerView.ViewHolder OnCreateViewHolder(ViewGroup parent, int viewType) {
      var view = LayoutInflater.From(parent.Context).
        Inflate(Resource.Layout.CalcButton, parent, false);

      return new ButtonViewHolder(view, ItemClick);
    }

    public override void OnBindViewHolder(RecyclerView.ViewHolder holder, int position) {
      var button = buttons[position];
      var viewHolder = holder as ButtonViewHolder;
      viewHolder.textView.Text = button;
    }

    public override int ItemCount {
      get { return this.buttons.Length; }
    }

    void ItemClick(string button) {
      if (buttonClickEvent != null) {
        buttonClickEvent(this, button);
      }
    }

  }

  public class ButtonSpanSizeLookup : GridLayoutManager.SpanSizeLookup {
    int p;
    public ButtonSpanSizeLookup(int doubleSizeButtonPosition) : base() {
      p = doubleSizeButtonPosition;
    }
    public override int GetSpanSize(int position) {
      if (position == p) {
        return 2;
      } else {
        return 1;
      }
    }
  }

}


