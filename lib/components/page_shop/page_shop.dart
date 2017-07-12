import '../../services/shop_service.dart';
import '../ext/product_filter/product_filter.dart';
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
    selector: 'page-shop',
    templateUrl: 'page_shop.html',
    directives: const[COMMON_DIRECTIVES, ProductFilter],
    providers: const[ShopService, ROUTER_PROVIDERS]
)
class PageShop implements OnInit{
    final RouteParams _routeParams;
    final ShopService _shop;

    String currentId;
    String currentCategory;

    WCProduct currentProduct;
    List<WCProduct> currentProducts;

    PageShop(this._shop, this._routeParams);

    FilterObject filter = new FilterObject();


    @override
    Future ngOnInit() async {
        currentId = _routeParams.get('id');
        currentCategory = _routeParams.get('category');

        List<WPCategory> cats = new List<WPCategory>();
        WPCategory all = new WPCategory()..id = -1;
        all.name = 'Усі';
        cats.add(all);
        cats.addAll(await _shop.getAllCategories());

        filter.categories = cats;

        await loadProductList();
    }

    Future loadProductList() async{
        if(currentCategory != null){
            filter.currentCategory = filter.categories.firstWhere((c) => c.name == currentCategory);
            currentProducts = await _shop.getProductsByCategory(currentCategory);
        }
        else {
            currentProducts = await _shop.getProducts(1);
        }
        
    }

    Future search() async{
        print(filter.currentCategory.name);

        if(filter.currentCategory.id != -1)
            currentCategory = filter.currentCategory.name;
        else
            currentCategory = null;

        await loadProductList();
    }
}