import { EventEmitter,
         Component } from "@angular/core";
import   template    from "./CustomerInfoComponent.html";

@Component({
  selector: "shine-customer-info",
  inputs: [
    "customer"
  ],
  outputs: [
    "customerInfoChanged"
  ],
  template: template
})
export class CustomerInfoComponent {
  customer: Object;
  customerInfoChanged: EventEmitter<Object>;

  constructor() {
    this.customer            = null;
    this.customerInfoChanged = new EventEmitter();
  }
  save(update:Object):void {
    this.customerInfoChanged.emit(update);
  }
}
