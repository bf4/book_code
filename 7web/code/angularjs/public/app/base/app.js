/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
(function(app) {
  // define factories, controllers, etc. on app
  app.factory("Bookmark", function($resource) {
    return $resource("/bookmarks/:id", {id:"@id"});
  });
  app.factory("bookmarks", function(Bookmark) {
    return Bookmark.query();
  });
  app.factory("deleteBookmark", function(bookmarks) {
    return function(bookmark) {
      var index = bookmarks.indexOf(bookmark);
      bookmark.$delete();
      bookmarks.splice(index, 1);
    };
  });
  app.service("state", function(Bookmark) {
    this.formBookmark = {bookmark:new Bookmark()};
    this.clearForm = function() {
      this.formBookmark.bookmark = new Bookmark();
    };
  });
  app.factory("editBookmark", function(state) {
    return function(bookmark) {
      state.formBookmark.bookmark = bookmark;
    };
  });
  /*
  app.factory("saveBookmark", function(bookmarks) {
  */
  app.factory("saveBookmark", function(bookmarks, state) {
    return function(bookmark) {
      if (!bookmark.id) {
        bookmarks.push(bookmark);
      }
      bookmark.$save();
      state.clearForm();
    };
  });

  app.controller("BookmarkListController",
  /*
    function($scope, bookmarks) {
      $scope.bookmarks = bookmarks;
    }
  */
    function($scope, bookmarks, deleteBookmark, editBookmark) {
      $scope.bookmarks = bookmarks;
      $scope.deleteBookmark = deleteBookmark;
      $scope.editBookmark = editBookmark;
    }
  );
  app.controller("BookmarkFormController",
    function($scope, state, bookmarks, saveBookmark) {
      $scope.formBookmark = state.formBookmark;
      $scope.saveBookmark = saveBookmark;
      $scope.clearForm = state.clearForm;
    }
  );
})(
  angular.module("App_base", ["ngResource"])
);
