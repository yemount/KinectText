import 'dart:html';

abstract class KTextTween {
  int duration;
  String name;
  
  KTextTween(this.name, this.duration);
  
  String keyframesToString();
}