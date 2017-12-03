import 'dart:html';
import 'package:angular2/angular2.dart';

@Injectable()
class HeadService {
  static const String titleBase = 'Захід брук';

  String title = '';
  String description = 'Великій вибір бруківки';

  String keyWords = 'Бруківка,Плитка,Залізобетонні вироби,Бетонні огорожі,Тротуарна плитка,Водостоки,Римський камінь,Трапеція';
  String toolbarColor;

  Element get _elementTitle => querySelector('title');
  Element get _elementDescription => querySelector('meta[name=description]');
  Element get _elementKeyWords => querySelector('meta[name=keywords]');

  void update() {
    _elementTitle.text = titleBase + ' | ' + title;
    _elementDescription.attributes['content'] = description;
    _elementKeyWords.attributes['content'] = keyWords;
  }
}
