import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../ext/mad_rat_mcarousel/mad_rat_mcarousel.dart';
import '../ext/product_cards/product_cards.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:lab_rat_storage/lab_rat_storage.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';


@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const[COMMON_DIRECTIVES, MRMaterialCarousel, ProductCards],
    providers: const[ShopService],
    styleUrls: const['page_home.css']
)
class PageHome implements OnInit{
    final ShopService _service;
    final LabRatStorage _storage = new LabRatStorage(type: LabRatStorageType.Session, prefix: 'carousel');    
    
    List<WCProduct> products;
    List<CarouselObject> carouselObjects;
    String host = '';

    List<WCProduct> productsPaving = [];
    List<WCProduct> productsTP = [];

    PageHome(this._service)
    {
        host = mainConfig['server']['host'];
    }

    @override
    Future ngOnInit() async {

        Map cMap = _storage.load('carousel');
        if(cMap != null)
        {
            JsonPackage package = new JsonPackage<WCProduct>(new List<WCProduct>())..fromJson(cMap);
            if(package.isExpired){
                _storage.save('carousel', null);
            }
            else{
                products = package.inner;
            }
        }
        
        if(products == null)
        {
            products = await _service.getProducts(1);
            JsonPackage package = new JsonPackage(products, new DateTime.now(), new DateTime.now().add(new Duration(hours: 1)));
            _storage.save('carousel', package);
        }

        carouselObjects = [];

        products.forEach((p){
            carouselObjects.add(new CarouselObject(src: p.images.first.src, title: p.name, description: p.short_description, price: p.price));
        });

        // Load products

        var savedPavings = _storage.load('pavings');
        if(savedPavings == null){
            productsPaving = await _service.getProductsByCategory(15, [new ApiParam(param: 'per_page', value: '3')]);
            _storage.save('pavings', productsPaving);
        }
        else{
            savedPavings.forEach((x) => productsPaving.add(new WCProduct()..fromJson(x)));
            window.console.log(savedPavings[0]);
        }
        
    window.console.log(productsPaving[0]);

        var savedTp = _storage.load('tp');
        if(savedTp == null){
             productsTP = await _service.getProductsByCategory(23, [new ApiParam(param: 'per_page', value: '3')]);
             _storage.save('tp', productsTP);
        } else{
            savedTp.forEach((x) => productsTP.add(new WCProduct()..fromJson(x)));
        }

        

    }

    selectProduct(WCProduct product){
        window.console.log(product);
    }
}