import 'package:angular2/angular2.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

@Component(
  selector: 'product-cards',
  templateUrl: 'product_cards.html',
  styleUrls: const['./product_cards.css'],
  directives: const[COMMON_DIRECTIVES]
)
class ProductCards implements OnInit{
    @Input()
    List<WCProduct> list;

    @Input()
    int maxItems;

    @Input()
    bool vertical = false;

    @Input()
    String prefix = 'Бруківка';

    @Output()
    EventEmitter<WCProduct> event = new EventEmitter<WCProduct>(); 


  @override
  ngOnInit() {
    if(list.length > maxItems)
        list = list.sublist(0, maxItems);
  }

  emit(WCProduct product){
    event.emit(product);
  }
}