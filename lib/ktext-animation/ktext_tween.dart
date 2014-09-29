library ktext_tween;

import '../ktext.dart';

abstract class KTextTween {
  int duration;
  KText kText;
  
  KTextTween(this.duration, this.kText);
  
  String keyframesToString();
}