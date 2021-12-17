import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'replace'
})
export class ReplacePipe implements PipeTransform {

  transform(value) {
    value = value.replace(" ", "-")
    console.log(value);

    return value;
  }

}
