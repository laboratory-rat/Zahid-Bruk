import 'package:angular2/angular2.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'dart:html';

@Component(
    selector: 'product-filter',
    templateUrl: 'product_filter.html',
    styleUrls: const['product_filter.css'],
    directives: const[COMMON_DIRECTIVES]
)
class ProductFilter{

    @Input()
    FilterObject filter = new FilterObject();

    @Output()
    final filterSubmit = new EventEmitter();

    String get currentCategoryName => filter.displayCategory;

    bool salesOnly = false;


    void setCategory(WPCategory category){
        filter.currentCategory = category;
        querySelector('#dom-select-category').querySelector('.mdl-menu__container').classes.remove('is-visible');
    }

    void submit(){
        filterSubmit.add('submit');
    }
}

class FilterObject{
    String get displayCategory => currentCategory == null ? 'Усі' : currentCategory.name;
    WPCategory currentCategory = null;
    List<WPCategory> categories = [];

    bool salesOnly = false;

    setCurrentCategory(int cat)
    {
        currentCategory = categories.firstWhere((x) => x.id == cat);
    }
}

