/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("base/app-test.js", function() {
  beforeEach(function() {
    module("App_base");
  });

  // Add tests here

  describe("Bookmark resource", function() {
    var mockBookmarks = null;
    beforeEach(inject(function($httpBackend, Bookmark) { // (1)
      mockBookmarks = [
        new Bookmark({id:1}), new Bookmark({id:2}), new Bookmark({id:3})
      ];
      $httpBackend.expectGET("/bookmarks").respond(mockBookmarks); // (2)
    }));
    it("should retrieve bookmarks", inject(function($httpBackend, bookmarks) { // (3)
      $httpBackend.flush();
      expect(bookmarks.length).toBe(mockBookmarks.length); // (4)
    }));

    // add more tests here

    it("should save a bookmark", inject(
      function($httpBackend, Bookmark, bookmarks, saveBookmark) {
        $httpBackend.flush();
		
        $httpBackend.expectPOST("/bookmarks").respond({id:4});
        saveBookmark(new Bookmark({url:"http://angularjs.org", title:"AngularJS"}));
		
        $httpBackend.flush();
        expect(bookmarks.length).toBe(mockBookmarks.length + 1);
      }
    ));

    it("should delete a bookmark", inject(
      function($httpBackend, bookmarks, deleteBookmark) {
        $httpBackend.flush();
        var bookmark = bookmarks[0];
		
        $httpBackend.expectDELETE("/bookmarks/" + bookmark.id).respond(200);
        deleteBookmark(bookmark);
		
        $httpBackend.flush();
        expect(bookmarks.length).toBe(mockBookmarks.length - 1);
      }
    ));
  });
});
