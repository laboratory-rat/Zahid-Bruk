import '../../domain/ProductPackage.dart';
import '../../services/shop_service.dart';
import '../common/page_analytics.dart';
import '../ext/calc/calc.dart';
import '../ext/scroll_animation/scroll_animation.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:gtag_analytics/src/gtag_analytics.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:lr_storage/lr_storage.dart';
import 'package:zahid_bruk_web/components/ext/product_cards/product_cards.dart';
import 'package:zahid_bruk_web/components/page_product/page_product.dart';

@Component(
    selector: 'page-product',
    directives: const [COMMON_DIRECTIVES, Calc, ProductCards],
    templateUrl: 'page_product.html',
    styleUrls: const ['page_product.css'],
    providers: const [ShopService])
class PageProduct extends PageAnalytics implements OnInit {
  final ShopService _shopService;
  final RouteParams _routeParams;
  final Router _router;

  final LRStorage _storage = new LRStorage(prefix: 'product', type: LRStorageType.Session);

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

  String shortDescription = '';
  String description = '';

  ProductOptions options = new ProductOptions();

  @override
  Future ngOnInit() async {
    try {
      currentProductId = int.parse(_routeParams.get('productId'));
    } catch (ex) {
      _router.navigate(['PageHome']);
    }

    LRScrollAnimation.scroll('.breadcrumbs', duration: 275, offset: 60);

    // second realization

    // load main product

    var savedProductMap = null;
    if ((savedProductMap = _storage.load<WCProduct>(currentProductId.toString())) != null) {
      currentProduct = new WCProduct()..fromMap(savedProductMap);
    } else {
      currentProduct = await _shopService.getProductById(currentProductId);
      _storage.save(currentProductId.toString(), currentProduct.toMap());
    }

    ga.sendCustom('Product view', category: 'view', label: currentProduct.name, value: currentProduct.id);

    // set all parameters

    gallery = currentProduct.images;
    name = currentProduct.name;
    onSale = currentProduct.on_sale;

    description = currentProduct.description;
    shortDescription = currentProduct.short_description;

    basePrice = currentPrice = currentProduct.price;

    currentImage = currentProduct.image;

    List<String> variationsToLoad = [];
    currentProduct.variations.forEach((x) {
      var variationMap = null;
      if ((variationMap = _storage.load(x)) != null) {
        variations.add(new WCProduct()..fromMap(variationMap));
      } else {
        variationsToLoad.add(x.toString());
      }
    });

    List<String> toSeeToLoad = [];

    currentProduct.related_ids.forEach((x) {
      var relativeMap = _storage.load(x.toString());

      if (relativeMap == null) {
        toSeeToLoad.add(x.toString());
      } else {
        toSeeProducts.add(new WCProduct()..fromMap(relativeMap));
      }
    });

    if (variationsToLoad.length > 0) {
      var loadedVariations = await _shopService.getProductVariations(currentProductId);

      loadedVariations.forEach((x) {
        x.images = [x.image];
        _storage.save(x.id.toString(), x.toMap());
      });

      variations.addAll(loadedVariations);
    }

    if (toSeeToLoad.length > 0) {
      var loadedRelative = await _shopService.getProductsBatch(toSeeToLoad);

      loadedRelative.forEach((x) {
        _storage.save(x.id.toString(), x.toMap());
      });

      toSeeProducts.addAll(loadedRelative);
    }

    isLoading = false;
  }

  String getSize() {
    if (currentProduct == null || currentProduct.dimensions == null) return '';

    window.console.log(currentProduct.dimensions.length);

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
