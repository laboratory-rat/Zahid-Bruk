import '../../services/shop_service.dart';
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
    selector: 'page-product',
    directives: const [COMMON_DIRECTIVES],
    templateUrl: 'page_product.html',
    styleUrls: const['page_product.css'],
    providers: const [ShopService]
)
class PageProduct implements OnInit{
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
        try{
            currentProductId = int.parse(_routeParams.get('productId'));
        }
        catch(ex)
        {
            print(ex);
            currentProductId = -1;
        }

        if(currentProductId == -1) _router.navigate(['PageHome']);
        currentProduct = await _shopService.getProductById(currentProductId);

        if(currentProduct.variations != null && currentProduct.variations.length > 0)
        {
            currentProduct.variations.forEach((x){
                _shopService.getProductById(x).then((pr) => variations.add(pr));
            });
        }
    }
}