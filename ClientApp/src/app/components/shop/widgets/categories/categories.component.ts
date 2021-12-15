import { Component, OnInit } from '@angular/core';
import { CategoryService } from 'src/app/components/shared/services/category.service';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.sass']
})
export class CategoriesComponent implements OnInit {

  constructor(public categoryService:CategoryService) { }

  ngOnInit() {
    this.categoryService.getCategories()
  }

}
