/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Util;
using Android.Views;
using Android.Widget;
using Android.Support.V7.Widget;

namespace Calc.Droid {
  [Register("com.sevenapps.calc.CalculatorFragment")]
  public class CalculatorFragment : Fragment {

    RecyclerView recyclerView;
    TextView displayTextView;
    CalculatorModel model;

    public override void OnCreate(Bundle savedInstanceState) {
      base.OnCreate(savedInstanceState);
      RetainInstance = true;
      model = new CalculatorModel();
      model.OnDisplayChanged += delegate(CalculatorModel model) {
        displayTextView.Text = model.Display;
      };
    }

    public override View OnCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
      View view = inflater.Inflate(Resource.Layout.CalculatorLayout, container, false);
      recyclerView = view.FindViewById<RecyclerView>(Resource.Id.recycler_view);
      displayTextView = view.FindViewById<TextView>(Resource.Id.calculator_display);
      ConfigureRecyclerView();
      return view;
    }

    public override void OnStart() {
      base.OnStart();
      if (displayTextView != null && model != null) {
        displayTextView.Text = model.Display;
      }
    }

    void ConfigureRecyclerView() {
      recyclerView.HasFixedSize = false;
      var layoutManager = new GridLayoutManager(Activity, 4);
      layoutManager.SetSpanSizeLookup(new ButtonSpanSizeLookup(CalculatorModel.buttons.Length - 1));
      recyclerView.SetLayoutManager(layoutManager);
      recyclerView.SetAdapter(new ButtonAdapter(CalculatorModel.buttons, ButtonPressed));
    }

    void ButtonPressed(object sender, string button) {
      model.Input(button);
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

