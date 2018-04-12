import { Component, OnChanges, SimpleChange } from "@angular/core";
import { Http      } from "@angular/http";
import   template    from "./CreditCardComponent.html";

import { AjaxFailureHandler } from "AjaxFailureHandler";

@Component({
  selector: "shine-credit-card",
  inputs: [
    "cardholder_id"
  ],
  providers: [
    AjaxFailureHandler
  ],
  template: template
})
export class CreditCardComponent implements OnChanges {
  credit_card_info: Object;
  cardholder_id: string;

  constructor(private http: Http,
              private ajaxFailureHandler: AjaxFailureHandler) {
    this.cardholder_id      = null;
  }

  ngOnChanges(changes: {[propKey: string]: SimpleChange}) {
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
  }

  fetchCreditCardInfo():void {
    let self = this;
    self.http.get("/credit_card_info/" + self.cardholder_id).
      subscribe(
        function(response) {
          self.credit_card_info = response.json().credit_card_info;
        },
        self.ajaxFailureHandler.handler()
    );
  }
}
