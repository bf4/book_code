/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("tagfilter/app-test.js", function() {
  describe("Bookmark", function() {
    describe("tags", function() {
      var bookmark = null;
      var tagList = null;

      beforeEach(function() {
        tagList = new can.Observe.List(["One", "Two"]);
        bookmark = new TaggedBookmark({tagList:tagList});
      });
       
      it("initializes tagsAsString from tagList", function() {
        expect(bookmark.attr("tagsAsString")).toBe("One, Two");
      });

      it("sets ordered tagList from tagsAsString change", function() {
        bookmark.attr("tagsAsString", "Three, Four");
        expect(tagList.length).toBe(2);
        expect(tagList[0], "Four");
        expect(tagList[1], "Three");
      });

      it("filters out blanks from tagsAsString", function() {
        bookmark.attr("tagsAsString", ", Four, , ,,");
        expect(tagList.length).toBe(1);
        expect(tagList[0], "Four");
      });

      it("sets empty tagList from blank or just commas", function() {
        bookmark.attr("tagsAsString", ", , ");
        expect(tagList.length).toBe(0);

        bookmark.attr("tagsAsString", " ");
        expect(tagList.length).toBe(0);
      });
    });
  });
  describe("app/tagfilter/bookmark_list view template", function() {
    it("displays a list of bookmarks with link tags", function() {
      var tagList = ["Tag 1", "Tag 2"];
      var bookmarks = [
        {id: 1, url:"http://one.com", title:"One", tagList:tagList},
        {id: 2, url:"http://two.com", title:"Two"}
      ];
      var model = {bookmarks:bookmarks};
      var el = $("<div/>").append("/app/tagfilter/bookmark_list", model);

      expect(el.find("li").size()).toBe(bookmarks.length);
      expect(el.find("a.tag").size()).toBe(tagList.length);
      expect(el.find("a.tag:first").html()).toBe(tagList[0]);
    });
  });
  describe("TagFilterBookmarkListControl", function() {
    var eventHub = null;
    var bookmark = null;
    var element = null;
    var control = null;
    var filterObject = null;

    beforeEach(function() {
      eventHub = new can.Observe({});
      element = $("<div/>");
      bookmark = new Bookmark({url:"http://one.com", title:"One",
        tagList:["Tag A", "Tag B"]});
      var bookmarks = new Bookmark.List([bookmark]);
      filterObject = new can.Observe({});
      var options = {eventHub:eventHub, bookmarks:bookmarks,
        filterObject:filterObject};
      control = new TagFilterBookmarkListControl(element, options);

      eventHub.attr("bookmarks", bookmarks);
    });

    it("triggers filterTag", function(done) {
      filterObject.bind("filterTag", function() { done(); });
      element.find("a.tag").click();
    });
  });
  describe("tagfilter/tag_list view template", function() {
    it("displays a list of tags with bookmark counts and links", function() {
      var selector = "li:first a";
      var tags = [
        {label:"One", bookmarkCount:1},
        {label:"Two", bookmarkCount:2}
      ];
      var model = {bookmarks:{tags:tags}};
      var el = $("<div/>").append("/app/tagfilter/tag_list", model);
      expect(el.find("li").size()).toBe(tags.length);
      expect(el.find(selector).html()).toBe("One (1)");
    });
  });
  describe("TagListControl", function() {
    it("renders the tag list", function() {
      var el = $("<div/>");
      var bookmarks = new TaggedBookmark.List([
        new TaggedBookmark({url:"http://one.com", title:"One",
          tagList:new can.Observe.List(["Tag2","Tag1"])}),
        new TaggedBookmark({url:"http://two.com", title:"Two",
          tagList:new can.Observe.List(["Tag3","Tag1"])})]);
      new TagListControl(el, {bookmarks:bookmarks});
      expect(el.find("li:first a").html()).toBe("Tag1 (2)");
    });
  });
  describe("App_tagfilter", function() {
    it("initializes (sanity check)", function() {
      new App_tagfilter();
      expect(true).toBe(true);
    });
  });
});
