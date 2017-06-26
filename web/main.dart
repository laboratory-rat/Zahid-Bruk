import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:zahid_bruk_web/zahid_bruk.dart';
import 'package:angular2/platform/browser.dart';

Future main() async
{
    bootstrap(MainWindow, [
        ROUTER_PROVIDERS,
        provide(APP_BASE_HREF, useValue: ''),
        provide(LocationStrategy, useClass: HashLocationStrategy)
    ]);
}