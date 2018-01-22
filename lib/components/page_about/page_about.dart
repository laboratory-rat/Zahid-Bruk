import '../../services/head_service.dart';
import '../common/page_analytics.dart';
import '../ext/scroll_animation/scroll_animation.dart';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:google_maps/google_maps.dart';

@Component(
    selector: 'page-about',
    templateUrl: 'page_about.html',
    directives: const [COMMON_DIRECTIVES],
    styleUrls: const ['page_about.css'])
class PageAbout extends PageAnalytics implements OnInit {
  final HeadService _head;
  final RouteParams _routeParams;

  PageAbout(this._head, this._routeParams);

  @override
  ngOnInit() {
    header();
    initMap();
    parseUrl();
  }

  void header() {
    _head.title = 'About';
  }

  void parseUrl() {
    String scrollUrl = null;

    window.console.log(123);

    try {
      scrollUrl = _routeParams.get('section');
      if (scrollUrl != null) {
        LRScrollAnimation.scroll('#' + scrollUrl, duration: 200, offset: 80);
      }
    } catch (_) {
      scrollUrl = null;
    }
  }

  void initMap() {
    final mapOptions = new MapOptions()
      ..zoom = 13
      ..center = new LatLng(50.36, 24.23);

    GMap gMap = null;

    if (window.screen.available.width >= 1000) {
      gMap = new GMap(document.getElementById("gmap"), mapOptions);
    } else {
      gMap = new GMap(document.getElementById('gmap-mobile'), mapOptions);
    }

    var markerOptions = new MarkerOptions()
      ..icon = '/content/img/icons/zb-map-icon-48x70.png'
      ..position = new LatLng(50.39, 24.23)
      ..map = gMap;

    new Marker(markerOptions);
  }
}
