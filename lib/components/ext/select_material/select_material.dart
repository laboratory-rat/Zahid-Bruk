import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';

abstract class ISelectMaterialElement {
  String getLabel();
  String getId();
}

@Component(selector: 'select-material', templateUrl: 'select_material.html', styleUrls: const ['select_material.css'], directives: const [COMMON_DIRECTIVES])
class SelectMaterial {
  @Input()
  String label = 'label';

  @Input()
  List<ISelectMaterialElement> elements;

  @Input()
  ISelectMaterialElement current = null;

  StreamController<ISelectMaterialElement> _onSelect = new StreamController<ISelectMaterialElement>();
  @Output()
  Stream get onSelect => _onSelect.stream;

  String id;

  SelectMaterial() {
    id = this.hashCode.toString();
  }

  void select(ISelectMaterialElement e, [bool isSilent = false]) {
    current = e;

    if (elements == null) {
      elements = [e];
    } else if (!elements.any((x) => x.getLabel() == e.getLabel())) {
      elements.add(e);
    }

    if (!isSilent) _onSelect.add(current);
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

  @override
  String getId() {
    return id;
  }
}
