import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { MatDialog, MatSnackBar } from '@angular/material';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { Order } from 'src/app/modals/order.model';
import { OrdersService } from '../../shared/services/orders.service';
import { ProductDialogComponent } from '../../shop/products/product-dialog/product-dialog.component';
import { CartComponent } from '../cart/cart.component';
import { OrderDialogComponent } from './order-dialog/order-dialog.component';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {

  // @Output() onOpenProductDialog: EventEmitter<any> = new EventEmitter();

  public orders: Order[] = [];

  constructor(public orderService: OrdersService, private dialog: MatDialog, private router: Router, private snackBar: MatSnackBar,
    private spinner: NgxSpinnerService) { }

  ngOnInit() {
    this.getOrders()
  }

  getOrders() {
    this.spinner.show();
    this.orderService.getOrders().subscribe((res: Order[]) => {
      this.orders = res
      this.spinner.hide();
      // console.log(this.orders);
    }, err => {
      this.spinner.hide();
      console.log(err);
    })
  }

  onOrderStatusChange(order: Order) {
    console.log(order);

    this.orderService.order = order;
    this.spinner.show();
    this.orderService.editOrder().subscribe((res: Order) => {
      this.snackBar.open('تم تعديل  حالة الطلب بنجاح', '×', { panelClass: ['success'], verticalPosition: 'top', duration: 3000 });

      this.orders.map(e => {
        if (res.id == e.id)
          return res
        else
          return e
      })
      this.spinner.hide();
    }, err => {
      this.snackBar.open('لم يتم تعديل  حالة الطلب ', '×', { panelClass: ['error'], verticalPosition: 'top', duration: 3000 });
      this.spinner.hide();
      console.log(err);
    })

  }

  deleteOrder(order: Order) {
    this.spinner.show();
    this.orderService.deleteOrder(order.id).subscribe(res => {
      this.snackBar.open('تم حذف الطلب بنجاح', '×', { panelClass: ['success'], verticalPosition: 'top', duration: 5000 });
      this.orders = this.orders.filter(e => e.id != order.id)
      this.spinner.hide();

    }, err => {
      this.snackBar.open('لم يتم حذف الطلب', '×', { panelClass: ['error'], verticalPosition: 'top', duration: 3000 });
      this.spinner.hide();
      console.log(err);
    })

  }

  public openProductDialog(order) {
    let dialogRef = this.dialog.open(OrderDialogComponent, {
      data: order,
      panelClass: 'product-dialog',
    });
    dialogRef.afterClosed().subscribe(product => {
      if (product) {
        this.router.navigate(['/products', product.id, product.name]);
      }
    });
  }

}
