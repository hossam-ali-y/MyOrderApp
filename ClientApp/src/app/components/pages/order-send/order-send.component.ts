import { Component, OnInit } from '@angular/core';
import { OrdersService } from '../../shared/services/orders.service';

@Component({
  selector: 'app-order-send',
  templateUrl: './order-send.component.html',
  styleUrls: ['./order-send.component.scss']
})
export class OrderSendComponent implements OnInit {

  constructor(public orderService:OrdersService) { }

  ngOnInit(): void {
  }

}
