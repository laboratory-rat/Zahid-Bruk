import '../../services/ShopService.dart';
import '../ext/mad_rat_material_carousel/mad_rat_material_carousel.dart';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const[COMMON_DIRECTIVES, MadRatMaterialCarousel],
    providers: const[ShopService],
)
class PageHome implements OnInit{
    static const String ITEMS_KEY = 'PH_SHOP_ITEMS';

    final ShopService _service;
    List<CarouselObject> carouselObjects;

    String carouselWidth = '800px';
    String carouselHeight = '400px';

    PageHome(this._service);

    @override
    ngOnInit() async {
        carouselObjects = [
            new CarouselObject( src: 'http://placehold.it/350x350/f0f0f0', title: '789', caption: 'caption'),
            new CarouselObject( src: 'http://placehold.it/350x350/ff0000', title: '123', caption: 'caption'),
            new CarouselObject( src: 'http://placehold.it/350x350/00ff00', title: '321', caption: 'caption'),
            new CarouselObject( src: 'http://placehold.it/350x350/0000ff', title: '456', caption: 'caption'),
            new CarouselObject( src: 'http://placehold.it/350x350/0f0f0f', title: '1654', caption: 'caption')
        ];
    }
}