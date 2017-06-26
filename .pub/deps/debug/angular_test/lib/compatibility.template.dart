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
import 'compatibility.dart';
import 'package:angular_test/src/frontend/fixture.template.dart' as i0;
import 'package:angular_test/src/frontend/bed.template.dart' as i1;
export 'compatibility.dart';
export 'package:angular_test/src/frontend/fixture.dart' show componentOfFixture, injectFromFixture;
export 'package:angular_test/src/frontend/bed.dart' show createDynamicFixture, createDynamicTestBed;

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
}
