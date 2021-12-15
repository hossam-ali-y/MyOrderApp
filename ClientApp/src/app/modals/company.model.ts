import { Product } from "./product.model";

export interface Company {
  id: number;
  companyName: string;
  address: string;
  owner: string;
  manager: string;
  ownerPhone: string;
  managerPhone: string;
  logo: string;
  openingDate: string | null;
  closingDate: string | null;
  products: Product[];
}
