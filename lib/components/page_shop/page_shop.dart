import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../ext/product_filter/product_filter.dart';
import 'dart:async';
import 'dart:html';
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

    int currentCategory;

    WCProduct currentProduct;
    List<WCProduct> currentProducts;

    PageShop(this._shop, this._routeParams);

    FilterObject filter = new FilterObject();

    String host;

    bool listView = false;
    bool isLoading = true;

    @override
    Future ngOnInit() async {
        host = mainConfig['server']['host'];

        try
        {
            currentCategory = int.parse(_routeParams.get('category'));
            print(currentCategory);
        }
        catch(ex)
        {
            print(ex);
            currentCategory = -1;
        }

        List<WPCategory> cats = new List<WPCategory>();
        WPCategory all = new WPCategory()..id = -1;
        all.name = 'Усі';
        cats.add(all);
        cats.addAll(await _shop.getAllCategories());

        filter.categories = cats;

        await loadProductList();
    }

    Future loadProductList() async{
        isLoading = true;

        if(currentCategory != null && currentCategory != -1){
            currentProducts = await _shop.getProductsByCategory(currentCategory);
            filter.setCurrentCategory(currentCategory);
            window.console.log(filter.categories);
        }
        else {
            currentProducts = await _shop.getProducts(1);
        }

        isLoading = false;  
    }

    Future search() async{
        currentCategory = filter.currentCategory.id;

        await loadProductList();
    }
}