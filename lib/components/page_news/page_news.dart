import '../common/page_analytics.dart';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'page-news',
    templateUrl: 'page_news.html',
    styleUrls: const['page_news.css'],
    directives: const[COMMON_DIRECTIVES]
)
class PageNews extends PageAnalytics implements OnInit{
    


  @override
  ngOnInit() {
    // TODO: implement ngOnInit
  }
}