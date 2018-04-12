import { Pipe } from "@angular/core";

var NameCasePipe = Pipe({
  name: "nameCase"
}).Class({
  constructor: function() {},

  transform: function(value) {
    if (!value) { return value; }

    if ( (value.toLowerCase() === value) ||
         (value.toUpperCase() === value) ) {

      return value.charAt(0).toUpperCase() +
             value.slice(1).toLowerCase();

    }
    else {
      return value;
    }
  }
});

export { NameCasePipe };
