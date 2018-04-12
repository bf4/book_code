import { Component } from "@angular/core";
import { Http      } from "@angular/http";
import { Router    } from "@angular/router";
import   template    from "./template.html";
import { AjaxFailureHandler } from "AjaxFailureHandler";

var CustomerSearchComponent = Component({

  selector: "shine-customer-search",
  template: template,
  providers: [
    AjaxFailureHandler
  ]
}).Class({
  constructor: [
    Http,
    Router,
    AjaxFailureHandler,
    function(http,router,ajaxFailureHandler) {
      this.customers = null;
      this.http      = http;
      this.ajaxFailureHandler = ajaxFailureHandler;
      this.keywords  = "";
      this.router    = router;
    }
  ],
  viewDetails: function(customer) {
    this.router.navigate(["/",customer.id]);
  },
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
      self.ajaxFailureHandler.handler()
    );
  }
});

export { CustomerSearchComponent };
