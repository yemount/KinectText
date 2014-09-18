import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';
import 'package:vector_math/vector_math.dart';

@Component(
    selector: 'resizable-span',
    templateUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.html',
    cssUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.css',
    publishAs: 'spanCtrl')
class ResizableSpanComponent implements ShadowRootAware{
  final int hoff = 8;
  final int hsize = 6;
  
  @NgTwoWay('ktext')
  KText kText;
  Vector2 curSize = new Vector2(0.0, 0.0);
  ShadowRoot root;
  bool selected = false;
  int test = 20;
  Point mouseDownLoc;
  var mouseMoveStream;
  var mouseUpStream;
  
  Element get bbox => root.querySelector('#bbox');
  Element get span => root.querySelector('#text-span');
  Element get nwHandle => root.querySelector('#nwHandle');
  Element get nHandle => root.querySelector('#nHandle');
  Element get neHandle => root.querySelector('#neHandle');
  Element get eHandle => root.querySelector('#eHandle');
  Element get seHandle => root.querySelector('#seHandle');
  Element get sHandle => root.querySelector('#sHandle');
  Element get swHandle => root.querySelector('#swHandle');
  Element get wHandle => root.querySelector('#wHandle');
  
  void onShadowRoot(ShadowRoot root) {
    this.root = root;
  }
  
  void onFocus(Event e) {
    selected = true;
    Rectangle rect = span.getBoundingClientRect();
    curSize..x = rect.width
            ..y = rect.height;
  }
  
  void onBlur(Event e) {
    selected = false;
  }
  
  void activate(Event e, String dir) {
    mouseDownLoc = (e as MouseEvent).client;
    Point oldLoc = kText.loc;
    Vector2 oldScale = kText.scale.clone();
    Vector2 oldSize = curSize.clone();
    Vector2 newSize = curSize.clone();
    double newX = kText.loc.x.toDouble();
    double newY = kText.loc.y.toDouble();
    mouseMoveStream = document.body.onMouseMove.listen((Event e) { 
      Point curMouseLoc = (e as MouseEvent).client;
      Vector2 d = new Vector2(curMouseLoc.x.toDouble() - mouseDownLoc.x, curMouseLoc.y.toDouble() - mouseDownLoc.y);
      if(dir.contains('n')){
        newY = oldLoc.y + d.y;
        newSize.y = oldSize.y - d.y;
      }
      if(dir.contains('w')){
        newX = oldLoc.x + d.x;
        newSize.x = oldSize.x - d.x;
      }
      if(dir.contains('s')){
        newSize.y = oldSize.y + d.y;
      }
      if(dir.contains('e')){
        newSize.x = oldSize.x + d.x;
      }
      kText.scale.x = (oldScale.x / oldSize.x) * newSize.x;
      kText.scale.y = (oldScale.y / oldSize.y) * newSize.y;
      
      curSize.x = newSize.x;
      curSize.y = newSize.y;
      kText.loc = new Point(newX, newY);
      span.style..left = '${kText.loc.x}px'
                ..top = '${kText.loc.y}px';
    });
    mouseUpStream = document.body.onMouseUp.listen((Event e) {
      deactivate(e);
    });
  }
  
  void deactivate(Event e) {
    mouseMoveStream.cancel();
    mouseUpStream.cancel();
  }
  
  void resize(Point origin, Vector2 scale) {
    
  }
}