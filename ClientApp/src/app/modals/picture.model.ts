import { Product } from "./product.model";

export interface Picture {
  id: number;
  productId: number;
  picture1: string;
  note: string;
  product: Product;
}
