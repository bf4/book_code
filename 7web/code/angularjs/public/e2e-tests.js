/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("e2e-tests.js", function() {
  describe("Bookmark list", function() {
    beforeEach(function() {
      browser().navigateTo("/");
    });
    it("should display a bookmark list", function() {
      expect(repeater("li.bookmark").count()).toBeGreaterThan(0);
    });

    it("should add a new bookmark", function() {
      var bookmarkCount = repeater("li.bookmark").count(); // (1)
      bookmarkCount.execute(function() {});
      var previousCount = bookmarkCount.value;

      input("formBookmark.bookmark.url"). // (2)
        enter("http://docs.angularjs.org/guide/dev_guide.e2e-testing");
      input("formBookmark.bookmark.title").
        enter("AngularJS end-to-end testing guide");
      element("input:submit").click(); // (3)
      expect(repeater("li.bookmark").count()).toBe(previousCount + 1); // (4)
    });
  });
});
