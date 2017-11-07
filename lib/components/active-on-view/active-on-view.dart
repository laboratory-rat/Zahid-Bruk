import 'dart:html';
import 'package:angular2/angular2.dart';

@Directive(selector: '[active-on-view]')
class ActiveOnView {
  int _overflowHeight = 100;

  @Input()
  set overflowHeight(Object obj) => _overflowHeight = int.parse(obj.toString());

  @Input()
  String viewActiveClass = 'active';

  @Input()
  String removeClass = '';

  @Input()
  bool viewIsActivated = false;

  @Input()
  bool viewIsActive = true;

  ElementRef _ref;
  int _screenHeight;

  ActiveOnView(ElementRef this._ref) {
    _screenHeight = window.innerHeight;
    window.onScroll.listen(_onScroll);
  }

  void _onScroll(x) {
    if (!viewIsActive || viewIsActivated) return;

    if (window.pageYOffset - _ref.nativeElement.offsetTop + _screenHeight >= _overflowHeight) {
      if (viewActiveClass != '') {
        viewActiveClass.split(' ').forEach((x) {
          _ref.nativeElement.classes.add(x);
        });
      }

      if (removeClass != '') {
        removeClass.split(' ').forEach((x) {
          _ref.nativeElement.classes.remove(x);
        });
      }

      viewIsActivated = true;
    }
  }
}
