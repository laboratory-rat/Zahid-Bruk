import 'package:angular2/angular2.dart';

@Component(
    selector: 'lab-rat-carousel',
    directives: const[COMMON_DIRECTIVES],
    templateUrl: 'lab_rat_carousel.html',
    styleUrls: const ['lab_rat_carousel.css']
)
class LabRatCarousel{
    @Input()
    List<LabRatCarouselObject> objects;
    
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

    LabRatCarouselObject get currentObject => 
        currentIndex >= 0  || objects != null || currentIndex < objects.length 
            ? objects[currentIndex] 
            : null; 

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

class LabRatCarouselObject{
    String src;
    String caption;
    String title;

    LabRatCarouselObject({this.src, this.caption, this.title});
}
