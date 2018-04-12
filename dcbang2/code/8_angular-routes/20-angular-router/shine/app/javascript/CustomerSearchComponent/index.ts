import { Component } from "@angular/core";
import { Http      } from "@angular/http";
import   template    from "./template.html";

var CustomerSearchComponent = Component({

  selector: "shine-customer-search",
  template: template
}).Class({
  constructor: [
    Http,
    function(http) {
      this.customers = null;
      this.http      = http;
      this.keywords  = "";
    }
  ],
  search: function($event) {
    var self = this;
    self.keywords = $event;
    if (self.keywords.length < 3) {
      return;
    }
    self.http.get(
      "/customers.json?keywords=" + self.keywords
    ).subscribe(
      function(response) {
        self.customers = response.json().customers;
      },
      function(response) {
        window.alert(response);
      }
    );
  }
});

export { CustomerSearchComponent };
