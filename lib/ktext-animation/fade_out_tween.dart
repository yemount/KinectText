library fade_out_tween;
import 'ktext_tween.dart';
import '../ktext.dart';

class FadeOutTween extends KTextTween {
  
  FadeOutTween(int duration, KText ktext): super(duration, ktext) {  }
  
  String keyframesToString() {
    return 'from { opacity: 1;} to {opacity: 0;}';
  }
}