import '../../domain/ShopItem.dart';
import '../../services/ShopService.dart';
import 'dart:convert';
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

    List<ShopItem> currentItems;

    PageHome(this._service);

    @override
    ngOnInit() async {
        if(window.sessionStorage.containsKey(ITEMS_KEY))
        {
            var r = JSON.decode(window.localStorage[ITEMS_KEY]);

            currentItems = [];
            r.forEach((i) {
                currentItems.add(new ShopItem.Map(i));
            });
        }
        else
        {
            currentItems = await _service.getShopItemsAsync();

            window.sessionStorage[ITEMS_KEY] = JSON.encode(currentItems);
            print('Load items');
        }

    }
}