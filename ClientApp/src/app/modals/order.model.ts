import { CartItem } from "./cart-item";

export class Order {
  id?: number;
  customerName?: string;
  customerLastName?: string;
  customerEmail?: string;
  customerPhone?: string;
  customerCompanyName?: string;
  customerAddress?: string;
  country?: string;
  city?: string;
  zipCode?: string;
  status?: number;
  note?: string;
  createdDate?: string | null;
  shippedDate?: string | null;
  deliveredDate?: string | null;
  totalPrice?: number;

  cartItems?: CartItem[];
}
