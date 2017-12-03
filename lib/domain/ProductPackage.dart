import '../services/shop_service.dart';
import 'dart:async';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:lr_storage/lr_storage.dart';

class ProductPackage extends JsonObject {
  WCProduct product = null;
  List<WCProduct> variations = new List<WCProduct>();
  List<WCProduct> toSee = new List<WCProduct>();

  ProductPackage({this.product, this.variations, this.toSee}) {}

  static Future<ProductPackage> download(
      ShopService _shopService, int productId, [int toSeeCount = 4]) async {
    ProductPackage result = new ProductPackage();


    result.product = await _shopService.getProductById(productId);
    if (result.product == null) return null;

    result.product.images = result.product.images.toList();

    var loadVariations = await _shopService.getProductVariations(productId);
    if (loadVariations != null) {
      result.variations = loadVariations;
      result.variations.forEach((x) => x.images = [x.image]);
    }

    if (result.product.related_ids.length > 0) {
      result.toSee = (await _shopService.getProductsBatch(
              result.product.related_ids.map((x) => x.toString()).toList()))
          .toList();
    } else {
      result.toSee = (await _shopService.getProducts(0, toSeeCount)).toList();
    }

    return result;
  }

  @override
  void fromMap(Map target) {
    if (target.containsKey('product')) {
      product = new WCProduct()..fromJson(target['product']);
    }

    if (target.containsKey('variations')) {
      variations = target['variations']
          .map((x) => new WCProduct()..fromJson(x))
          .toList();
    }

    if (target.containsKey('toSee')) {
      toSee = target['toSee'].map((x) => new WCProduct()..fromJson(x)).toList();
    }
  }


  @override
  Map toMap() {
    var m = new Map();

    m['product'] = product.toMap();
    m['variations'] = variations.map((x) => x.toMap()).toList();
    m['toSee'] = toSee.map((x) => x.toMap()).toList();

    return m;
  }
}