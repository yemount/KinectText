library timeline;

import 'package:angular/angular.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:html';
import '../../ktext.dart';

@Component(
    selector: 'ktext-timeline',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_component.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_component.css',
    publishAs: 'ctrl')
    
class KTextTimelineComponent implements ShadowRootAware{
  final int TimelineMaxWidth = 500;
  @NgTwoWay('ktext')
  KText kText;
  @NgOneWay('max-time')
  double totalTime;
  bool expanded = false;
  
  ShadowRoot root;
  Element get enterBarElem => root.querySelector('#enterBar');
  Element get midBarElem => root.querySelector('#midBar');
  Element get leaveBarElem => root.querySelector('#leaveBar');
  
  KTextTimelineBar enterBar = new KTextTimelineBar();
  KTextTimelineBar midBar = new KTextTimelineBar();
  KTextTimelineBar leaveBar = new KTextTimelineBar();
  
  //String get baselineDisplayStr => '${expanded ? 'block' : 'block'}';
  
  onShadowRoot(ShadowRoot shadowRoot){
    this.root = shadowRoot;
    enterBar..loc = new Vector2(kText.anim.startTime * TimelineMaxWidth / totalTime, 5.0)
            ..width = kText.anim.enter.duration * TimelineMaxWidth / totalTime;
    midBar..loc = new Vector2((kText.anim.startTime + kText.anim.enter.duration) * TimelineMaxWidth / totalTime, 5.0)
          ..width = kText.anim.lastTime * TimelineMaxWidth / totalTime;
    leaveBar..loc = new Vector2((kText.anim.startTime + kText.anim.enter.duration + kText.anim.lastTime) * TimelineMaxWidth / totalTime, 5.0)
          ..width = kText.anim.leave.duration * TimelineMaxWidth / totalTime;
  }
 
}

class KTextTimelineBar extends Resizable {
  Vector2 _scale = new Vector2(1.0, 1.0);
  Vector2 get scale => _scale;
  void set scale(Vector2 val) {
    print('set scale ${val}');
  }
  
  double width;
}