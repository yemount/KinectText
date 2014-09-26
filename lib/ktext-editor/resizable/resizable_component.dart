import 'package:angular/angular.dart';
import 'dart:html';
import 'package:vector_math/vector_math.dart';
import '../../ktext.dart';

@Component(
    selector: 'resizable',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/resizable/resizable_component.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/resizable/resizable_component.css',
    publishAs: 'ctrl')
class ResizableSpanComponent implements ShadowRootAware{
  final int hoff = 8;
  final int hsize = 6;
  
  @NgTwoWay('resizable')
  Resizable target;
  @NgCallback('select')
  Function onSelect;
  
  Vector2 curSize = new Vector2(0.0, 0.0);
  ShadowRoot root;
  Element child;
  
  var mouseMoveStream;
  var mouseUpStream;
  
  bool selected = false;
  bool handlersInitialized = false;
  
  
  Element get bbox => root.querySelector('#content-container');
  
  ResizableSpanComponent(Element elem){
    assert(elem.children.length == 1);
    this.child = elem.children.first;
    child.onFocus.listen((event) => onFocus(event));
    child.onBlur.listen((event) => onBlur(event));
    child.tabIndex = 0;
  }
  
  void onShadowRoot(ShadowRoot root) {
    this.root = root;
  }
  
  void onFocus(Event e) {
    selected = true;
    if(onSelect != null) onSelect();
    Rectangle rect = child.getBoundingClientRect();
    curSize..x = rect.width
            ..y = rect.height;
  }
  
  void onBlur(Event e) {
    selected = false;
  }
  
  void onClick(Event e){
    e.stopPropagation();
  }

  void onDrag(Event e, Point movement, String dir) {
    if(e!= null) e.stopImmediatePropagation();
    resize(movement, dir);
  }
  
  void resize(Point d, String dir) {
    Vector2 newLoc = target.loc.clone();
    Vector2 newSize = curSize.clone();
    
    if(dir.contains('n')){
      newLoc.y = target.loc.y + d.y;
      newSize.y = curSize.y - d.y;
    }
    if(dir.contains('s')){
      newSize.y = curSize.y + d.y; 
    }
    if(dir.contains('w')){
      // TODO take verticality into account
      newLoc.x = target.loc.x + (target.vertical ? 0 : d.x);
      newSize.x = curSize.x - d.x;
    }
    if(dir.contains('e')){
      newLoc.x = target.loc.x + (target.vertical ? d.x : 0);
      newSize.x = curSize.x + d.x;
    }
    if(dir== 'c'){
      newLoc.x = target.loc.x + d.x;
      newLoc.y = target.loc.y + d.y;
    }
    
    target.scale.x = (target.scale.x * 1.0 / curSize.x) * newSize.x;
    target.scale.y = (target.scale.y * 1.0 / curSize.y) * newSize.y;
    curSize = newSize;
    target.loc = newLoc;
  }
  
  void deactivate() {
    mouseMoveStream.cancel();
    mouseUpStream.cancel();
  }
}