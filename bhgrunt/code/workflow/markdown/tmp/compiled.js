/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
(function() {
  this.MarkdownEditor = angular.module("markdownEditor", []);

}).call(this);

(function() {
  this.MarkdownEditor.factory("MarkdownConverter", function() {
    return {
      convert: function(input) {
        return markdown.toHTML(input);
      }
    };
  });

}).call(this);

(function() {
  this.MarkdownEditor.controller("MainCtrl", [
    '$scope', '$sce', 'MarkdownConverter', function($scope, $sce, MarkdownConverter) {
      return $scope.updatePreview = function() {
        var converted;
        converted = MarkdownConverter.convert($scope.input);
        return $scope.output = $sce.trustAsHtml(converted);
      };
    }
  ]);

}).call(this);
