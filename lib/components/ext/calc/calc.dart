import 'package:angular2/angular2.dart';

@Component(selector: 'calc', directives: const [COMMON_DIRECTIVES], templateUrl: 'calc.html', styleUrls: const ['calc.css'])
class Calc {
  @Input()
  num price = 0;

  @Output()
  num get totalPrice => counter != null ? (num.parse(price.toString()) * num.parse(counter.toString())).round() : price;

  num counter = 1;

  void add() {
    if (counter == null)
      counter = 1;
    else
      counter += 0.5;
  }

  void min() {
    if (counter == null)
      counter = 1;
    else if (counter > 1) counter -= 0.5;
  }
}
