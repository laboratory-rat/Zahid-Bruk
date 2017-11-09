import '../common/page_analytics.dart';
import 'package:angular2/angular2.dart';

@Component(selector: 'page-about', templateUrl: 'page_about.html', directives: const [COMMON_DIRECTIVES])
class PageAbout extends PageAnalytics implements OnInit {
  @override
  ngOnInit() {
  }
}
