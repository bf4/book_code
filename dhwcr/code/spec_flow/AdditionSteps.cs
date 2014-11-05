/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
﻿using System;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Calculator.Specs
{
    [Binding]
    public class AdditionSteps
    {
        private int result;
        [Given(@"I have cleared the calculator")]
        public void GivenIHaveClearedTheCalculator()
        {
            result = 0;
        }
        [When(@"I enter (.*)")]
        public void WhenIEnter(int number)
        {
            result = number;
        }
        [When(@"I add (.*)")]
        public void WhenIAdd(int number)
        {
            result += number;
        }
        [Then(@"the result should be (.*)")]
        public void ThenTheResultShouldBe(int expected)
        {
            Assert.AreEqual(expected, result);
        }
    }
}
