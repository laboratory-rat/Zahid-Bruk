import '../../configs/main_config.dart';
import '../../services/order_service.dart';
import '../../services/shop_service.dart';
import '../active-on-view/active-on-view.dart';
import '../common/page_analytics.dart';
import '../ext/mad_rat_mcarousel/mad_rat_mcarousel.dart';
import '../ext/product_cards/product_cards.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:lr_storage/lr_storage.dart';
import 'package:zahid_bruk_web/services/head_service.dart';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const [COMMON_DIRECTIVES, MRMaterialCarousel, ProductCards, ActiveOnView, ROUTER_DIRECTIVES],
    providers: const [ShopService],
    styleUrls: const ['page_home.css'])
class PageHome extends PageAnalytics implements OnInit {
  final ShopService _service;
  final Router _router;
  final HeadService _head;
  final OrderService _order;

  final LRStorage _storage = new LRStorage(type: LRStorageType.Session, prefix: 'carousel');

  List<WCProduct> products;
  List<CarouselObject> carouselObjects;

  List<WCProduct> productsPaving = [];
  List<WCProduct> productsTP = [];
  List<WCProduct> verticalProducts = [];

  PageHome(this._service, this._router, this._head, this._order) {}

  bool loadingInProgress = true;

  @override
  Future ngOnInit() async {
    _head.title = 'головна сторінка';
    _head.update();

    // await _loadPaving(); // test 04.12

    // Load products

    _loadCarousel();
    _loadPaving();
    _loadTp();
    _loadBest();

    await Future.wait([_loadCarousel(), _loadPaving(), _loadTp(), _loadBest()]);
    loadingInProgress = false;
  }

  Future _loadCarousel() async {
    var storeCarousel = null;
    if ((storeCarousel = _storage.load('carousel')) != null) {
      products = storeCarousel.map((x) => new WCProduct()..fromMap(x)).toList();
    } else {
      products = await _service.getProducts(1, 6);
      _storage.save('carousel', products.map((x) => x.toMap()).toList());
    }

    carouselObjects = products
        .map((x) => new CarouselObject(id: x.id.toString(), src: x.images.first.src, description: x.description, price: x.price, title: x.name))
        .toList();
  }

  Future _loadPaving() async {
    var savedPavings = _storage.load('pavings');
    if (savedPavings == null) {
      productsPaving = await _service.getProductsByCategory(15, [new ApiParam(param: 'per_page', value: '3')]);
      _storage.save('pavings', productsPaving.map((x) => x.toMap()).toList());
    } else {
      productsPaving = savedPavings.map((x) => new WCProduct()..fromMap(x)).toList();
    }
  }

  Future _loadTp() async {
    var savedTp = _storage.load('tp');
    if (savedTp == null) {
      productsTP = await _service.getProductsByCategory(16, [new ApiParam(param: 'per_page', value: '3')]);
      _storage.save('tp', productsTP.map((x) => x.toMap()).toList());
    } else {
      productsTP = savedTp.map((x) => new WCProduct()..fromMap(x)).toList();
    }
  }

  Future _loadBest() async {
    var savedBest = _storage.load('best');
    if (savedBest == null) {
      verticalProducts = await _service.getProductsCustom([new ApiParam(param: 'page', value: '1'), new ApiParam(param: 'per_page', value: '6')]);
      _storage.save('best', verticalProducts.map((x) => x.toMap()).toList());
    } else {
      verticalProducts = savedBest.map((x) => new WCProduct()..fromMap(x)).toList();
    }
  }

  String customerEmail;
  Future subscribe() async{
    if(customerEmail.isNotEmpty){
      // var r  = await _order.subscribe(customerEmail);

      // window.console.log(r);
    }
  }

  String tel;
  String name;
  String q;
  bool get isQOk => tel?.isNotEmpty && customerEmail?.isNotEmpty && name?.isNotEmpty && q?.isNotEmpty;
  Future callConsultation() async{
    if(!isQOk) return;

    var r = await _order.needConsultation(name, customerEmail, tel, q);
    window.console.log(r);
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
