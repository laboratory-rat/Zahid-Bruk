import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:zahid_bruk_web/zahid_bruk.dart';
import 'package:angular2/platform/browser.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';

String key = 'ck_596e28f0d65ee14037e33a0c9030a213722a3edd';
String secret = 'cs_8f57e0ab6dda22a3d4f0294a72b4319b7133c440';

Future main() async {
  var host = mainConfig['wp']['host'];
  var key = mainConfig['wp']['key'];
  var secret = mainConfig['wp']['secret'];

  WCApi.Configure(host, key, secret);

  bootstrap(TestWindow);
}
