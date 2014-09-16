import 'dart:html';
import 'ktext_animation.dart';

class FadeInOutAnimation extends KTextAnimation{
  List<int> keyframes;
  
  FadeInOutAnimation(Element elem, List<int> keyframes): super(elem){
    assert(keyframes.length == 4);
    this.keyframes = keyframes; 
    
    this.elem.style.opacity = '0';
    this.keyframeStyles = [{'opacity': '1'},
                           {'opacity': '1'},
                           {'opacity': '0'}];
    this.startTime = keyframes[0];
    this.intervals = [keyframes[1], keyframes[2], keyframes[3]];
  }
}