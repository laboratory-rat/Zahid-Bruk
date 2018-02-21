import '../../domain/ProductPackage.dart';
import '../../services/order_service.dart';
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
  final OrderService _orderService;

  final LRStorage _storage =
      new LRStorage(prefix: 'product', type: LRStorageType.Session);

  PageProduct(
      this._shopService, this._routeParams, this._router, this._orderService);

  bool isLoading = true;

  int currentProductId;
  int currentVariationId;
  WCProduct currentProduct = null;
  WCProduct currentVariation = null;
  List<WCProduct> variations = [];
  List<WCProduct> toSeeProducts = [];
  List<WPImage> gallery = [];
  String name = '';
  bool onSale = false;
  int basePrice = 0;
  int currentPrice = 0;
  WPImage currentImage = null;
  num counter;

  String shortDescription = '';
  String description = '';

  String get currentCategory => currentProduct?.categories?.first?.name ?? "Без категорії"; 

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
    if ((savedProductMap =
            _storage.load<WCProduct>(currentProductId.toString())) !=
        null) {
      currentProduct = new WCProduct()..fromMap(savedProductMap);
      currentProductId = currentVariationId = currentProduct.id;
    } else {
      currentProduct = await _shopService.getProductById(currentProductId);
      currentProductId = currentVariationId = currentProduct.id;
      _storage.save(currentProductId.toString(), currentProduct.toMap());
    }

    ga.sendCustom('Product view',
        category: 'view', label: currentProduct.name, value: currentProduct.id);

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
      var loadedVariations =
          await _shopService.getProductVariations(currentProductId);

      loadedVariations.forEach((x) {
        x.images = [x.image];
        _storage.save(x.id.toString(), x.toMap());
      });

      variations.addAll(loadedVariations);
    }

    if (variations.length > 0) {
      changeColor(variations.first);
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
    return 'Д ' +
        currentProduct.dimensions.length +
        'см x Ш ' +
        currentProduct.dimensions.width +
        'см x В ' +
        currentProduct.dimensions.height +
        'см';
  }

  String getColor(WCProduct p) {
    if (p == currentVariation) {
      return p.attributes.first.option + ' active';
    }

    return p.attributes.first.option;
  }

  void changeColor(WCProduct color) {
    currentVariationId = color.id;
    currentVariation = color;

    if (color.image != null) {
      currentImage = color.image;
    }

    if (color.price.toString().trim() != '')
      currentPrice = color.price;
    else
      currentPrice = basePrice;
  }

  void changeProduct(WCProduct product) {
    _router.navigate([
      'PageProduct',
      {'productId': product.id.toString()}
    ]);
  }

  OrderData orderData = new OrderData();

  void showOrderDialog(bool isConsultation) {
    if (isConsultation) {
      orderData.operationType = 'consultation';
    } else {
      orderData.operationType = 'order';
    }

    orderData.dialogEnabled = true;
  }

  Future order() async {
    if (orderData.operationProgress) return;
    orderData.operationProgress = true;

    try {
      await _orderService.order(orderData, currentProductId.toString(),
          currentVariationId.toString());
      orderData.operationSuccess = true;
    } catch (_) {
      orderData.operationFailed = true;
    } finally {
      orderData.operationProgress = false;
      orderData.dialogEnabled = false;
    }
  }
}

class OrderData {
  bool dialogEnabled = false;
  bool operationSuccess = false;
  bool operationFailed = false;
  bool operationProgress = false;

  String operationType = 'order';

  bool delivery = true;
  bool sidewalk = true;
  bool car = false;

  num count = 1;
  void onCountChanged(num newCount) {
    count = newCount;
  }

  String name;
  String tel;
  String email;
  String city;
  String address;

  bool get isValid => name?.isNotEmpty && tel?.isNotEmpty;
}
