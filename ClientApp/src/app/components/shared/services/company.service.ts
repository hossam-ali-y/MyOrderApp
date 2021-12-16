import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Company } from 'src/app/modals/company.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CompanyService {

  url = environment.url;
  companies: Company[] = []

  constructor(private http: HttpClient) { }

  public getCompanies() {
    return this.http.get(this.url + '/companies')
  }

}
