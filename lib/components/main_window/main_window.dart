import '../page_about/page_about.dart';
import '../page_contacts/page_contacts.dart';
import '../page_home/page_home.dart';
import '../page_news/page_news.dart';
import '../page_product/page_product.dart';
import '../page_shop/page_shop.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

@Component(selector: 'main-window', templateUrl: 'main_window.html', directives: const [COMMON_DIRECTIVES, ROUTER_DIRECTIVES], styleUrls: const ['main_window.css'])
@RouteConfig(const [
  const Route(
    name: 'PageHome',
    component: PageHome,
    path: '/',
    useAsDefault: true,
  ),
  const Route(name: 'PageShop', component: PageShop, path: '/shop'),
  const Route(name: 'PageShopCategory', component: PageShop, path: '/shop/:category'),
  const Route(name: 'PageProduct', component: PageProduct, path: '/product/:productId'),
  const Route(name: 'PageAbout', component: PageAbout, path: '/about'),
  const Route(name: 'PageNews', component: PageNews, path: '/news'),
  const Route(name: 'PageContacts', component: PageContacts, path: '/contacts')
])
class MainWindow implements OnInit {
  Element get drawerElement => querySelector('#drawer');
  Element get drawerObfuscatorElement => querySelector('.mdl-layout__obfuscator');
  Element get secondNav => querySelector('#second-menu');


  void toggleDrawer() {
    drawerElement.classes.toggle('is-visible');
    drawerObfuscatorElement.classes.toggle('is-visible');
  }

  @override
  ngOnInit() {
    window.onScroll.listen((_) => checkFixed());
  }

  void checkFixed() {
    if (window.scrollY >= 80 && !secondNav.classes.contains('fixed')) {
      secondNav.classes.add('fixed');
    } else if (window.scrollY < 80 && secondNav.classes.contains('fixed')) {
      secondNav.classes.remove('fixed');
    }
  }
}
