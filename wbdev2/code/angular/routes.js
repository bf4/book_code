/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
var ProductsApp = angular.module("products", ["ngResource", "ngRoute"]);

ProductsApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when("/", { controller: "ProductsCtrl" }).
    when("/products/new", {
      controller:  "ProductNewCtrl as productFormCtrl",
      templateUrl: "/templates/form.html"
    }).
    when("/products/:id/edit", {
      controller:  "ProductEditCtrl as productFormCtrl",
      templateUrl: "/templates/form.html"
    }).
    when("/products/:id", {
      controller:  "ProductCtrl as productCtrl",
      templateUrl: "/templates/show.html"
    }).
    otherwise({ redirectTo: "/" });
}]);
