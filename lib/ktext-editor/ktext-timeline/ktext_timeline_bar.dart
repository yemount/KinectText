library timelinebar;

import 'package:angular/angular.dart';
import 'dart:html';
import '../../ktext-animation/ktext_animation.dart';
import 'ktext_timeline_component.dart';

@Component(
    selector: 'ktext-timebar',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_bar.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_bar.css',
    publishAs: 'ctrl')
    
class KTextTimelineBarComponent implements ShadowRootAware{
  Element element;
  @NgTwoWay('anim')
  KTextAnimation anim;
  @NgTwoWay('tween-idx')
  int tweenIdx;
  @NgOneWay('timeline-range')
  TimelineRange range;

  
  String get opacity => this.tweenIdx == 1 ? '1' : '0.3';
  int get left {
    if(anim == null) return 0;
    int start;
    if(this.tweenIdx == 0) { 
      start = anim.startTime;
    } else if(this.tweenIdx == 1){
      start = anim.startTime + anim.enter.duration;
    } else {
      start = anim.startTime + anim.enter.duration + anim.lastTime;
    }
    var val = (start - range.minTime) * range.maxWidth ~/ (range.maxTime-range.minTime);
    return val;
  }
  
  int get width {
    if(anim == null) return 0;
    int w;
    if(this.tweenIdx == 0) {
      w = anim.enter.duration;
    } else if (this.tweenIdx == 1 ) {
      w = anim.lastTime;
    } else {
      w = anim.leave.duration;
    }
    return w * range.maxWidth ~/ (range.maxTime - range.minTime);
  }
  
  onShadowRoot(ShadowRoot root) {
  }
  
  void onDrag(Event e, Point d, String side){
    int _d = d.x * (range.maxTime - range.minTime) ~/ range.maxWidth;
    if(side == 'c') {
      if(tweenIdx == 0) {
        anim.startTime += _d;
        anim.lastTime -= _d;
      } else if (tweenIdx == 1) {
        anim.startTime += _d;
      } else if (tweenIdx == 2){
        anim.lastTime += _d;
      }
      e.stopImmediatePropagation();
    }
    else {
      if(tweenIdx == 0){
        anim.startTime += _d;
        anim.enter.duration -= _d;
      } else if (tweenIdx == 1) {
        anim.enter.duration += _d;
        anim.lastTime -= _d;
      } else if (tweenIdx == 2 && side == 'l') {
        anim.lastTime += _d;
        anim.leave.duration -= _d;
      } else if (tweenIdx == 2) {
        anim.leave.duration += _d;
      }
      e.stopImmediatePropagation();
    }
  }
  
}