/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
var app = angular.module(
  'customers',
  [
    'ngRoute',
    'templates'
  ]
); 

app.config([
          "$routeProvider",
  function($routeProvider) {
    $routeProvider.when("/", {
       controller: "CustomerSearchController",
      templateUrl: "customer_search.html"
    }).when("/:id",{
       controller: "CustomerDetailController",
      templateUrl: "customer_detail.html"
    });
  }
]);

app.controller("CustomerSearchController", [ 
          '$scope','$http','$location',
  function($scope , $http , $location) {                         

   // rest of controller....


    var page = 0;

    $scope.customers = [];
    $scope.search = function(searchTerm) {   
      $scope.loading = true;
      if (searchTerm.length < 3) {
        return;
      }
      $http.get("/customers.json",  
                { "params": { "keywords": searchTerm, "page": page } }
      ).success(
        function(data,status,headers,config) { 
          $scope.customers = data;
          $scope.loading = false;
      }).error(
        function(data,status,headers,config) {
          $scope.loading = false;
          alert("There was a problem: " + status);
        });
    }

    $scope.previousPage = function() {
      if (page > 0) {
        page = page - 1;
        $scope.search($scope.keywords);
      }
    }
    $scope.nextPage = function() {
      page = page + 1;
      $scope.search($scope.keywords);
    }

    $scope.viewDetails = function(customer) {
      $location.path("/" + customer.id);
    }
  }
]);
app.controller("CustomerDetailController", [ 
          "$scope","$http","$routeParams",
  function($scope , $http , $routeParams) {

    // Make the AJAX call and set $scope.customer...

    var customerId = $routeParams.id;
    $scope.customer = {};

    $http.get(
      "/customers/" + customerId + ".json"
    ).success(function(data,status,headers,config) {
      $scope.customer = data;
    }).error(function(data,status,headers,config) {
      alert("There was a problem: " + status);
    });
  }
]);
