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
import 'errors.dart';
import 'package:angular_test/src/errors/generic_type_missing.template.dart' as i0;
import 'package:angular_test/src/errors/test_already_running.template.dart' as i1;
import 'package:angular_test/src/errors/will_never_stabilize.template.dart' as i2;
export 'errors.dart';
export 'package:angular_test/src/errors/generic_type_missing.dart';
export 'package:angular_test/src/errors/test_already_running.dart';
export 'package:angular_test/src/errors/will_never_stabilize.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
}
