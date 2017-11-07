import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../active-on-view/active-on-view.dart';
import '../ext/mad_rat_mcarousel/mad_rat_mcarousel.dart';
import '../ext/product_cards/product_cards.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:lr_storage/lr_storage.dart';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const [COMMON_DIRECTIVES, MRMaterialCarousel, ProductCards, ActiveOnView, ROUTER_DIRECTIVES],
    providers: const [ShopService],
    styleUrls: const ['page_home.css'])
class PageHome implements OnInit {
  final ShopService _service;
  final Router _router;

  final LRStorage _storage = new LRStorage(type: LRStorageType.Session, prefix: 'carousel');

  List<WCProduct> products;
  List<CarouselObject> carouselObjects;

  List<WCProduct> productsPaving = [];
  List<WCProduct> productsTP = [];
  List<WCProduct> verticalProducts = [];

  PageHome(this._service, this._router) {}

  @override
  Future ngOnInit() async {
    // Load products

    await Future.wait([_loadCarousel(), _loadPaving(), _loadTp(), _loadBest()]);
  }

  Future _loadCarousel() async {
    var storeCarousel = null;
    if ((storeCarousel = _storage.load('carousel')) != null) {
      products = storeCarousel.map((x) => new WCProduct()..fromJson(x)).toList();
    } else {
      products = await _service.getProducts(1, 6);
      _storage.save('carousel', products);
    }

    carouselObjects = products
        .map((x) => new CarouselObject(id: x.id.toString(), src: x.images.first.src, description: x.description, price: x.price, title: x.name))
        .toList();
  }

  Future _loadPaving() async {
    var savedPavings = _storage.load('pavings');
    if (savedPavings == null) {
      productsPaving = await _service.getProductsByCategory(15, [new ApiParam(param: 'per_page', value: '3')]);
      _storage.save('pavings', productsPaving);
    } else {
      productsPaving = savedPavings.map((x) => new WCProduct()..fromJson(x)).toList();
    }
  }

  Future _loadTp() async {
    var savedTp = _storage.load('tp');
    if (savedTp == null) {
      productsTP = await _service.getProductsByCategory(23, [new ApiParam(param: 'per_page', value: '3')]);
      _storage.save('tp', productsTP);
    } else {
      productsTP = savedTp.map((x) => new WCProduct()..fromJson(x)).toList();
    }
  }

  Future _loadBest() async {
    var savedBest = _storage.load('best');
    if (savedBest == null) {
      verticalProducts = await _service.getProductsCustom([new ApiParam(param: 'page', value: '1'), new ApiParam(param: 'per_page', value: '6')]);
      _storage.save('best', verticalProducts);
    } else {
      verticalProducts = savedBest.map((x) => new WCProduct()..fromJson(x)).toList();
    }
  }

  selectProduct(WCProduct product) {
    if (product == null) return;
    _router.navigate([
      'PageProduct',
      {'productId': product.id.toString()}
    ]);
  }

  selectProductById(String id) {
    if (id == null || id == '') return;
    _router.navigate([
      'PageProduct',
      {'productId': id}
    ]);
  }
}
