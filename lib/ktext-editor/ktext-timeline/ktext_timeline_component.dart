library timeline;

import 'package:angular/angular.dart';
import 'dart:html';
import '../../ktext.dart';

@Component(
    selector: 'ktext-timeline',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_component.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_component.css',
    publishAs: 'timeline')
    
class KTextTimelineComponent implements ShadowRootAware{
  final int TimelineMaxWidth = 500;
  @NgTwoWay('ktext')
  KText kText;
  @NgOneWay('max-time')
  double totalTime;
  bool expanded = false;
  
  String get enterBarLeftStr => '${(kText.anim.startTime * TimelineMaxWidth / totalTime)}px';
  String get enterBarWidthStr => '${((kText.anim.enter.duration) * TimelineMaxWidth / totalTime)}px';
  String get midBarLeftStr => '${((kText.anim.startTime + kText.anim.enter.duration) * TimelineMaxWidth / totalTime)}px';
  String get midBarWidthStr => '${(kText.anim.lastTime * TimelineMaxWidth / totalTime)}px';
  String get leaveBarLeftStr => '${((kText.anim.startTime + kText.anim.enter.duration + kText.anim.lastTime) * TimelineMaxWidth / totalTime)}px';
  String get leaveBarWidthStr => '${(kText.anim.leave.duration * TimelineMaxWidth / totalTime)}px';
  String get baselineDisplayStr => '${expanded ? 'block' : 'block'}';
  
  onShadowRoot(ShadowRoot shadowRoot){
    
  }
 
}