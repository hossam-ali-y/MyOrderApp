import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject, Subscriber } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Product } from 'src/app/modals/product.model';
import { MatSnackBar } from '@angular/material';
import { map } from 'rxjs/operators';
import { environment } from 'src/environments/environment';



// Get product from Localstorage
let products = JSON.parse(localStorage.getItem("compareItem")) || [];

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  public currency: string = 'USD';
  public catalogMode: boolean = false;

  // private _url: string = "assets/data/";
  public _url = "assets/data/banners.json";
  url = environment.url

  public compareProducts: BehaviorSubject<Product[]> = new BehaviorSubject([]);
  public observer: Subscriber<{}>;

  constructor(private http: HttpClient, public snackBar: MatSnackBar) {
    this.compareProducts.subscribe(products => products = products)
  }


  private products(): Observable<Product[]> {
    return this.http.get<Product[]>(this.url + '/products/')
    // return this.http.get<Product[]>('assets/data/products2.json');
  }

  private productsSorted(orderBy): Observable<Product[]> {
    return this.http.post<Product[]>(this.url + '/products/sort/', [orderBy])
    // return this.http.get<Product[]>('assets/data/products2.json');
  }

  public banners(): Observable<any[]> {
    return this.http.get<any[]>(this._url);
  }


  // Get Banners
  public getBanners() {
    return this.banners();
  }

  // Get Products
  public getProducts(): Observable<Product[]> {
    // return this.products();
    return this.products()
  }

  public getProductsSortred(val): Observable<Product[]> {
    // return this.products();
    return this.productsSorted(val)
  }


  // Get Products By Id
  public getProduct(id: number): Observable<Product> {
    return this.products().pipe(map(items => {
      return items.find((item: Product) => { return item.id === id; });
    }));
    // return this.products.find(product=> product.id === id);

    // return this.httpClient.get<Product>(this._url + 'product-' + id + '.json');
  }


  /*
---------------------------------------------
----------  Compare Product  ----------------
---------------------------------------------
*/

  // Get Compare Products
  public getComapreProducts(): Observable<Product[]> {
    const itemsStream = new Observable(observer => {
      observer.next(products);
      observer.complete();
    });
    return <Observable<Product[]>>itemsStream;
  }

  // If item is aleready added In compare
  public hasProduct(product: Product): boolean {
    const item = products.find(item => item.id === product.id);
    return item !== undefined;
  }

  // Add to compare
  public addToCompare(product: Product): Product | boolean {
    let message, status;
    var item: Product | boolean = false;
    if (this.hasProduct(product)) {
      item = products.filter(item => item.id === product.id)[0];
      const index = products.indexOf(item);
      this.snackBar.open(' المنتج ' + product.name + ' مضاف مسبقا في قائمة المقارنة. ', '×', { panelClass: 'error', verticalPosition: 'top', duration: 3000 });

    } else {
      if (products.length < 4)
        products.push(product);
      message = ' تمت إضافة المنتج ' + product.name + ' الى قائمة المقارنة. ';
      status = 'success';
      this.snackBar.open(message, '×', { panelClass: [status], verticalPosition: 'top', duration: 3000 });

    }
    localStorage.setItem("compareItem", JSON.stringify(products));
    return item;
  }

  // Removed Product
  public removeFromCompare(product: Product) {
    if (product === undefined) { return; }
    const index = products.indexOf(product);
    products.splice(index, 1);
    localStorage.setItem("compareItem", JSON.stringify(products));
  }

  // Get Products By category
  public getProductByCategory(categoryId) {
    if (categoryId > 0)
      return this.http.get(this.url + "/products/byCategory/" + categoryId)
    else if (categoryId == -1)
      return this.products();

    // return this.products().pipe(map(items =>
    //   items.filter((item: Product) => {
    //     if (categoryName == 'all')
    //       return item
    //     else
    //       return item.category?.categoryName=== categoryName;
    //   })
    // ));
  }

}
