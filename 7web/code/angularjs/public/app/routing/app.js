/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
(function(app) {
  app.controller("BookmarkListController",
    function($scope, $routeParams, state,
      bookmarks, editBookmark, deleteBookmark) {
      $scope.bookmarks = bookmarks;
      $scope.bookmarkFilter = state.bookmarkFilter;
      state.bookmarkFilter.filterTag = $routeParams.tag;
      $scope.editBookmark = editBookmark;
      $scope.deleteBookmark = deleteBookmark;
    }
  );
  app.controller("TagListController",
    function($scope, $routeParams, state, bookmarks, buildTagList) {
      $scope.bookmarks = bookmarks;
      state.bookmarkFilter.filterTag = $routeParams.tag;
      $scope.$watch("bookmarks", function(updatedBookmarks) {
        $scope.tags = buildTagList(updatedBookmarks);
      }, true);
    }
  );
  app.controller("TagFilterController",
    function($scope, $routeParams, state) {
      $scope.bookmarkFilter = state.bookmarkFilter;
      state.bookmarkFilter.filterTag = $routeParams.tag;
    }
  );
})(
  angular.module("App_routing", ["ngResource", "App_tagfilter"],
    function($routeProvider) {
      var params = {
        controller: "BookmarkListController",
        templateUrl:"/app/routing/bookmark_list.html"
      };
      $routeProvider.
        when("/", params).
        when("/filter/:tag", params);
    }
  )
);
