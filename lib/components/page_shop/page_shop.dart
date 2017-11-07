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
    new SelectMaterialElement('popular', 'Від популярних'),
    new SelectMaterialElement('price_max', 'Від дешевших'),
    new SelectMaterialElement('price_min', 'Від дорожчих'),
  ];
  SelectMaterialElement currentOrderBy;

  List<SelectMaterialElement> listPerPage = [
    new SelectMaterialElement('5', "5"),
    new SelectMaterialElement('10', "10"),
    new SelectMaterialElement('20', "20"),
    new SelectMaterialElement('50', "50"),
  ];

  SelectMaterialElement currentPerPage;

  int totalPages = 1;
  int currentPage = 1;

  bool isListView = false;

  bool isLoading = true;

  @override
  Future ngOnInit() async {
    isLoading = true;

    currentPerPage = listPerPage[1];

    parseUrl();

    windowSizeListener();

    await Future.wait([loadCategories(), loadTags(), loadProductList()]);

    // await loadCategories();
    // await loadTags();
    // await loadProductList();

    isLoading = false;
  }

  void parseUrl() {
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
  }

  Future loadCategories() async {
    var list = _storage.load('categories');
    if (list != null) {
      filter.categories = list.map((x) => new WPCategory()..fromJson(x)).toList();
    } else {
      filter.categories = await _shop.getAllCategories();
      filter.categories.insert(
          0,
          new WPCategory()
            ..id = -1
            ..name = 'Усі');
      _storage.save('categories', filter.categories);
    }

    filter.currentCategory = filter.categories.firstWhere((x) => x.id == currentCategory);
  }

  Future loadTags() async {
    var tagsMap = _storage.load('tags');
    if (tagsMap != null) {
      filter.tags = tagsMap.map((x) => new WPTag()..fromJson(x)).toList();
    } else {
      filter.tags = await _shop.getAllTags();
      _storage.save('tags', filter.tags);
    }
  }

  Future loadProductList() async {
    List<ApiParam> params = new List<ApiParam>();

    params.add(new ApiParam(param: 'status', value: 'publish'));

    String searchId = params.map((x) => x.param + '=' + x.value).join('&');

    var cachedProducts = [];

    if ((cachedProducts = _storage.load<List<WCProduct>>(searchId))?.toList() != null) {
      allLoadedProducts = cachedProducts.map((x) => new WCProduct()..fromJson(x)).toList();
    } else {
      allLoadedProducts = await _shop.getProductsCustom(params);
      _storage.save(searchId, allLoadedProducts);
    }

    // sort

    if (currentCategory != null && currentCategory != -1) {
      allLoadedProducts = allLoadedProducts.where((x) => x.categories.any((z) => z.id == currentCategory)).toList();
    }

    if (currentOrderBy.id == 'popular') {
      allLoadedProducts.sort((a, b) => (a.variations.length > b.variations.length) ? 0 : 1);
    } else if (currentOrderBy.id == 'price_max') {
      allLoadedProducts.sort((a, b) => int.parse(a.price.toString()) < int.parse(b.price.toString()) ? 0 : 1);
    } else if (currentOrderBy.id == 'price_min') {
      allLoadedProducts.sort((a, b) => int.parse(a.price.toString()) < int.parse(b.price.toString()) ? 1 : 0);
    } else {
      allLoadedProducts.sort((a, b) => a.date_created.millisecondsSinceEpoch < b.date_created.millisecondsSinceEpoch ? 0 : 1);
    }

    // sort 2

    if (filter.minPrice != -1) {
      allLoadedProducts = allLoadedProducts.where((x) => int.parse(x.price.toString()) >= filter.minPrice).toList();
    }

    if (filter.maxPrice != -1) {
      allLoadedProducts = allLoadedProducts.where((x) => int.parse(x.price.toString()) <= filter.maxPrice).toList();
    }

    if (filter.popular || filter.sales) {
      var tmpList = [];

      if (filter.popular) {
        tmpList.addAll(allLoadedProducts.where((x) => x.featured));
      }

      if (filter.sales) {
        tmpList.addAll(allLoadedProducts.where((x) => x.on_sale));
      }

      allLoadedProducts = [];

      tmpList.forEach((x) {
        if (!allLoadedProducts.any((z) => z == x)) allLoadedProducts.add(x);
      });
    }

    if (filter.selectedTags.length != 0) {
      allLoadedProducts = allLoadedProducts.where((x) => x.tags.any((z) => filter.selectedTags.any((k) => k.id == z.id))).toList();
    }

    int perPage = int.parse(currentPerPage.id);

    if (allLoadedProducts.length > perPage) {
      currentProducts = allLoadedProducts.sublist(0, perPage);
      totalPages = (allLoadedProducts.length / perPage).ceil();
    } else {
      totalPages = 1;
      currentProducts = allLoadedProducts;
    }

    allLoadedProducts.forEach((x) => _productStorage.save(x.id.toString(), x));
  }

  Future search() async {
    isLoading = true;

    currentCategory = filter.currentCategory.id;
    await loadProductList();

    isLoading = false;
  }

  void onFilterChange($event) {
    isLoading = true;

    currentOrderBy = $event;
    loadProductList();

    isLoading = false;
  }

  void onPaginatorChange($event) {
    var list = allLoadedProducts.skip(($event - 1) * 5).take(5);
    currentProducts = list;
  }

  void onPerPageChange(SelectMaterialElement $event) {
    currentPerPage = $event;
    search();
  }

  void selectProduct(WCProduct product) {
    if (product == null) return;
    _router.navigate([
      'PageProduct',
      {'productId': product.id.toString()}
    ]);
  }

  // filter bar actions

  void windowSizeListener() {
    var onResize = (Event event) {
      if (window.innerWidth > 760) {
        isFilterBarActive = false;
      } else {
        isListView = true;
      }
    };

    window.onResize.listen(onResize);
    onResize(null);

    var onScroll = (Event event) {
      if (window.pageYOffset < 80) {
        isFilterBarOffset = true;
      } else {
        isFilterBarOffset = false;
      }
    };

    window.onScroll.listen(onScroll);
    onScroll(null);
  }

  bool isFilterBarActive = false;
  bool isFilterBarOffset = false;
  void toggleFilterBar() {
    if (window.innerWidth >= 760) return;

    isFilterBarActive = !isFilterBarActive;
  }
}
