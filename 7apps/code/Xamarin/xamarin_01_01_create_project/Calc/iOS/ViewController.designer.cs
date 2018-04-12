/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿//		
// This file has been generated automatically by MonoDevelop to store outlets and		
// actions made in the Xcode designer. If it is removed, they will be lost.		
// Manual changes to this file may not be handled correctly.		
//		
using Foundation;

namespace Calc.iOS
{
	[Register ("ViewController")]		
	partial class ViewController
	{
		[Outlet]		
		UIKit.UIButton Button { get; set; }

		void ReleaseDesignerOutlets ()
		{		
			if (Button != null) {		
				Button.Dispose ();		
				Button = null;		
			}		
		}
	}
}
