import { CartItem } from "./cart-item";

export class Order {
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
  cartItems: CartItem[];
}
