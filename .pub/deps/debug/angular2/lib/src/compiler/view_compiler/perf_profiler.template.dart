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
import 'perf_profiler.dart';
import '../../debug/profile_keys.dart';
import '../identifiers.dart';
import '../output/output_ast.dart' as o;
import 'compile_view.dart';
import '../../debug/profile_keys.template.dart' as i0;
import '../identifiers.template.dart' as i1;
import '../output/output_ast.template.dart' as i2;
import 'compile_view.template.dart' as i3;
export 'perf_profiler.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
}
