import 'dart:async';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'mrm-carousel',
    templateUrl: 'mad_rat_material_carousel.html',
    directives: const[COMMON_DIRECTIVES],
    styleUrls: const['mad_rat_material_carousel.css'] 
)
class MadRatMaterialCarousel{
    @Input()
    List<CarouselObject> objects;
    
    @Input()
    int currentIndex = 0;
    
    @Input()
    bool showBullets = true;
    
    @Input()    
    bool showArrows = true;

    @Input()
    String width = '100%';

    @Input()
    String height = '40%';

    CarouselObject get currentObject => 
        currentIndex >= 0  || objects != null || currentIndex < objects.length 
            ? objects[currentIndex] 
            : null; 

    MadRatMaterialCarousel(){
    }

    void next(){
        if(objects == null || objects.length < 1) return;

        if(currentIndex + 1 == objects.length) currentIndex = 0;
        else currentIndex += 1;

        objects[currentIndex].isNew = false;
    }

    void back(){
        if(objects == null || objects.length < 1) return;

        if(currentIndex - 1 < 0) currentIndex = objects.length - 1;
        else currentIndex -= 1;

        objects[currentIndex].isNew = false;
    }
}

class CarouselObject{
    String src;
    String caption;
    String title;
    bool isNew = true;

    CarouselObject({this.src, this.caption, this.title});
}