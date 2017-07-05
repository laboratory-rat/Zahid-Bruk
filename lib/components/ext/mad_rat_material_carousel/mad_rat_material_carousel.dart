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

    bool isPrepared = false;
    String get isHidden => isPrepared ? 'visible' : 'hidden';

    CarouselObject get currentObject => 
        currentIndex >= 0  || objects != null || currentIndex < objects.length 
            ? objects[currentIndex] 
            : null; 

    MadRatMaterialCarousel(){
        new Future.delayed(const Duration(seconds : 1)).then((result){
            isPrepared = true;
        });
    }

    void next(){
        if(objects == null || objects.length < 1) return;

        if(currentIndex + 1 == objects.length) currentIndex = 0;
        else currentIndex += 1;
    }

    void back(){
        if(objects == null || objects.length < 1) return;

        if(currentIndex - 1 < 0) currentIndex = objects.length - 1;
        else currentIndex -= 1;
    }
}

class CarouselObject{
    String src;
    String caption;
    String title;

    CarouselObject({this.src, this.caption, this.title});
}