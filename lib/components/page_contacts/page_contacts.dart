import '../common/page_analytics.dart';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'page-contacts',
    templateUrl: 'page_contacts.html',
    styleUrls: const['page_contacts.css'],
    directives: const[COMMON_DIRECTIVES]
)
class PageContacts extends PageAnalytics implements OnInit{
    
  @override
  ngOnInit() {
    // TODO: implement ngOnInit
  }
}