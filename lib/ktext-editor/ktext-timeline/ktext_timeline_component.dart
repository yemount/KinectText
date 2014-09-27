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
    
class KTextTimelineComponent{
  @NgTwoWay('ktext')
  KText kText;
  final TimelineRange range = new TimelineRange(0, 10000, 500);
}

class TimelineRange {
  final int maxTime;
  final int minTime;
  final int maxWidth;
  
  TimelineRange(this.minTime, this.maxTime, this.maxWidth);
}