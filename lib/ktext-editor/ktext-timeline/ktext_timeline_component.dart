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
  @NgTwoWay('ktext')
  KText kText;
  @NgOneWay('max-time')
  double totalTime;
  
  onShadowRoot(ShadowRoot shadowRoot){
    
  }
}