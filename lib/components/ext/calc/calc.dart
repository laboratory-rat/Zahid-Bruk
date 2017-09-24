import 'dart:async';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'calc',
    directives: const [COMMON_DIRECTIVES],
    templateUrl: 'calc.html',
    styleUrls: const ['calc.css'])
class Calc {
  @Input()
  num price = 0;
}
