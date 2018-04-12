import { EventEmitter,
         Component } from "@angular/core";
import   template    from "./AddressComponent.html";

var AddressComponent = Component({
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
}).Class({
  constructor: [
    function() {
      this.address        = null;
      this.addressType    = null;
      this.icon           = "envelope";
      this.addressChanged = new EventEmitter();
    }
  ],
  save: function(update) {
    this.addressChanged.emit(update);
  }
});

export { AddressComponent };
