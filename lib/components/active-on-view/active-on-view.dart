import 'dart:html';
import 'package:angular2/angular2.dart';

@Directive(selector: '[active-on-view]')
class ActiveOnView {
  @Input()
  int overflowHeight = 100;

  @Input()
  String viewActiveClass = 'active';

  @Input()
  bool viewIsActivated = false;

  @Input()
  bool viewIsActive = true;

  ElementRef _ref;
  int _screenHeight;

  ActiveOnView(ElementRef this._ref) {
    _screenHeight = window.innerHeight;
    window.onResize.listen((x) => _screenHeight = window.innerHeight);
  }

  void _onScroll(x) {
    if (!viewIsActive || viewIsActivated) return;

    if (window.pageYOffset - _ref.nativeElement.offsetTop + _screenHeight >= overflowHeight) {
      _ref.nativeElement.classes.add(viewActiveClass);
      viewIsActivated = true;
    }
  }
}
