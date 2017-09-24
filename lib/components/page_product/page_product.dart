import '../../services/shop_service.dart';
import '../ext/calc/calc.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
    selector: 'page-product',
    directives: const [COMMON_DIRECTIVES, Calc],
    templateUrl: 'page_product.html',
    styleUrls: const ['page_product.css'],
    providers: const [ShopService])
class PageProduct implements OnInit {
  final ShopService _shopService;
  final RouteParams _routeParams;
  final Router _router;

  PageProduct(this._shopService, this._routeParams, this._router);

  int currentProductId;
  WCProduct currentProduct = null;
  List<WCProduct> variations = [];
  List<WCProduct> toSeeProducts = [];

  @override
  Future ngOnInit() async {
    try {
      currentProductId = int.parse(_routeParams.get('productId'));
    } catch (ex) {
      print(ex);
      currentProductId = -1;
    }

    if (currentProductId == -1) _router.navigate(['PageHome']);
    currentProduct = await _shopService.getProductById(currentProductId);

    currentProduct.images = currentProduct.images.toList();

    window.console.log(currentProduct.dimensions);

    if (currentProduct == null) _router.navigate(['PageHome']);
  }

  String getSize() {
    if (currentProduct == null || currentProduct.dimensions == null) return '';

    return currentProduct.dimensions.length +
        ' x ' +
        currentProduct.dimensions.width +
        ' x ' +
        currentProduct.dimensions.height;
  }
}
