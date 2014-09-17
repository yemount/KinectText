library fade_in_tween;
import 'ktext_tween.dart';

class FadeInTween extends KTextTween {
  int duration;
  String name;
  
  FadeInTween(String name, int duration): super(name, duration) {
    this.name = name;
    this.duration = duration;
  }
  
  String keyframesToString() {
    return 'from { opacity: 0;} to {opacity: 1;}';
  }
}