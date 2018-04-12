import { EventEmitter,
         Component } from "@angular/core";
import   template    from "./AddressComponent.html";

@Component({
  selector: "shine-address",
  inputs: [
    "address",
    "addressType",
    "icon"
  ],
  outputs: [
    "addressChanged"
  ],
  template: template
})
export class AddressComponent {
  address: Object;
  addressType: string;
  icon: string;
  addressChanged: EventEmitter<Object>;

  constructor() {
    this.address        = null;
    this.addressType    = null;
    this.icon           = "envelope";
    this.addressChanged = new EventEmitter();
  }
  save(update: Object):void {
    this.addressChanged.emit(update);
  }
}
