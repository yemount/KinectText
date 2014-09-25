library resize_area;

import 'package:angular/angular.dart';
import 'dart:html';

@Component(
    selector: 'resize-area',
    templateUrl: 'packages/angular_dart_demo/resize-area/resize-area.html',
    cssUrl: 'packages/angular_dart_demo/resize-area/resize-area.css',
    publishAs: 'cmp')
    
class ResizeArea {
  static final _RESIZE_DIRECTIONS = ['n', 'ne', 'e', 'se', 's', 'ws', 'w', 'nw']; 
  Element element;
  Element selected;
  Rectangle curSize;
  
  List<Element> handles;
  
  ResizeArea(this.element) {
    element.querySelectorAll('.resizable').forEach((elem) => 
      elem.onMouseDown.listen((event) => select(elem))
    );
  }
  
  void select(Element elem) {
    selected = elem;
    placeDragHandles();
  }
  
  void placeDragHandles() {
    
    if(handles != null) {
      initDragHandles();
    }

    Rectangle rect = elem.getBoundingClientRect();
    Rectangle offset = elem.offset;
    DivElement div = new DivElement();
    div.style..position = 'absolute'
              ..width = '${rect.width}px'
              ..height = '${rect.height}px'
              ..left = '${offset.left}px'
              ..top = '${offset.top}px'
              ..border = '1px dashed black';
    elem.append(div);
    
    _RESIZE_DIRECTIONS.forEach((String dir) {
      
    });
  }
  
  void initDragHandles() {
    for()
  }
  
}