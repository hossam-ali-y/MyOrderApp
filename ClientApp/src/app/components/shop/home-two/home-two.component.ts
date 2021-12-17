import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/modals/product.model';
import { CartItem } from 'src/app/modals/cart-item';
import { ProductService } from '../../shared/services/product.service';
import { CartService } from '../../shared/services/cart.service';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'app-home-two',
  templateUrl: './home-two.component.html',
  styleUrls: ['./home-two.component.sass']
})
export class HomeTwoComponent implements OnInit {


  products: Product[];
  public banners = [];

  shoppingCartItems: CartItem[] = [];
  wishlistItems  :   Product[] = [];

  public featuredProducts: Array<Product>;
  public onSaleProducts: Array<Product>;
  public topRatedProducts: Array<Product>;
  public newArrivalsProducts: Array<Product>;

  public slides = [
    { title: 'مبيعات هائلة', subtitle: 'تصل الى 70%', image: 'assets/images/carousel/banner1.jpg' },
    { title: 'أكبر خصم', subtitle: 'تحقق من الترقية', image: 'assets/images/carousel/banner2.jpg' },
    { title: 'أكبر مبيعات', subtitle: 'لا تفوتها', image: 'assets/images/carousel/banner3.jpg' },
    { title: 'أفضل منتجاتنا', subtitle: 'إختيار خاص', image: 'assets/images/carousel/banner4.jpg' },
    { title: 'مبيعات ضخمة', subtitle: 'فقط لهذا اليوم', image: 'assets/images/carousel/banner5.jpg' }
  ];

  constructor(private productService: ProductService, private cartService: CartService,private spinner:NgxSpinnerService) { }

  ngOnInit() {
    this.cartService.getItems().subscribe(shoppingCartItems => this.shoppingCartItems = shoppingCartItems);

    this.spinner.show()
    this.productService.getProducts()
    .subscribe(
      (products: Product[]) => {
        this.spinner.hide()
        this.products = products;
        // console.log(products);

      }
    )

    this.productService.getBanners()
    .subscribe(
      data => this.banners = data
    );

  }



}
