import '../../configs/main_config.dart';
import '../../services/shop_service.dart';
import '../ext/mad_rat_mcarousel/mad_rat_mcarousel.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:lab_rat_storage/lab_rat_storage.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const[COMMON_DIRECTIVES, MRMaterialCarousel],
    providers: const[ShopService],
    styleUrls: const['page_home.css']
)
class PageHome implements OnInit{
    final ShopService _service;
    final LabRatStorage _storage = new LabRatStorage(type: LabRatStorageType.Session, prefix: 'carousel');    
    
    List<WCProduct> products;
    List<CarouselObject> carouselObjects;
    String host = '';

    List<WCProduct> productsPaving = new List<WCProduct>();
    List<WCProduct> productsTP = new List<WCProduct>();

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
            carouselObjects.add(new CarouselObject(src: p.images.first.src, title: p.name, description: p.description));
        });

        // Load products

        productsPaving = await _service.getProductsByCategory(15, [new ApiParam(param: 'per_page', value: '3')]);
        productsTP = await _service.getProductsByCategory(20, [new ApiParam(param: 'per_page', value: '3')]);
    }
}