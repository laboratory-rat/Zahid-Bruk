import '../../services/ShopService.dart';
import '../ext/lab_rat_carousel/lab_rat_carousel.dart';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'page-home',
    templateUrl: 'page_home.html',
    directives: const[COMMON_DIRECTIVES, LabRatCarousel],
    providers: const[ShopService],
)
class PageHome implements OnInit{
    static const String ITEMS_KEY = 'PH_SHOP_ITEMS';

    final ShopService _service;
    List<LabRatCarouselObject> carouselObjects;

    String carouselWidth = '100%';
    String carouselHeight = '400px';

    PageHome(this._service);

    @override
    ngOnInit() async {
        carouselObjects = [
            new LabRatCarouselObject( src: 'http://placehold.it/1200x400/ff0000', title: '123', caption: 'caption'),
            new LabRatCarouselObject( src: 'http://placehold.it/1200x400/00ff00', title: '321', caption: 'caption'),
            new LabRatCarouselObject( src: 'http://placehold.it/1200x400/0000ff', title: '456', caption: 'caption'),
            new LabRatCarouselObject( src: 'http://placehold.it/1200x400/0f0f0f', title: '1654', caption: 'caption'),
            new LabRatCarouselObject( src: 'http://placehold.it/1200x400/f0f0f0', title: '789', caption: 'caption')
        ];
    }
}