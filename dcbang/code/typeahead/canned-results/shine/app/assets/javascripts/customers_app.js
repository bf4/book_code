/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
var app = angular.module('customers',[]); 

app.controller("CustomerSearchController", [ 
          '$scope',                          
  function($scope) {                         
    $scope.customers = [];
    $scope.search = function(searchTerm) {   
      $scope.customers = [
        {
          "first_name":"Schuyler",
          "last_name":"Cremin",
          "email":"giles0@macgyver.net",
          "username":"jillian0",
          "created_at":"2015-03-04",
        },
        {
          "first_name":"Derick",
          "last_name":"Ebert",
          "email":"lupe1@rennerfisher.org",
          "username":"ubaldo_kaulke1",
          "created_at":"2015-03-04",
        },
        {
          "first_name":"Derick",
          "last_name":"Johnsons",
          "email":"dj@somewhere.org",
          "username":"djj",
          "created_at":"2015-03-04",
        }
      ]
      
    }
  }
]);
