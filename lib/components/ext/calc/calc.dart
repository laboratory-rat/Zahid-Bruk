import 'dart:async';
import 'package:angular2/angular2.dart';

@Component(selector: 'calc', directives: const [COMMON_DIRECTIVES], templateUrl: 'calc.html', styleUrls: const ['calc.css'])
class Calc {
  @Input()
  num price = 0;

  @Output()
  num get totalPrice => counter != null ? (num.parse(price.toString(), (_) => 1) * num.parse(counter.toString())).round() : price;

  num counter = 1;

  final countChangeStream = new StreamController<num>();
  @Output()
  Stream<num> get countChanged =>countChangeStream.stream;

  void add() {
    if (counter == null)
      counter = 1;
    else
      counter += 1;

    countChangeStream.add(counter);
  }

  void min() {
    if (counter == null)
      counter = 1;
    else if (counter > 1) counter -= 1;
    countChangeStream.add(counter);
  }
}
