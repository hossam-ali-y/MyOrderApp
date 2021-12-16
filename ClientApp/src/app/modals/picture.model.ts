import { Product } from "./product.model";

export class Picture {
  id: number;
  productId: number;
  big: string;
  small: string;
  note: string;

  product: Product;
}
