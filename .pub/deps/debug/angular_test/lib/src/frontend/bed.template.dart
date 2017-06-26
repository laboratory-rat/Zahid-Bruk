// @ignoreProblemForFile annotate_overrides
// @ignoreProblemForFile cancel_subscriptions
// @ignoreProblemForFile constant_identifier_names
// @ignoreProblemForFile non_constant_identifier_names
// @ignoreProblemForFile implementation_imports
// @ignoreProblemForFile library_prefixes
// @ignoreProblemForFile type_annotate_public_apis
// @ignoreProblemForFile STRONG_MODE_DOWN_CAST_COMPOSITE
// @ignoreProblemForFile UNUSED_IMPORT
// @ignoreProblemForFile UNUSED_SHOWN_NAME
// @ignoreProblemForFile UNUSED_LOCAL_VARIABLE
import 'bed.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_test/src/bootstrap.dart';
import 'package:angular_test/src/errors.dart';
import 'package:angular_test/src/frontend/fixture.dart';
import 'package:angular_test/src/frontend/stabilizer.dart';
import 'package:func/func.dart';
import 'package:pageloader/html.dart';
import 'package:angular2/angular2.template.dart' as i0;
import 'package:angular_test/src/bootstrap.template.dart' as i1;
import 'package:angular_test/src/errors.template.dart' as i2;
import 'package:angular_test/src/frontend/fixture.template.dart' as i3;
import 'package:angular_test/src/frontend/stabilizer.template.dart' as i4;
export 'bed.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
}
