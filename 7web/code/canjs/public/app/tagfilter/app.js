/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
// Extend the validation bookmark model
var TaggedBookmark = ValidatingBookmark.extend({
  // ...
  init: function() {
    // Initialize tagsAsString from tagList
    var tagList = this.attr("tagList");

    if (tagList && tagList.length > 0) {
    this.attr("tagsAsString", tagList.join(", "));
    }
    else {
      this.attr("tagList", new can.Observe.List([]));
      this.attr("tagsAsString", "");
    }

    // Listen for changes on tagsAsString and set tagList
    this.bind("tagsAsString", this.onTagsAsStringChange);
  },
  onTagsAsStringChange: function(evt, tagsAsString) {
    // Split the string by comma and trim whitespace
    var trimmed = can.map(tagsAsString.split(","), can.trim);

    // Ignore empty tags, for example if the user entered a,,,b
    var byNotEmpty = function(tag) {
      return tag.length > 0;
    };
    var notEmpty = can.filter(trimmed, byNotEmpty);
    var tagList = this.attr("tagList");

    // Update the tag list to match the ones entered by the user
    tagList.attr(notEmpty.sort(), true);
    var forceUpdate = (notEmpty.length == tagList.length);
    if (forceUpdate) {
      can.trigger(this.attr("tagList"), "length");
    }
  }
});

TaggedBookmark.List = ValidatingBookmark.List.extend({
  // Returns a list of tags, each with label and bookmarkCount
  tags: function() {
    // Keep track of how many bookmarks per tag
    var bookmarkCounts = {};

    // Loop through each bookmark in the list
    this.each(function(bookmark) {
      var tagList = bookmark.attr("tagList");

      if (tagList) {
        // Loop through each tag associated to the bookmark
        tagList.each(function(tag) {
          var existing = bookmarkCounts[tag];
          // Either increase the existing count, or initialize to 1
          bookmarkCounts[tag] = existing ? existing + 1 : 1;
        });
      }
    });

    // The keys in bookmarkCounts are the tag labels
    var labels = Object.keys(bookmarkCounts);

    // Sort the tag labels
    labels.sort();

    // Return a list of tags with label and bookmark count
    return can.map(labels, function(label) {
      return {label:label, bookmarkCount:bookmarkCounts[label]};
    });
  }
});
var TaggedBookmarkFormControl = ValidatingBookmarkFormControl.extend({
  BookmarkModel: TaggedBookmark
});
var TagFilterBookmarkListControl = BookmarkListControl.extend({
  // Use the bookmark list view with the tag links
  view: "/app/tagfilter/bookmark_list",
  // Listen for clicks on tag links, set filterTag on filterObject
  "a.tag click": function(el, evt) {
    var tag = String(el.data("tag"));
    this.options.filterObject.attr("filterTag", tag);
  }
});
var TagListControl = can.Control.extend({
  defaults: {
    view: "/app/tagfilter/tag_list"
  }
}, {
  init: function(element, options) {
    this.eventHub = options.eventHub;
    var model = {bookmarks:options.bookmarks};
    element.html(options.view, model);
  },
  "a.tag click": function(el, evt) {
    var tag = el.data("tag");
    this.options.filterObject.attr("filterTag", tag.label);
  }
});
var TagFilterControl = can.Control.extend({
  defaults: {
    view: "/app/tagfilter/tag_filter"
  }
}, {
  init: function(element, options) {
    this.element.html(options.view, options.filterObject);
  },
  "a.clear click": function(el, evt) {
    this.options.filterObject.attr("filterTag", "");
  }
});
var App_tagfilter = can.Construct.extend({
  init: function() {
    var filterObject = new can.Observe({
      filterTag: "" // the filter tag is initially blank
    });
    var filterFunction = function(bookmark) {
      var tagList = bookmark.attr("tagList");
      var filterTag = filterObject.attr("filterTag");
      var noFilter = (!filterTag) || (filterTag.length == 0);
      var tagListContainsFilterTag = tagList && tagList.indexOf(filterTag) > -1;
      return noFilter || tagListContainsFilterTag;
    };

    TaggedBookmark.findAll({}, function(bookmarks) {
      var eventHub = new can.Observe({});
      // Pass filterObject to the controls
      var options = {eventHub:eventHub, bookmarks:bookmarks,
        filterObject:filterObject};

      // Create the filtered bookmark list
      var filtered = bookmarks.filter(filterFunction);

      // Create an options object with the filtered bookmark list
      var filteredOptions = can.extend({}, options, {bookmarks:filtered});
      // ...

      var formView = "/app/tagfilter/bookmark_form";
      var formOptions = can.extend({}, options, {view:formView});

      // Create the bookmark list control with the filtered bookmark list
      new TagFilterBookmarkListControl("#bookmark_list_container", filteredOptions);
      // ...
      new TaggedBookmarkFormControl("#bookmark_form_container", formOptions);
      new TagListControl("#tag_list_container", options);
      new TagFilterControl("#filter_container", options);
    });
  }
});
