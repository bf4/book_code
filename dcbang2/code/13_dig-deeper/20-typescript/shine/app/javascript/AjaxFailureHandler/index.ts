import { Injectable } from "@angular/core";

@Injectable()
export class AjaxFailureHandler {
  handler(): (any) => void {
    return function(response) {
      window.alert(response);
    };
  }
}
