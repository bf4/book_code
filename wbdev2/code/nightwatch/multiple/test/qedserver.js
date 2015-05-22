/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
module.exports = {
  "Test adding a product" : function (browser) {
    browser
      .url("http://localhost:8080")
      .waitForElementVisible('body', 1000)
      .click("#main ul li a:first-child")
      .pause(1000)
      .setValue('#product_name', 'Widget')
      .setValue('#product_price', '25')
      .setValue('#product_description', 'A simple widget')
      .click('input[type=submit]')
      .pause(1000)
      .assert.containsText('#notice', 'Created Widget')
      .assert.containsText('table tr:first-child td:first-child', 'Widget')
      .click('table tr:first-child input[value=Delete]')
      .pause(1000)
      .assert.containsText('#notice', 'Widget was deleted')
      .end();
  }
};

