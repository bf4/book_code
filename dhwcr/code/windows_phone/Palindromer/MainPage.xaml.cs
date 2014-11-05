/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;

namespace Palindromer
{
    public partial class MainPage : PhoneApplicationPage
    {
        // Constructor
        public MainPage()
        {
            InitializeComponent();
        }

        private void wordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var word = wordTextBox.Text;
            var reversed = new string(word.Reverse().ToArray());
            var isPalindrome = (word.Length > 0 && word.Equals(reversed));

            resultTextBlock.Text =
                "... " +
                (isPalindrome ? "is" : "is not") +
                " a palindrome";
        }
    }
}