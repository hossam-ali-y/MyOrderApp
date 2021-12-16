import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { CompanyService } from 'src/app/components/shared/services/company.service';
import { Company } from 'src/app/modals/company.model';


@Component({
  selector: 'app-brands',
  templateUrl: './brands.component.html',
  styleUrls: ['./brands.component.sass']
})
export class BrandsComponent implements OnInit {

  // brands: string[] = ['الكل', 'Lenovo', 'Dell', 'Dell', 'Lg', 'Samsung'];
  // brands: string[] = ['all', 'Brand-1', 'Brand-2', 'Brand-3', 'Brand-4', 'Brand-5'];
  companies: Company[] = []

  @Output() brandChanged = new EventEmitter();
  constructor(public companyService: CompanyService) { }

  ngOnInit() {
    this.getCompanies()
  }

  getCompanies() {
    this.companyService.getCompanies().subscribe((res: Company[]) => {
      this.companies = res

    }, err => {
      console.log(err);
    })
  }

  brendSelect(event) {
    this.brandChanged.emit(
      event.value
    );
  }

}
