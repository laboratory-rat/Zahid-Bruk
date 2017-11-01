import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../ext/material_paginator/material_paginator.dart';
import '../ext/product_cards/product_cards.dart';
import '../ext/product_filter/product_filter.dart';
import '../ext/product_filter_bar/product_filter_bar.dart';
import '../ext/select_material/select_material.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'package:lr_storage/lr_storage.dart';

@Component(
    selector: 'page-shop',
    templateUrl: 'page_shop.html',
    directives: const [COMMON_DIRECTIVES, ProductFilter, SelectMaterial, MaterialPaginator, ProductCards],
    providers: const [ShopService],
    styleUrls: const ['page_shop.css'])
class PageShop implements OnInit {
  final RouteParams _routeParams;
  final ShopService _shop;
  final Router _router;

  final LRStorage _productStorage = new LRStorage(prefix: 'product', type: LRStorageType.Session);
  final LRStorage _storage = new LRStorage(prefix: 'shop', type: LRStorageType.Session);

  int currentCategory;

  WCProduct currentProduct;
  List<WCProduct> allLoadedProducts = [];
  List<WCProduct> currentProducts = [];

  PageShop(this._shop, this._routeParams, this._router);

  FilterObject filter = new FilterObject();

  List<SelectMaterialElement> listOrderBy = [
    new SelectMaterialElement('date', 'Від нових'),
    new SelectMaterialElement('title', 'Title'),
  ];
  SelectMaterialElement currentOrderBy;
  int totalPages = 1;
  int currentPage = 1;
  int currentPerPage = 20;

  bool isListView = false;

  bool isLoading = true;

  @override
  Future ngOnInit() async {
    currentOrderBy = listOrderBy[0];

    try {
      currentCategory = int.parse(_routeParams.get('category'));
    } catch (ex) {
      currentCategory = -1;
    }

    try {
      currentPage = int.parse(_routeParams.get('page'));
    } catch (ex) {
      currentPage = 1;
    }

    try {
      currentPerPage = int.parse(_routeParams.get('per_page'));
    } catch (ex) {
      currentPerPage = 20;
    }
    // Categories

    var categorsMap = null;
    List<WPCategory> categors = new List<WPCategory>();
    if ((categorsMap = _storage.load<List<WPCategory>>('categories')) != null) {
      categorsMap.forEach((x) => categors.add(new WPCategory()..fromJson(x)));
    } else {
      categors.add(new WPCategory()
        ..id = -1
        ..name = 'Усі');

      categors.addAll(await _shop.getAllCategories());
      _storage.save('categories', categors);
    }

    filter.categories = categors;

    // Tags

    List<WPTag> tags;
    Map savedTags = _storage.load('tags');

    if (savedTags != null) {
      JsonPackage package = new JsonPackage<WPTag>(new List<WPTag>())..fromJson(savedTags);
      tags = package.inner;
    } else {
      tags = await _shop.getAllTags();
      JsonPackage pack = new JsonPackage<WPTag>(tags);
      _storage.save('tags', pack);
    }

    filter.tags = tags;

    await loadProductList();
  }

  Future loadProductList() async {
    isLoading = true;
    List<ApiParam> params = new List<ApiParam>();

    params.add(new ApiParam(param: 'status', value: 'publish'));
    params.add(new ApiParam(param: 'orderby', value: currentOrderBy.id));
    params.add(new ApiParam(param: 'order', value: 'desc'));

    if (currentCategory != null && currentCategory != -1) {
      filter.setCurrentCategory(currentCategory);
      params.add(new ApiParam(param: 'category', value: currentCategory.toString()));
    }

    String searchId = params.map((x) => x.param + '=' + x.value).join('&');

    var productListMap = null;
    if ((productListMap = _storage.load(searchId)) != null) {
      allLoadedProducts = productListMap.map((x) => new WCProduct()..fromJson(x)).toList();
    } else {
      allLoadedProducts = await _shop.getProductsCustom(params);
      _storage.save(searchId, allLoadedProducts);
    }

    if (allLoadedProducts.length > 20) {
      currentProducts = allLoadedProducts.sublist(0, 20);
      totalPages = (allLoadedProducts.length / 20).ceil();
    } else {
      totalPages = 1;
      currentProducts = allLoadedProducts;
    }

    allLoadedProducts.forEach((x) => _productStorage.save(x.id.toString(), x));

    isLoading = false;
  }

  Future search() async {
    currentCategory = filter.currentCategory.id;

    await loadProductList();
  }

  void onFilterChange($event) {
    currentOrderBy = $event;
    loadProductList();
  }

  void onPaginatorChange($event) {
    window.console.log($event);
  }

  void onBarChange(FilterBarOptions options) {
    window.console.log(options);
  }

  void selectProduct(WCProduct product){
    if(product == null) return;

    _router.navigate(['PageProduct', {'productId': product.id.toString()}]);
  }
}
