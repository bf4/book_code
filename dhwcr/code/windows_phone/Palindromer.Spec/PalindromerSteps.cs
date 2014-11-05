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
using System.Text;
using NUnit.Framework;
using TechTalk.SpecFlow;
using WindowsPhoneTestFramework.Test.EmuSteps;

namespace Palindromer.Spec
{
    [Binding]
    public class PalindromerSteps : EmuDefinitionBase
    {
        // ... step definitions go here ...

        [When(@"I type the word ""([^""]*)""")]
        public void WhenITypeTheWord(string word)
        {
            Assert.IsTrue(
                Emu.ApplicationAutomationController.SetTextOnControl(
                    "wordTextBox", word));
        }
        [Then(@"it should be recognized as a palindrome")]
        public void ThenItShouldBeRecognizedAsAPalindrome()
        {
            string result;
            Assert.IsTrue(
                Emu.ApplicationAutomationController.TryGetTextFromControl(
                    "resultTextBlock", out result));
            Assert.AreEqual("... is a palindrome", result);
        }
    }
}
