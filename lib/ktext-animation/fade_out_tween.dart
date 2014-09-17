library fade_out_tween;
import 'ktext_tween.dart';

class FadeOutTween extends KTextTween {
  int duration;
  String name;
  
  FadeOutTween(String name, int duration): super(name, duration) {
    this.name = name;
    this.duration = duration;
  }
  
  String keyframesToString() {
    return 'from { opacity: 1;} to {opacity: 0;}';
  }
}