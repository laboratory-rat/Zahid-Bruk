import 'dart:async';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'material-paginator',
    styleUrls: const ['material_paginator.css'],
    templateUrl: 'material_paginator.html',
    directives: const [COMMON_DIRECTIVES])
class MaterialPaginator {
  @Input()
  int count = 1;

  bool _defaultPageChecked = false;

  @Input()
  set defaultPage(int page) {
    if (_defaultPageChecked) return;
    _defaultPageChecked = true;
    current = page;
  }

  @Output()
  int current = 1;

  final _onChange = new StreamController<int>();
  @Output()
  Stream<int> get onChange => _onChange.stream;

  List<int> list() {
    if (count < 1) count = 1;

    List<int> result = null;

    if (count < 5) {
      result = new List<int>.generate(count > 0 ? count : 1, (c) => c + 1);
    } else {
      result = new List<int>();
      if (current - 2 > 0) result.add(current - 2);
      if (current - 1 > 0) result.add(current - 1);
      result.add(current);
      if (current + 1 <= count) result.add(current + 1);
      if (current + 2 <= count) result.add(current + 2);
    }

    return result;
  }

  void add() {
    if (current > 1) change(current - 1);
  }

  void minus() {
    if (current + 1 <= count) change(current + 1);
  }

  void change(int p) {
    if (p > 0 && p != current) {
      current = p;
      _onChange.add(p);
    }
  }
}
