/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("base/app-test.js", function() {
  describe("Bookmark", function() {
    it("requests bookmarks on findAll", function(done) {
      var bookmarks = [
        {id: 1, url:"http://one.com", title:"One"},
        {id: 2, url:"http://two.com", title:"Two"}
      ];
      can.fixture("GET /bookmarks", function() {
        return bookmarks;
      });
      Bookmark.findAll({}, function(resp) {
        expect(resp.length).toBe(bookmarks.length);
        done();
      });
    });

    it("creates, updates, and deletes bookmarks", function(done) {
      var count = 5;
      var bookmarkFixture = can.fixture.make(count, function(idx) {
        return {
          id: idx + 1,
          url: "http://www.test" + (idx+1) + ".com",
          title: "Title " + (idx+1)
        };
      });
      can.fixture("POST /bookmarks", bookmarkFixture.create);
      can.fixture("PUT /bookmarks/{id}", bookmarkFixture.update);
      can.fixture("DELETE /bookmarks/{id}", bookmarkFixture.destroy);

      new Bookmark(
        {url:"http://www.duck.com", title:"Quack"}
      ).save(function(resp) {
        expect(resp.attr("id")).toBe(count + 1);
        done();
      });
    });
  });
  describe("base/bookmark_list view template", function() {
    it("provides sample code snippets", function() {
      var demo = function() {
        // a list of bookmarks, as we would receive from the server
        var bookmarks = [
          {url:"http://one.com", title:"One"},
          {url:"http://two.com", title:"Two"}
        ];
        var viewModel = {bookmarks:bookmarks};
        var element = $("#target");

        // Render view by calling can.view
        element.html(can.view("/app/base/bookmark_list", viewModel));

        // can.view is implicitly called
        element.html("/app/base/bookmark_list", viewModel);
      };

      var observeDemo = function() {
        // 'bookmarks' is now a list of observes
        var bookmarks = new can.Observe.List([
          {url:"http://one.com", title:"One"},
          {url:"http://two.com", title:"Two"}
        ]);
        var viewModel = {bookmarks:bookmarks};
        $("#target").html("/app/base/bookmark_list", viewModel);

        // The view automatically refreshes to display these changes
        bookmarks[0].attr("title", "Uno");
        bookmarks.push({url:"http://three.com", title:"Three"});
      };
    });
  });
  describe("BookmarkListControl", function() {
    var eventHub = null;
    var bookmark = null;
    var element = null;
    var control = null;

    beforeEach(function() {
      eventHub = new can.Observe({});
      element = $("<div/>");
      bookmark = new Bookmark({url:"http://one.com", title:"One"});
      var bookmarks = new Bookmark.List([bookmark]);
      var options = {eventHub:eventHub, bookmarks:bookmarks};
      control = new BookmarkListControl(element, options);

      eventHub.attr("bookmarks", bookmarks);
    });

    it("triggers editBookmark", function(done) {
      eventHub.bind("editBookmark", function() { done(); });
      element.find("button.edit").click();
    });

    it("deletes a bookmark", function() {
      spyOn(bookmark, "destroy");
      element.find("button.delete").click();
      expect(bookmark.destroy).toHaveBeenCalled();
    });
  });
  describe("base/bookmark_form view template", function() {
    it("displays a bookmark form with bound inputs", function() {
      var url = "http://two.com";
      var model = new Bookmark({id: 2, url:url, title:"Two"});
      var el = $("<div/>").append("/app/base/bookmark_form", model);

      expect(el.find("form").size()).toBe(1);
      expect(el.find("input").size()).toBe(2);
      expect(el.find("button").size()).toBe(2);

      var urlInput = el.find("input:first");
      expect(urlInput.val()).toBe(url);

      expect(el.find(".text-error").size()).toBe(1);
    });
  });
  describe("BookmarkFormControl", function() {
    var el = null;
    var control = null;
    var eventHub = null;
    var bookmark = null;

    beforeEach(function() {
      eventHub = new can.Observe({});
      el = $("<div/>");
      bookmark = new Bookmark({url:"http://one.com", title:"One"});
      var options = {eventHub:eventHub, bookmarks:new Bookmark.List([])};
      control = new BookmarkFormControl(el, options);
    });

    it("populates the form on edit bookmark", function() {
      can.trigger(eventHub, "editBookmark", bookmark);
      expect(el.find("input:first").val()).toBe(bookmark.attr("url"));
    });

    it("populates the bookmark from the form", function() {
      can.trigger(eventHub, "editBookmark", bookmark);
      var newUrl = "http://two.com";
      el.find("input:first").val(newUrl).change();
      el.find("button.save").click();
      expect(bookmark.attr("url")).toBe(newUrl);
    });
  });
  describe("App_base", function() {
    it("initializes (sanity check)", function() {
      new App_base();
      expect(true).toBe(true);
    });
  });
});
