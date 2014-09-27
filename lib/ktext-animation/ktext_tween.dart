library ktext_tween;

abstract class KTextTween {
  int duration;
  String name;
  
  KTextTween(this.name, this.duration);
  
  String keyframesToString();
}