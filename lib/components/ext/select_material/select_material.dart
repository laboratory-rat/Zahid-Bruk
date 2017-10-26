import 'package:angular2/angular2.dart';

@Component(
    selector: 'select-material',
    templateUrl: 'select_material.html',
    styleUrls: const ['select_material.css'],
    directives: const [COMMON_DIRECTIVES])
class SelectMaterial {
  @Input()
  set elements(List<ISelectMaterialElement> list) => {

  @Input()
  ISelectMaterialElement defaultSelected = null;

  @Input()
  String placeholder = 'Фільтр';

  @Output()
  ISelectMaterialElement selected = null;

  List<ISelectMaterialElement>_elements = null;

  SelectMaterial() {}

  void selectElement(ISelectMaterialElement element) {
    var index = elements.indexOf(element);
    if (index > -1) {
      elements.removeAt(index);

      if (selected != null) elements.add(selected);

      selected = element;
    }

    selected = element;
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

abstract class ISelectMaterialElement {
  String getLabel();
}
