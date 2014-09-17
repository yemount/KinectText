import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';

@Component(
    selector: 'resizable-span',
    templateUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.html',
    cssUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.css',
    publishAs: 'spanCtrl')
class ResizableSpanComponent implements ShadowRootAware{
  static final int HANDLE_OFFSET = 8;
  static final int HANDLE_SIZE = 6;
  
  @NgTwoWay('ktext')
  KText kText;
  ShadowRoot root;
  bool selected = false;
  Element get bbox => root.querySelector('#bbox');
  Element get span => root.querySelector('span');
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
    bbox.style..width = '${(rect.width).toInt()}px'
              ..height = '${(rect.height).toInt()}px'
              ..left = '0px'
              ..top = '0px';
    bbox.classes.add('bbox-active');
    placeHandles(rect);
  }
  
  void onBlur(Event e) {
    selected = false;
  }
  
  void placeHandles(Rectangle rect) {
    nwHandle.style..left = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px';
    nHandle.style..left = '${rect.width/2-HANDLE_SIZE/2}px'
                  ..top = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px';
    neHandle.style..left = '${rect.width+HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px';
    eHandle.style..left = '${rect.width+HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${rect.height/2-HANDLE_SIZE/2}px';
    seHandle.style..left = '${rect.width+HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${rect.height+HANDLE_OFFSET-HANDLE_SIZE/2}px';
    sHandle.style..left = '${rect.width/2-HANDLE_SIZE/2}px'
                  ..top = '${rect.height+HANDLE_OFFSET-HANDLE_SIZE/2}px';
    swHandle.style..left = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${rect.height+HANDLE_OFFSET-HANDLE_SIZE/2}px';
    wHandle.style..left = '${-HANDLE_OFFSET-HANDLE_SIZE/2}px'
                  ..top = '${rect.height/2-HANDLE_SIZE/2}px';
  }
  
  void activate(String dir) {
    print(dir);
    root.addEventListener('move', (event) => print('move'));
  }
}