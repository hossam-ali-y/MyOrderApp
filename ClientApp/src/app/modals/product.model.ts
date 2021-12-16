import { CartItem } from "./cart-item";
import { Category } from "./category.model";
import { Company } from "./company.model";
import { Picture } from "./picture.model";

// Product Tag
export type ProductTags = 'nike' | 'puma' | 'lifestyle' | 'caprese';

// Product Colors
export type ProductColor = 'white' | 'black' | 'red' | 'green' | 'purple' | 'yellow' | 'blue' | 'gray' | 'orange' | 'pink';

export class Product {
  id?: number;
  name?: string;
  price?: number;
  salePrice?: number | null;
  discount?: number | null;
  shortDetails?: string;
  description?: string;
  stock?: number | null;
  brand?: string;
  sale?: boolean | null;
  tags?: string;
  colors?: string;
  categoryId?: number | null;
  companyId?: number | null;

  category?: Category;
  company?: Company;
  cartItems?: CartItem[];
  pictures?: Picture[];

  constructor(
    id?: number,
    name?: string,
    price?: number,
    salePrice?: number,
    discount?: number,
    pictures?: Picture[],
    shortDetails?: string,
    description?: string,
    stock?: number,
    // newPro?: boolean,
    brand?: string,
    sale?: boolean,
    category?: Category,
    tags?: string,
    colors?: string
  ) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.salePrice = salePrice;
    this.discount = discount;
    this.pictures = pictures;
    this.shortDetails = shortDetails;
    this.description = description;
    this.stock = stock;
    // this.newPro = newPro;
    this.brand = brand;
    this.sale = sale;
    this.category = category;
    this.tags = tags;
    this.colors = colors;
  }

 }
  // Color Filter
  export interface ColorFilter {
    color?: ProductColor;
  }

  // export class Product {
//   id?: number;
//   name?: string;
//   price?: number;
//   salePrice?: number;
//   discount?: number;
//   pictures?: string;
//   shortDetails?: string;
//   description?: string;
//   stock?: number;
//   newPro?: boolean;
//   brand?: string;
//   sale?: boolean;
//   category?: string;
//   tags?: ProductTags[];
//   colors?: ProductColor[];

