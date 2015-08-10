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
          '$routeProvider',
  function($routeProvider) {

  $routeProvider.when('/',{
    templateUrl: 'customer_search.html',
     controller: 'CustomerSearchController'
  }).when('/:id',{
    templateUrl: 'customer_details.html',
     controller: 'CustomerDetailsController'
  });
}]);

app.controller("CustomerSearchController", [ 
          '$scope','$http', '$location',
  function($scope , $http ,  $location) {                         

    // rest of controller...


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

    $scope.viewDetails = function(customerId) {
      $location.path("/" + customerId);
    }
  }
]);

app.controller("CustomerDetailsController", [
          '$scope',
  function($scope) {
  }
]);
