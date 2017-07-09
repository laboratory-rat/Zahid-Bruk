import '../../services/shop_service.dart';
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
    selector: 'page-shop',
    templateUrl: 'page_shop.html',
    directives: const[COMMON_DIRECTIVES],
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



    @override
    Future ngOnInit() async {
        currentId = _routeParams.get('id');
        currentCategory = _routeParams.get('category');

        if(currentId != null)
        {
            
        }
        else if(currentCategory != null){
            currentProducts = await _shop.getProductsByCategory(currentCategory);
        }
    }
}