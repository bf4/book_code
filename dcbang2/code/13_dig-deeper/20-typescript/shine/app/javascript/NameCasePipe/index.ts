import { Pipe, PipeTransform } from "@angular/core";

@Pipe({ name: "nameCase" })
export class NameCasePipe implements PipeTransform {
  transform(value: string):string {
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
}
