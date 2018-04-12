import { Component } from "@angular/core";
import   template    from "./template.html";

var TextFieldComponent = Component({
  selector: "shine-text-field",
  template: template,
  inputs: [
    "object",
    "field_name",
    "label",
    "addon"
  ]
}).Class({
  constructor: [
    function() {
      this.object     = null;
      this.field_name = null;
      this.label      = null;
      this.addon      = null;
    }
  ]
});

export { TextFieldComponent };
