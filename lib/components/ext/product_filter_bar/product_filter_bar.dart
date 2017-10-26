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
  FilterBarOptions options = new FilterBarOptions();

  void toggleCompactView() {
    options.isListView = !options.isListView;
  }

  @override
  ngOnInit() {
    window.onResize.listen((e) {
      print(e.currentTarget);
    });
  }
}

class FilterBarOptions {
  bool isListView = false;
  String currentOrderBy = '';
}
