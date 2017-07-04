import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:zahid_bruk_web/zahid_bruk.dart';
import 'package:angular2/platform/browser.dart';

String key = 'ck_596e28f0d65ee14037e33a0c9030a213722a3edd';
String secret = 'cs_8f57e0ab6dda22a3d4f0294a72b4319b7133c440';

Future main() async
{
    bootstrap(MainWindow, [
        ROUTER_PROVIDERS,
        provide(APP_BASE_HREF, useValue: ''),
        provide(LocationStrategy, useClass: HashLocationStrategy)
    ]);

    //WCApi.Configure('localhost/zb', key, secret);
}




