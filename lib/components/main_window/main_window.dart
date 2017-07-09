import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../page_about/page_about.dart';
import '../page_home/page_home.dart';
import '../page_shop/page_shop.dart';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'main-window',
    templateUrl: 'main_window.html',
    directives: const[COMMON_DIRECTIVES, ROUTER_DIRECTIVES]
)
@RouteConfig(const[
    const Route(name: 'PageHome', component: PageHome, path: '/', useAsDefault: true,),
    const Route(name: 'PageShop', component: PageShop, path: '/shop'),
    const Route(name: 'PageShopId', component: PageShop, path: '/shop/product/:id'),
    const Route(name: 'PageShopCategory', component: PageShop, path: '/shop/category/:category'),
    const Route(name: 'PageAbout', component: PageAbout, path: '/about')
])
class MainWindow implements OnInit
{
    Element get drawerElement => querySelector('#drawer');
    Element get drawerObfuscatorElement => querySelector('.mdl-layout__obfuscator');

    String get secondHeaderState => window.scrollY <= 80
        ? ''
        : 'fixed';

    void toggleDrawer(){
        drawerElement.classes.toggle('is-visible');
        drawerObfuscatorElement.classes.toggle('is-visible');
    }

    @override
    ngOnInit() {

    }




}