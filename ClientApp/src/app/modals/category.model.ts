import { Product } from "./product.model";

export class Category {
  id: number;
  categoryName: string;
  description: string;
  products: Product[];
}
