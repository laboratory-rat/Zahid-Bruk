import 'dart:html';

class LRScrollAnimation {
  static void scroll(String selector, {int offset: 0, int duration: 500}) {
    int targetPosition = querySelector('$selector').offsetTop;
    targetPosition += offset;
    int totalFrames = (duration / (1000 / 60)).round();
    int currentFrame = 0;
    int currentPosition = window.scrollY;
    int distanceBetween = targetPosition - currentPosition;
    num distancePerFrame = distanceBetween / totalFrames;

    void animation(num frame) {
      if (totalFrames >= currentFrame) {
        window.scrollTo(0, currentPosition);
        currentPosition += distancePerFrame;
        currentFrame++;
        window.animationFrame.then(animation);
      }
    }

    window.animationFrame.then(animation);
  }

  static void attachToLink(String selector, {int offset: 0, int duration: 500}) {
    querySelectorAll(selector).onClick.listen((click) {
      click.preventDefault();
      String link = click.target.toString();
      String anchor = link.substring(link.indexOf('#'));
      scroll(anchor, offset: offset, duration: duration);
    });
  }
}
