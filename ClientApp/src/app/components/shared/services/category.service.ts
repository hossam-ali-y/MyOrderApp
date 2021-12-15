import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Category } from 'src/app/modals/category.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  url = environment.url;
  categories: Category[] = []
  constructor(private http: HttpClient) { }

 public getCategories() {
    return this.http.get(this.url + '/categories').subscribe((res: Category[]) => {
      this.categories = res
    }, err => {
      console.log(err);
    })
  }

}
