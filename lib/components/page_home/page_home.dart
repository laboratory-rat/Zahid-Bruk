import '../../services/ShopService.dart';
import 'package:angular2/angular2.dart';
import 'dart:html';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const[COMMON_DIRECTIVES],
    providers: const[ShopService]
)
class PageHome implements OnInit{
    static const String ITEMS_KEY = 'PH_SHOP_ITEMS';

    final ShopService _service;

    PageHome(this._service);

    @override
    ngOnInit() async {
    }
}