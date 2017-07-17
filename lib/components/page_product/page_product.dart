import '../../services/shop_service.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

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

    @override
    ngOnInit() {
        try{
            currentProductId = int.parse(_routeParams.get('productId'));
        }
        catch(ex)
        {
            print(ex);
            currentProductId = -1;
        }

        if(currentProductId == -1) _router.navigate(['PageHome']);
        
    }
}