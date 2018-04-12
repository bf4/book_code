import { Component } from "@angular/core";
import { Http      } from "@angular/http";
import   template    from "./CreditCardComponent.html";

import { AjaxFailureHandler } from "AjaxFailureHandler";

var CreditCardComponent = Component({
  selector: "shine-credit-card",
  inputs: [
    "cardholder_id"
  ],
  providers: [
    AjaxFailureHandler
  ],
  template: template
}).Class({
  constructor: [
    Http,
    AjaxFailureHandler,
    function(http,ajaxFailureHandler) {
      this.http               = http;
      this.cardholder_id      = null;
      this.ajaxFailureHandler = ajaxFailureHandler;
    }
  ],
  ngOnChanges: function(changes) {
    if (changes.cardholder_id) {
      if (changes.cardholder_id.currentValue) {
        this.cardholder_id = changes.cardholder_id.currentValue;
        this.fetchCreditCardInfo();
      }
      else {
        this.cardholder_id    = null;
        this.credit_card_info = null;
      }
    }
  },

  // other methods...

  fetchCreditCardInfo: function() {
    var self = this;
    self.http.get("/credit_card_info/" + self.cardholder_id).
      subscribe(
        function(response) {
          self.credit_card_info = response.json().credit_card_info;
        },
        self.ajaxFailureHandler.handler()
    );
  }
// BEGIN:ngOnChanges
});

export { CreditCardComponent };
