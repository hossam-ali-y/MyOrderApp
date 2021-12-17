import { Component, OnInit } from '@angular/core';
import { CartService } from '../../shared/services/cart.service';
import { Observable, of } from 'rxjs';
import { CartItem } from 'src/app/modals/cart-item';
import { ProductService } from '../../shared/services/product.service';
import { OrdersService } from '../../shared/services/orders.service';
import { Order } from 'src/app/modals/order.model';
import { MatSnackBar } from '@angular/material';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.sass']
})
export class CheckoutComponent implements OnInit {

  public cartItems: Observable<CartItem[]> = of([]);
  public buyProducts: CartItem[] = [];

  amount: number;
  payments: string[] = ['إنشاء حساب?'];
  paymantWay: string[] = ['Direct Bank Transfer', 'PayPal'];

  constructor(private cartService: CartService, public productService: ProductService, public orderService: OrdersService,
    public snackBar: MatSnackBar, private router: Router, private spinner: NgxSpinnerService) { }

  ngOnInit() {
    this.cartItems = this.cartService.getItems();
    this.cartItems.subscribe(products => this.buyProducts = products);

    this.getTotal().subscribe(amount => this.amount = amount);
  }

  public getTotal(): Observable<number> {
    return this.cartService.getTotalAmount();
  }

  onSubmit(ngFormValid) {
    this.cartItems.subscribe(products => this.buyProducts = products);

    if (!(this.orderService.order.id > 0) && ngFormValid)
      this.addOrder()
  }

  addOrder() {
    this.cartItems.subscribe(cartItems => {
      if (!(cartItems.length > 0)) {
        this.snackBar.open('لايوجد طلبات في السلة', '×', { panelClass: ['error'], verticalPosition: 'top', duration: 3000 });
        return;
      }

      this.toOrder()
      this.spinner.show()
      this.orderService.addOrder().subscribe((res: Order) => {
        this.orderService.order = res
        // console.log(this.orderService.order);

        this.cartService.clearCart()

        this.spinner.hide()
        this.snackBar.open('تم إضافة طلبك بنجاح', '×', { panelClass: ['success'], verticalPosition: 'top', duration: 5000 });
        this.router.navigate(['/pages/done']);
      }, err => {
        this.spinner.hide()
        console.log(err);
      })
    })
  }

  toOrder() {
    this.orderService.order.cartItems = [];

    this.getTotal().subscribe(amount => this.orderService.order.totalPrice = amount);

    this.cartItems.subscribe(cartItems => {
      // console.log(cartItems);

      cartItems.forEach(cartItem => {
        this.orderService.order.cartItems.push({
          id: 0,
          orderId: 0,
          productId: cartItem.product.id,
          unitPrice: cartItem.unitPrice,
          quantity: cartItem.quantity,
        })
      });
      console.log(this.orderService.order)
    }
    );
  }

}
