import '../material_paginator/material_paginator.dart';
import '../select_material/select_material.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'product-filter-bar',
    templateUrl: 'product_filter_bar.html',
    styleUrls: const ['product_filter_bar.css'],
    directives: const [COMMON_DIRECTIVES, SelectMaterial, MaterialPaginator])
class ProductFilterBar extends OnInit {
  @Input()
  FilterBarOptions options = new FilterBarOptions();

  StreamController<FilterBarOptions> _onFilterChange = new StreamController<FilterBarOptions>();
  @Output()
  Stream get onFilterChange => _onFilterChange.stream;

  @override
  ngOnInit() {
    window.onResize.listen((e) {
      print(e.currentTarget);
      window.console.log(123);
    });
  }

  void toggleCompactView() {
    options.isListView = !options.isListView;
    _onFilterChange.add(options);
  }

  void selectorChange(ISelectMaterialElement element) {
    options.currentOrderBy = element;
    _onFilterChange.add(options);
  }

  void paginatorChange(int page) {
    options.currentPage = page;
    _onFilterChange.add(options);
  }
}

class FilterBarOptions {
  bool isListView = false;
  ISelectMaterialElement currentOrderBy = null;
  List<ISelectMaterialElement> orderByList = [
    new SelectMaterialElement('default', 'За популярністю'),
    new SelectMaterialElement('max_price', 'Від дорогих'),
    new SelectMaterialElement('min_price', 'Від дешевих')
  ];

  int totalPages = 1;
  int currentPage = 1;
}
