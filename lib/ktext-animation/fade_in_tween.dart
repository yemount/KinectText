library fade_in_tween;
import 'ktext_tween.dart';
import '../ktext.dart';

class FadeInTween extends KTextTween {
  
  FadeInTween(int duration, KText kText): super(duration, kText) {  }
  
  String keyframesToString() {
    return 'from { opacity: 0;} to {opacity: 1;}';
  }
}