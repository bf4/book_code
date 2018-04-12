import { EventEmitter,
         Component,
         OnInit    } from "@angular/core";
import   template    from "./template.html";

@Component({
  selector: "shine-text-field",
  template: template,
  inputs: [
    "object",
    "field_name",
    "label",
    "pattern",
    "compact",
    "addon"
  ],
  outputs: [
    "valueChanged"
  ]
})
export class TextFieldComponent implements OnInit {
  object: Object;
  field_name: string;
  label: string;
  pattern: string;
  compact: boolean;
  addon: string;
  originalValue: string;
  valueChanged: EventEmitter<any>;

  constructor() {
    this.object     = null;
    this.field_name = null;
    this.label      = null;
    this.pattern    = null;
    this.compact    = false;
    this.addon      = null;
    this.valueChanged = new EventEmitter();
  }

  modelValid(model):boolean {
    return !(model.invalid && model.dirty);
  }

  validationPattern():string {
    if (this.pattern) {
      return this.pattern;
    }
    else {
      return "^.*$";
    }
  }
  ngOnInit():void {
    if (this.object && this.field_name) {
      this.originalValue = this.object[this.field_name];
    }
    else {
      this.originalValue = null;
    }
  }
  blur(model):void {
    if (this.modelValid(model)) {
      if (this.originalValue != model.value) {
        this.valueChanged.emit({
          field_name: this.field_name,
          value: model.value
        });
        this.originalValue = model.value;
      }
    }
  }
}
