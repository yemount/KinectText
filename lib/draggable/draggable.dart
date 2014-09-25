library draggable;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(
    selector: '[on-drag]')

class Draggable{
  final Element element;
  var mouseMoveStream;
  var mouseUpStream;
  
  @NgCallback('on-drag')
  Function onDrag;
  
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