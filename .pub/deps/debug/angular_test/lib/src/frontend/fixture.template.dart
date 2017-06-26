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
import 'fixture.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/src/core/linker/view_ref.dart';
import 'package:angular2/src/debug/debug_app_view.dart';
import 'package:angular2/src/debug/debug_node.dart';
import 'package:angular_test/src/frontend/bed.dart';
import 'package:angular_test/src/frontend/stabilizer.dart';
import 'package:func/func.dart';
import 'package:pageloader/objects.dart';
import 'package:angular2/angular2.template.dart' as i0;
import 'package:angular2/src/core/linker/view_ref.template.dart' as i1;
import 'package:angular2/src/debug/debug_app_view.template.dart' as i2;
import 'package:angular2/src/debug/debug_node.template.dart' as i3;
import 'package:angular_test/src/frontend/bed.template.dart' as i4;
import 'package:angular_test/src/frontend/stabilizer.template.dart' as i5;
export 'fixture.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
i5.initReflector();
}
