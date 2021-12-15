import { Cart } from "./cart-item";

export interface Order {
  id: number;
  customerName: string;
  customerEmail: string;
  customerPhone: string;
  status: number;
  note: string;
  createdDate: string | null;
  shippedDate: string | null;
  deliveredDate: string | null;
  totalPrice: number;
  carts: Cart[];
}
