import '../active-on-view/active-on-view.dart';
import 'package:angular2/angular2.dart';

@Component(
  selector: 'test',
  templateUrl: 'test_window.html',
  styleUrls: const ['test_window.css'],
  directives: const [COMMON_DIRECTIVES, ActiveOnView],
)
class TestWindow {
  TestWindow() {}
}
