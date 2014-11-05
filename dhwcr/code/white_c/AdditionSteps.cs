/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
﻿
using System;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using White.Core;
using White.Core.UIItems.WindowItems;
using White.Core.UIItems;
using White.Core.UIItems.Finders;
namespace Calculator.Specs
{
    [Binding]
    public class AdditionSteps
    {
        private static Application app;
        private static Window window;
        private static Label readout;
        // ... hooks and steps go here ...

        private const string IDC_READOUT = "158";

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            app = Application.Launch("calc");
            window = app.GetWindow("Calculator");
            readout = (Label)window.Get(SearchCriteria.ByAutomationId(IDC_READOUT));
        }

        [AfterTestRun]
        public static void AfterTestRun()
        {
            window.Close();
        }

        [Given(@"I have cleared the calculator")]
        public void GivenIHaveClearedTheCalculator()
        {
            window.Get<Button>("Clear").Click();
        }

        [When(@"I enter (.*)")]
        public void WhenIEnter(int number)
        {
            foreach (char digit in number.ToString())
            {
                window.Get<Button>(digit.ToString()).Click();
            }
        }

        [When(@"I add (.*)")]
        public void WhenIAdd(int number)
        {
            window.Get<Button>("Add").Click();
            WhenIEnter(number);
        }

        [Then(@"the result should be (.*)")]
        public void ThenTheResultShouldBe(int expected)
        {
            window.Get<Button>("Equals").Click();
            var result = int.Parse(readout.Text);
            Assert.AreEqual(expected, result);
        }

    }
}
