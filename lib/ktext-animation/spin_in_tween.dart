library spin_in_tween;
import 'ktext_tween.dart';
import '../ktext.dart';

class SpinInTween extends KTextTween {
  
  SpinInTween(int duration, KText ktext): super(duration, ktext) {  }
  
  String keyframesToString() {
    int rot = kText.vertical ? 90 : 0;
    return 'from { opacity: 0; -webkit-transform: scale(0, 0) rotate(${rot}deg); } to {opacity: 1; -webkit-transform: scale(${kText.scale.x}, ${kText.scale.y}) rotate(${rot+360}deg);}';
  }
}