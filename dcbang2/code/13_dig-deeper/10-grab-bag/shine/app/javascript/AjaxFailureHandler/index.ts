import { Class } from "@angular/core";

var AjaxFailureHandler = Class({
  constructor: function() {},
  handler: function() {
    return function(response) {
      window.alert(response);
    };
  }
});

export { AjaxFailureHandler };
