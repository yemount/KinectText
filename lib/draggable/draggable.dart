library draggable;

import 'package:angular/angular.dart';
import 'dart:html';

@Component(
    selector: 'draggable',
    cssUrl: 'packages/angular_dart_demo/draggable/draggable.css',
    templateUrl: 'packages/angular_dart_demo/draggable/draggable.html',
    publishAs: 'ctrl')

class Draggable implements ShadowRootAware{
  final Element element;
  var mouseMoveStream;
  var mouseUpStream;
  
  @NgCallback('on-drag')
  Function onDrag;

  void onShadowRoot(ShadowRoot root) {
  }
  
  Draggable(this.element) {
    element.onMouseDown.listen((event) {
      mouseMoveStream = document.body.onMouseMove.listen((event) {
        Point movement = (event as MouseEvent).movement;
        if(onDrag != null) {
          onDrag({
            '\$d': movement
          });
        }
      });
      mouseUpStream = document.body.onMouseUp.listen((event) {
        cancelStreams();
      });
    });
    
  }
  
  void cancelStreams() {
    mouseMoveStream.cancel();
    mouseUpStream.cancel();
  }
  
}