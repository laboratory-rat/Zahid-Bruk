import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'product-filter-bar',
    templateUrl: 'product_filter_bar.html',
    styleUrls: const ['product_filter_bar.css'],
    directives: const [COMMON_DIRECTIVES])
class ProductFilterBar extends OnInit {
  @Input()
  bool isCompactView = false;

  final _compactViewChangeRequest = new StreamController<bool>();
  @Output()
  Stream<bool> get compactViewChange => _compactViewChangeRequest.stream;

  List<String> orderByList = ['За рейтингом', 'Від дешевих до дорогих'];
  String currentOrderBy = '';

  void setOrderBy(order) {
    currentOrderBy = order;
  }

  void toggleCompactView() {
    isCompactView = !isCompactView;
    _compactViewChangeRequest.add(isCompactView);
  }

  @override
  ngOnInit() {
    window.onResize.listen((data) {
      window.console.log(data);
    });

    window.onResize.listen((data) {}, onDone: () {
      window.console.log(1231231);
    });

    currentOrderBy = orderByList[0];
  }
}
