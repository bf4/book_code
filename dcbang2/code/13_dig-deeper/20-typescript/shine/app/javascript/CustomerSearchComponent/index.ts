import { Component } from "@angular/core";
import { Http      } from "@angular/http";
import { Router    } from "@angular/router";
import   template    from "./template.html";
import { AjaxFailureHandler } from "AjaxFailureHandler";

@Component({
  selector: "shine-customer-search",
  template: template,
  providers: [
    AjaxFailureHandler
  ]
})
export class CustomerSearchComponent {

  customers: Array<any>;
  keywords: String;

  constructor(private http: Http,
              private router: Router,
              private ajaxFailureHandler: AjaxFailureHandler) {
    this.customers = null;
    this.keywords = "";
  }
  viewDetails(customer) {
    this.router.navigate(["/",customer.id]);
  }
  search($event) {
    let self = this;
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
}
