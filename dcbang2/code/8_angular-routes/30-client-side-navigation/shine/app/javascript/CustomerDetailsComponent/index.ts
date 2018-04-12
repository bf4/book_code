import { Component } from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import   template    from "./template.html";

var CustomerDetailsComponent = Component({
  selector: "shine-customer-details",
  template: template
}).Class({
  constructor: [
    ActivatedRoute,
    function(activatedRoute) {
      this.activatedRoute = activatedRoute;
      this.id             = null;
    }
  ],
  ngOnInit: function() {
    var self = this;
    self.activatedRoute.params.subscribe(function(params) {
      var id = +params['id'];
      self.id = id;
    });
  },
});
export { CustomerDetailsComponent };
