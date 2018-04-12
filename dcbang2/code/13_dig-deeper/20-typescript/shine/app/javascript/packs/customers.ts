import "polyfills";

import { Component, NgModule    } from "@angular/core";
import { BrowserModule          } from "@angular/platform-browser";
import { FormsModule            } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { HttpModule             } from "@angular/http";
import { RouterModule           } from "@angular/router";

import { CustomerSearchComponent  } from "CustomerSearchComponent";
import { CustomerDetailsComponent } from "CustomerDetailsComponent";
import { CustomerInfoComponent    } from "CustomerDetailsComponent/CustomerInfoComponent";
import { AddressComponent         } from "CustomerDetailsComponent/AddressComponent";
import { CreditCardComponent      } from "CustomerDetailsComponent/CreditCardComponent";
import { TextFieldComponent       } from "TextFieldComponent";
import { NameCasePipe             } from "NameCasePipe";

import intl from "intl";
import "intl/locale-data/jsonp/en.js";

if (!window.hasOwnProperty("Intl")) {
  window["Intl"] = intl;
}
@Component({
  selector: "shine-customers-app",
  template: "<router-outlet></router-outlet>"
})
class AppComponent {}

let routing = RouterModule.forRoot( 
[
  {
    path: "",
    component: CustomerSearchComponent 
  },
  {
    path: ":id",
    component: CustomerDetailsComponent
  }
]);

@NgModule({
  imports:      [
    BrowserModule,
    FormsModule,
    HttpModule,
    routing
  ],
  declarations: [
    CustomerSearchComponent,
    CustomerDetailsComponent,
    CustomerInfoComponent,
    AddressComponent,
    CreditCardComponent,
    TextFieldComponent,
    NameCasePipe,
    AppComponent
  ],
  bootstrap: [ AppComponent ]
})
class CustomerAppModule {}

platformBrowserDynamic().bootstrapModule(CustomerAppModule);
