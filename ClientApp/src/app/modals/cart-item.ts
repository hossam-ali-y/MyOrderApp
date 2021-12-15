import { Order } from './order.model';
import { Product } from './product.model';

export class CartItem {
  id?: number;
  productId?: number;
  orderId?: number;
  quantity?: number | null;
  unitPrice?: number | null;
  order?: Order;
  product?: Product;
}

// cart items
// export interface CartItem {
//   product: Product;
//   quantity: number;
// }

