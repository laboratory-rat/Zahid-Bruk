import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:lab_rat_wp_api/lab_rat_wp_api.dart';
import 'dart:html';

@Component(
    selector: 'product-filter',
    templateUrl: 'product_filter.html',
    styleUrls: const['product_filter.css'],
    directives: const[COMMON_DIRECTIVES, CORE_DIRECTIVES]
)
class ProductFilter{

    @Input()
    FilterObject filter = new FilterObject();

    final StreamController _onChange = new StreamController();
    @Output()
    Stream get onChange => _onChange.stream;

    bool price110Checked = false;
    bool price110240Checked = false;
    bool price240500Checked = false;
    bool price5001200Checked = false;

    void selectCategory(WPCategory c){
        filter.currentCategory = c;
        submit();
    }

    void selectTag(WPTag tag){
        if(filter.selectedTags.any((x) => x.id == tag.id)){
            filter.selectedTags.removeWhere((x) => x.id == tag.id);
        } else{
            filter.selectedTags.add(tag);
        }

        submit();
    }

    void onPriceChenge(){
        if(price110Checked){
            filter.minPrice = 0;
            filter.maxPrice = 110;
        }

        if(price110240Checked){
            if(!price110Checked){
                filter.minPrice = 110;
            }

            filter.maxPrice = 240;
        }

        if(price240500Checked){
            if(!price110Checked && !price110240Checked){
                filter.minPrice = 240;
            }

            filter.maxPrice = 500;
        }

        if(price5001200Checked){
            if(!price110Checked && !price110240Checked && !price240500Checked){
                filter.minPrice = 500;
            }

            filter.maxPrice = 1200;
        }

        if(!price110Checked && !price110240Checked && !price240500Checked && !price5001200Checked){
            filter.maxPrice = -1;
            filter.minPrice = -1;
        }

        submit();
    }

    void submit(){
        _onChange.add(null);
    }
}

class FilterObject{
    String get displayCategory => currentCategory == null ? 'Усі' : currentCategory.name;
    WPCategory currentCategory = null;
    List<WPCategory> categories = [];

    String query = '';

    List<WPTag> tags = [];
    List<WPTag> selectedTags = [];

    int maxPrice = -1;
    int minPrice = -1;

    bool popular = false;
    bool sales = false;

    setCurrentCategory(int cat)
    {
        currentCategory = categories.firstWhere((x) => x.id == cat);
    }
}

