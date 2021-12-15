import { Product } from "./product.model";

export interface Category {
  id: number;
  categoryName: string;
  description: string;
  products: Product[];
}
