import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Order } from 'src/app/modals/order.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {

  url = environment.url;
  // orders: Order[] = []

  order: Order = {
    id: 0,
    customerName: '',
    customerEmail: '',
    customerPhone: '',
    cartItems: [],

  };

  constructor(private http: HttpClient) { }

  public getOrders() {
    return this.http.get(this.url + '/orders')
  }


  public addOrder() {
    return this.http.post(this.url + '/orders', this.order)
  }

  public editOrder() {
    return this.http.put(this.url + '/orders/' + this.order.id, this.order)
  }

  public deleteOrder(orderId: number) {
    return this.http.delete(this.url + '/orders/' + orderId)
  }

}
