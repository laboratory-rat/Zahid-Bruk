import '../../services/shop_service.dart';
import '../ext/calc/calc.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:zahid_bruk_web/components/ext/product_cards/product_cards.dart';

@Component(
    selector: 'page-product',
    directives: const [COMMON_DIRECTIVES, Calc, ProductCards],
    templateUrl: 'page_product.html',
    styleUrls: const ['page_product.css'],
    providers: const [ShopService])
class PageProduct implements OnInit {
  final ShopService _shopService;
  final RouteParams _routeParams;
  final Router _router;

  PageProduct(this._shopService, this._routeParams, this._router);

  bool isLoading = true;

  int currentProductId;
  WCProduct currentProduct = null;
  List<WCProduct> variations = [];
  List<WCProduct> toSeeProducts = [];
  List<WPImage> gallery = [];
  String name = '';
  bool onSale = false;
  int basePrice = 0;
  int currentPrice = 0;
  WPImage currentImage = null;

  ProductOptions options = new ProductOptions();

  @override
  Future ngOnInit() async {
    try {
      currentProductId = int.parse(_routeParams.get('productId'));
    } catch (ex) {
      _router.navigate(['PageHome']);
    }

    currentProduct = await _shopService.getProductById(currentProductId);
    if (currentProduct == null) _router.navigate(['PageHome']);

    currentProduct.images = currentProduct.images.toList();
    gallery = currentProduct.images;
    name = currentProduct.name;
    onSale = currentProduct.on_sale;
    basePrice = currentPrice = currentProduct.price;
    currentImage = currentProduct.image;

    var loadVariations = await _shopService.getProductVariations(currentProductId);
    if (loadVariations != null) {
      variations = loadVariations;
    }

    if (currentProduct.relatedIds.length > 0) {
      toSeeProducts = (await _shopService.getProductsBatch(currentProduct.relatedIds.map((x) => x.toString()).toList())).toList();
    } else {
      toSeeProducts = (await _shopService.getProducts(0, 4)).toList();
    }

    isLoading = false;
  }

  String getSize() {
    if (currentProduct == null || currentProduct.dimensions == null) return '';

    return 'Д ' + currentProduct.dimensions.length + ' x Ш ' + currentProduct.dimensions.width + ' x В ' + currentProduct.dimensions.height;
  }

  String getColor(WCProduct p) {
    return p.attributes.first.option;
  }

  void changeColor(WCProduct color) {
    currentProduct = color;
    currentImage = color.image;
    if (color.price.toString().trim() != '')
      currentPrice = color.price;
    else
      currentPrice = basePrice;

    window.console.log(color.price);
  }

  void changeProduct(WCProduct product) {
    print(product.id);
    _router.navigate([
      'PageProduct',
      {'productId': product.id.toString()}
    ]);
  }
}

class ProductOptions {
  bool delivery = true;
  bool sidewalk = false;
  bool car = false;
}
