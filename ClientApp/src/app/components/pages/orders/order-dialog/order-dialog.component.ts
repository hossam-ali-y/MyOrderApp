import { Component, Inject, Input, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Order } from 'src/app/modals/order.model';

@Component({
  selector: 'app-order-dialog',
  templateUrl: './order-dialog.component.html',
  styleUrls: ['./order-dialog.component.scss']
})
export class OrderDialogComponent implements OnInit {

  // @Input() orderCartItems
  constructor( public dialogRef: MatDialogRef<OrderDialogComponent>, @Inject(MAT_DIALOG_DATA) public order: Order) { }

  ngOnInit(): void {
  }

  public close(): void {
    this.dialogRef.close();
  }

}
