import 'dart:html' as html;

import 'package:angular2/angular2.dart';


@Component(selector: 'about-file-slider', templateUrl: 'about_file_slider.html', styleUrls: const ['about_file_slider.css'], directives: const[COMMON_DIRECTIVES])
class AboutFileSlider{
  @Input()
  List<AboutFileSliderElement> elements = new List<AboutFileSliderElement>();

  @Input()
  int onPageDesktop = 3;

  @Input()
  int onPageTablet = 2;

  @Input()
  int onPageMobile = 1;

  int _cursor = 0;

  html.Element _container;
  html.Element get container => _container == null ? _container = html.querySelector('.slider-container') : _container; 

  int get factor => html.window.outerWidth > 900 ? 3 : 1; 

  String getElementX(int index){
    var fullWidth = container.clientWidth;
    return (index * fullWidth / factor).toString() + 'px';
  }

  String getElementTranslateX(int index){
    var value = (container.clientWidth / factor * _cursor).toString() + 'px';
    return 'translateX(-' + value + ')';
  }

  bool isArrowsHidden(){
    if(elements.length < factor) return true;
    return false;
  }

  bool isArrowActive(bool right){
    if(right) return _cursor + factor < elements.length;
    return _cursor != 0;
  }

  void changeCursor(bool plus){
    if(plus && _cursor + factor >= elements.length) return;
    if(!plus && _cursor == 0) return;

    if(plus) ++_cursor;
    else --_cursor;
  }

  void openFile(AboutFileSliderElement element){
    html.window.open(element.imageUrl, '_blank');
  }

}

class AboutFileSliderElement{
  final String title;
  final String description;
  final String imageUrl;

  AboutFileSliderElement({this.title, this.description, this.imageUrl});
}