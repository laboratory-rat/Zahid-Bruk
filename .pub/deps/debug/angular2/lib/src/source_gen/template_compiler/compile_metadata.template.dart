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
import 'compile_metadata.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/src/dart/constant/value.dart';
import 'package:analyzer/src/dart/element/element.dart';
import 'package:analyzer/src/generated/utilities_dart.dart';
import 'package:angular2/src/compiler/compile_metadata.dart';
import 'package:angular2/src/compiler/output/output_ast.dart' as o;
import 'package:angular2/src/core/di.dart';
import 'package:angular2/src/core/di/decorators.dart';
import 'package:angular2/src/core/metadata.dart';
import 'package:angular2/src/source_gen/common/annotation_matcher.dart' as annotation_matcher;
import 'package:angular2/src/source_gen/common/url_resolver.dart';
import 'package:logging/logging.dart';
import 'package:protobuf/protobuf.dart';
import 'package:quiver/strings.dart' as strings;
import 'package:source_gen/src/annotation.dart' as source_gen;
import 'dart_object_utils.dart' as dart_objects;
import 'package:angular2/src/compiler/compile_metadata.template.dart' as i0;
import 'package:angular2/src/compiler/output/output_ast.template.dart' as i1;
import 'package:angular2/src/core/di.template.dart' as i2;
import 'package:angular2/src/core/di/decorators.template.dart' as i3;
import 'package:angular2/src/core/metadata.template.dart' as i4;
import 'package:angular2/src/source_gen/common/annotation_matcher.template.dart' as i5;
import 'package:angular2/src/source_gen/common/url_resolver.template.dart' as i6;
import 'dart_object_utils.template.dart' as i7;
export 'compile_metadata.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
i5.initReflector();
i6.initReflector();
i7.initReflector();
}
