import { Component }      from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import { Http }           from "@angular/http";
import   template         from "./template.html";

var CustomerDetailsComponent = Component({
  selector: "shine-customer-details",
  template: template
}).Class({
  constructor: [
    ActivatedRoute,
    Http,
    function(activatedRoute,http) {
      this.activatedRoute = activatedRoute;
      this.http           = http;
      this.id             = null;
      this.customer       = null;
    }
  ],
  ngOnInit: function() {
    var self = this;
    var observableFailed = function(response) {
      alert(response);
    }

    // more to come...

    var customerGetSucces = function(response) {
      self.customer = response.json().customer;
    }
    var routeSuccess = function(params) {
      self.http.get(
        "/customers/" + params["id"] + ".json"
      ).subscribe(
        customerGetSucces,
        observableFailed
      );
    }
    self.activatedRoute.params.subscribe(routeSuccess,observableFailed);
  },
});
export { CustomerDetailsComponent };
