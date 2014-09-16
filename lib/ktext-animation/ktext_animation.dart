library kTextAnimation;

import 'dart:html';
import 'dart:async';

class KTextAnimation {
  List<Map<String, String>> keyframeStyles;
  int curStyleIndex;
  int startTime;
  List<int> intervals;
  Element elem;
  
  
  KTextAnimation(Element elem){
    this.elem = elem;
    curStyleIndex = 0;
  }
  
  void play(int index) {
    if(index < keyframeStyles.length){
      applyStyleAt(index);
      new Future.delayed(new Duration(milliseconds: (intervals[index]*1000).toInt()), () => play(index+1));
    } else {
      return;
    }
  }
  
  void start(){
    new Future.delayed(new Duration(seconds: startTime), () => play(0));
  }
  
  void applyStyleAt(int curStyleIdx) {
    for(String key in keyframeStyles[curStyleIdx].keys){
      elem.style.setProperty(key, keyframeStyles[curStyleIdx][key]);
      elem.style.transition = "all ${intervals[curStyleIdx]}s linear";
    }
  }
}