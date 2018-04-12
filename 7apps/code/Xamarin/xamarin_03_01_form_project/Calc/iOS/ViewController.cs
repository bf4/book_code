/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
		
using UIKit;
using Foundation;
using System.Drawing;
using CoreGraphics;

namespace Calc.iOS {
  public partial class ViewController : UIViewController, IUICollectionViewDataSource, IUICollectionViewDelegate {

    CalculatorModel model;

		public ViewController(IntPtr handle) : base (handle) {
      model = new CalculatorModel();
      model.OnDisplayChanged += delegate (CalculatorModel model) {
        DisplayLabel.Text = model.Display;
      };
    }

		public override void ViewDidLoad() {
			base.ViewDidLoad();
      DisplayLabel.AccessibilityIdentifier = "calculator_display";
      ButtonCollectionView.RegisterClassForCell(typeof(ButtonCell), ButtonCell.cellId);
      ButtonCollectionView.Delegate = this;
      ButtonCollectionView.DataSource = this;
		}

    public override void ViewDidAppear(bool animated) {
      base.ViewDidAppear(animated);
      ConfigureStyles();
      ButtonCollectionView.ReloadData();
    }

    public override void ViewWillTransitionToSize(CGSize toSize, IUIViewControllerTransitionCoordinator coordinator) {
      base.ViewWillTransitionToSize(toSize, coordinator);
      coordinator.AnimateAlongsideTransition(
        (context) => { ButtonCollectionView.ReloadData(); },
        completion: null
      );
    }

    public nint GetItemsCount(UICollectionView collectionView, nint section) {
      return CalculatorModel.buttons.Length;
    }

    public UICollectionViewCell GetCell(UICollectionView collectionView, NSIndexPath indexPath) {
      var buttonCell = (ButtonCell)collectionView.DequeueReusableCell(ButtonCell.cellId, indexPath);
      var button = CalculatorModel.buttons[indexPath.Row];
      buttonCell.SetTitle(button);
      return buttonCell;
    }

    [Export("collectionView:didSelectItemAtIndexPath:")]
    public void ItemSelected(UICollectionView collectionView, NSIndexPath indexPath) {
      collectionView.DeselectItem(indexPath, true);
      var button = CalculatorModel.buttons[indexPath.Row];
      model.Input(button);
    }

    [Export("collectionView:layout:sizeForItemAtIndexPath:")]
    public CGSize GetSizeForItem(UICollectionView collectionView, UICollectionViewLayout layout, NSIndexPath indexPath) {
      var button = CalculatorModel.buttons[indexPath.Row];
      var height = collectionView.Frame.Height / 5;
      if (button == "=") {
        return new CGSize(collectionView.Frame.Width / 2, height);
      } else {
        return new CGSize(collectionView.Frame.Width / 4, height);
      }
    }

    void ConfigureStyles() {
      var layout = (UICollectionViewFlowLayout)ButtonCollectionView.CollectionViewLayout;
      layout.MinimumInteritemSpacing = 0;
      layout.MinimumLineSpacing = 0;
      ButtonCollectionView.Layer.BorderWidth = 1.0f;
      ButtonCollectionView.Layer.BorderColor = UIColor.LightGray.CGColor;
      DisplayLabel.Layer.BorderColor = UIColor.LightGray.CGColor;
      DisplayLabel.Layer.BorderWidth = 1.0f;
    }

	}

  public class ButtonCell : UICollectionViewCell {

    public static NSString cellId = new NSString("ButtonCell");

    UILabel label;

    [Export ("initWithFrame:")]
    public ButtonCell(RectangleF frame) : base (frame) {
      ContentView.Layer.BorderColor = UIColor.LightGray.CGColor;
      ContentView.Layer.BorderWidth = 0.5f;

      SelectedBackgroundView = new UIView();
      SelectedBackgroundView.BackgroundColor = UIColor.LightGray;

      label = new UILabel();
      label.TextColor = UIColor.Black;
      label.TextAlignment = UITextAlignment.Center;
      label.Frame = new CGRect(10,10,30,30);
      ContentView.AddSubview(label);
    }

    public void SetTitle(string title) {
      label.Text = title;
    }
  }
}
