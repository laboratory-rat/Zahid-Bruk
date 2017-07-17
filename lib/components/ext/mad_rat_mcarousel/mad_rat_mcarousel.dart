import 'dart:async';
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

    @Input()
    int sleepTime = 5;

    @Input()
    String host = '';

    CarouselObject get current => objects == null || objects.length < index ? null : objects[index]; 
    int index = 0;
    bool isTriggered = false;
    bool isMouseEnter = false;

    MRMaterialCarousel(){
        timer();
    }

    Future timer() async{
        while(true){

            await new Future.delayed(new Duration(seconds : sleepTime));

            if(isMouseEnter) continue;

            if(isTriggered){
                isTriggered = false;
                continue;
            }

            front();
        }
    }

    void mouseenter(){
        isMouseEnter = true;
    }

    void mouseleave() {
        isMouseEnter = false;
        isTriggered = true;
    }

    void front(){
        if (current == null) return;
        if(index + 1 >= objects.length) index = 0;
        else index++;

        isTriggered = true;
    }

    void back(){
        if (current == null) return;
        if(index - 1 < 0) index = objects.length - 1;
        else index--;

        isTriggered = true;
    }
}

class CarouselObject{
    String src;
    String title;
    String description;

    CarouselObject({this.title, this.src, this.description});
    CarouselObject.empty();
}