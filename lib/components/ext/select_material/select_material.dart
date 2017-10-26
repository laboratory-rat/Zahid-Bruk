import 'package:angular2/angular2.dart';

@Component(
    selector: 'select-material',
    templateUrl: 'select_material.html',
    styleUrls: const ['select_material.css'],
    directives: const [COMMON_DIRECTIVES])
class SelectMaterial {
  @Input()
  List<dynamic> elements = null;

  @Output()
  dynamic selected = null;

  @Input()
  String label = '';

  String getLabel([dynamic element = null]) {
    if (element == null) element = selected;

    if (element == null) return '';
    if (label == '') return element;
    return element[label];
  }

  void selectElement(dynamic element) {
    var index = elements.indexOf(element);
    if (index > -1) {
      elements.removeAt(index);

      if (selected != null) elements.add(selected);

      selected = element;
    }

    selected = element;
  }
}
