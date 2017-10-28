import 'dart:html';

import 'package:angular2/angular2.dart';

abstract class ISelectMaterialElement {
  String getLabel();
}

@Component(
    selector: 'select-material',
    templateUrl: 'select_material.html',
    styleUrls: const ['select_material.css'],
    directives: const [COMMON_DIRECTIVES])
class SelectMaterial {
  @Input()
  String label = 'label';

  @Input()
  List<ISelectMaterialElement> elements;

  @Output()
  ISelectMaterialElement current;

  @Input()
  set defaultElement(ISelectMaterialElement e) => current == null ? select(e) : null;

  void select(ISelectMaterialElement e) {
    var index = elements.indexOf(e);

    if (index < 0) return;

    if (current != null) {
      elements.add(current);
    }

    current = e;
    elements.removeAt(index);
  }
}

class SelectMaterialElement extends ISelectMaterialElement {
  String id;
  String label;

  SelectMaterialElement(this.id, this.label);

  @override
  String getLabel() {
    return label;
  }
}
