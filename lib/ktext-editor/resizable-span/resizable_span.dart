import 'package:angular/angular.dart';
import 'dart:html';
import '../../ktext.dart';
import 'package:vector_math/vector_math.dart';
import '../ktext_editor_component.dart';

@Component(
    selector: 'resizable-span',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/resizable-span/resizable_span.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/resizable-span/resizable_span.css',
    publishAs: 'spanCtrl')
class ResizableSpanComponent implements ShadowRootAware{
  final int hoff = 8;
  final int hsize = 6;
  
  @NgTwoWay('ktext')
  KText kText;
  @NgTwoWay('edctrl')
  KTextEditorComponent edctrl;
  Vector2 curSize = new Vector2(0.0, 0.0);
  ShadowRoot root;
  
  Point mouseDownLoc;
  Point mouseDownOrigin;
  Vector2 mouseDownScale;
  Vector2 mouseDownSize;
  var mouseMoveStream;
  var mouseUpStream;
  
  bool selected = false;
  bool handlersInitialized = false;
  
  
  Element get bbox => root.querySelector('#bbox');
  Element get textSpan => root.querySelector('#text-span');
  
  void onShadowRoot(ShadowRoot root) {
    this.root = root;
  }
  
  void onFocus(Event e) {
    selected = true;
    Rectangle rect = textSpan.getBoundingClientRect();
    curSize..x = rect.width
            ..y = rect.height;
    if(!handlersInitialized) {
      initHandlers();
    }
    edctrl.select(kText);
  }
  
  void onBlur(Event e) {
    selected = false;
  }
  
  void onClick(Event e) {
    e.stopPropagation();
  }
  
  void initHandlers() {
    for(Element handler in bbox.children) {
      handler.onMouseDown.listen((event) {
        activate(event, handler.id);
        event.stopPropagation();
      }) ;
    }
    bbox..onMouseDown.listen((event) {
      activate(event, "bbox");
    });
    
    handlersInitialized = true;
  }
  
  void activate(Event e, String dir) {
    saveMouseDownStates(e);
    mouseMoveStream = document.body.onMouseMove.listen((Event e) { 
      Point curMouseLoc = (e as MouseEvent).client;
      Vector2 d = new Vector2(curMouseLoc.x.toDouble() - mouseDownLoc.x, curMouseLoc.y.toDouble() - mouseDownLoc.y);
      //resize(dir, d);
    });
    mouseUpStream = document.body.onMouseUp.listen((Event e) {
      e.stopPropagation();
      deactivate();
    });
  }
  
  void saveMouseDownStates(Event e) {
    mouseDownLoc = (e as MouseEvent).client;
    mouseDownOrigin = kText.loc;
    mouseDownScale = kText.scale.clone();
    mouseDownSize = curSize.clone();
  }
  
  void onDrag(movement, msg) {
    resize(movement, 'nw');
  }
  
  void resize(Point d, String dir) {
    int newX = kText.loc.x;
    int newY = kText.loc.y;
    Vector2 newSize = curSize.clone();
    
    if(dir.contains('n')){
      newY = kText.loc.y + d.y;
      newSize.y = curSize.y - d.y;
    }
    if(dir.contains('s')){
      newSize.y = curSize.y + d.y; 
    }
    if(dir.contains('w')){
      // TODO take verticality into account
      newX = kText.loc.x + d.x;
      newSize.x = curSize.x - d.x;
    }
    if(dir.contains('e')){
      newSize.x = curSize.x + d.x;
    }
    
    kText.scale.x = (kText.scale.x * 1.0 / curSize.x) * newSize.x;
    kText.scale.y = (kText.scale.y * 1.0 / curSize.y) * newSize.y;
    curSize = newSize;
    kText.loc = new Point(newX, newY);
  }
  
//  void resize(String dir, Vector2 d) {
//    double newX = kText.loc.x.toDouble();
//    double newY = kText.loc.y.toDouble();
//    Vector2 newSize = curSize.clone();    
//    
//    if(dir.contains('n')){
//      newY = mouseDownOrigin.y + d.y;
//      newSize.y = mouseDownSize.y - d.y;
//    }
//    if(dir.contains('w')){
//      newX = mouseDownOrigin.x + (kText.vertical ? 0.0 : d.x);
//      newSize.x = mouseDownSize.x - d.x;
//    }
//    if(dir.contains('s')){
//      newSize.y = mouseDownSize.y + d.y;
//    }
//    if(dir.contains('e')){
//      newX = mouseDownOrigin.x + (kText.vertical ? d.x : 0.0);
//      newSize.x = mouseDownSize.x + d.x;
//    }
//    if(!dir.contains('n') && !dir.contains('w') && !dir.contains('s') && !dir.contains('e')) {
//      newX = mouseDownOrigin.x + d.x;
//      newY = mouseDownOrigin.y + d.y;
//    }
//    
//    kText.scale.x = (mouseDownScale.x / mouseDownSize.x) * newSize.x;
//    kText.scale.y = (mouseDownScale.y / mouseDownSize.y) * newSize.y;
//    
//    curSize.x = newSize.x;
//    curSize.y = newSize.y;
//    kText.loc = new Point(newX, newY);
//  }
//  
  void deactivate() {
    mouseMoveStream.cancel();
    mouseUpStream.cancel();
  }
}