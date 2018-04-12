import { Component, OnInit }      from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import { Http }           from "@angular/http";
import                         "rxjs/add/operator/map";
import   template         from "./template.html";
import { AjaxFailureHandler } from "AjaxFailureHandler";

@Component({
  selector: "shine-customer-details",
  template: template,
  providers: [
    AjaxFailureHandler
  ]
})
export class CustomerDetailsComponent implements OnInit {
  id: string;
  customer: any;

  constructor(private activatedRoute: ActivatedRoute,
              private http: Http,
              private ajaxFailureHandler: AjaxFailureHandler) {

    this.id       = null;
    this.customer = null;

  }

  ngOnInit():void {
    let self = this;
    let parseCustomer = function(response) {
      let customer = response.json().customer;

      customer.billing_address = {
        street:  customer.billing_street,
        city:    customer.billing_city,
        state:   customer.billing_state,
        zipcode: customer.billing_zipcode
      };

      customer.shipping_address = {
        street:  customer.shipping_street,
        city:    customer.shipping_city,
        state:   customer.shipping_state,
        zipcode: customer.shipping_zipcode
      };

      return customer;
    }
    let routeSuccess = function(params) {
      let observable = self.http.get(
        "/customers/" + params["id"] + ".json"
      );
      let mappedObservable = observable.map(parseCustomer)

      mappedObservable.subscribe(
        function(customer) { self.customer = customer; },
        self.ajaxFailureHandler.handler()
      );
    }
    self.activatedRoute.params.subscribe(routeSuccess,self.ajaxFailureHandler.handler());
  }
  saveCustomerField(field_name: string, value: string) {
    let update = {};
    update[field_name] = value;
    this.http.patch(
      "/customers/" + this.customer.customer_id + ".json", update
    ).subscribe(
      function() {},
      function(response) {
        window.alert(response);
      }
    );
  }
  saveCustomer(update:any) {
    this.saveCustomerField(update.field_name, update.value);
  }
  saveShippingAddress(update:any) {
    this.saveCustomerField("shipping_" + update.field_name, update.value);
  }
  saveBillingAddress(update:any) {
    this.saveCustomerField("billing_" + update.field_name, update.value);
  }
}
