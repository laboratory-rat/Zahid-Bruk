import 'package:angular2/angular2.dart';

@Component(
    selector: 'mr-material-carousel',
    directives: const[COMMON_DIRECTIVES],
    templateUrl: 'mad_rat_mcarousel.html',
    styleUrls: const['mad_rat_mcarousel.css']
)
class MRMaterialCarousel{
    @Input()
    List<CarouselObject> objects;
    
    CarouselObject get current => objects == null || objects.length < index ? null : objects[index]; 
    int index = 0;

    void front(){
        if(index + 1 >= objects.length) index = 0;
        else index++;
    }

    void back(){
        if(index - 1 < 0) index = objects.length - 1;
        else index--;
    }
}

class CarouselObject{
    String src;
    String title;
    String description;

    CarouselObject({this.title, this.src, this.description});
}