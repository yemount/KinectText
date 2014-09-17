import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';

@Component(
    selector: 'resizable-span',
    templateUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.html',
    cssUrl: 'packages/angular_dart_demo/resizable-span/resizable_span.css',
    publishAs: 'spanCtrl')
class ResizableSpanComponent implements ShadowRootAware{
  final static int HANDLE_OFFSET = 8;
  
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
              ..left = '${kText.loc.x}px'
              ..top = '${kText.loc.y}px';
    bbox.classes.add('bbox-active');
    placeHandles(rect);
  }
  
  void onBlur(Event e) {
    selected = false;
    bbox.classes.remove('bbox-active');
  }
  
  void placeHandles(Rectangle rect) {
    nwHandle.style..left = '${-HANDLE_OFFSET}px'
                  ..top = '${-HANDLE_OFFSET}px';
    nHandle.style..left = '${rect.width/2}px'
                  ..top = '${-HANDLE_OFFSET}px';
    neHandle.style..left = '${rect.width+HANDLE_OFFSET}px'
                  ..top = '${-HANDLE_OFFSET}px';
    eHandle.style..left = '${rect.width+HANDLE_OFFSET}px'
                  ..top = '${rect.height/2}px';
    seHandle.style..left = '${rect.width+HANDLE_OFFSET}px'
                  ..top = '${rect.height+HANDLE_OFFSET}px';
    sHandle.style..left = '${rect.width/2}px'
                  ..top = '${rect.height+HANDLE_OFFSET}px';
    swHandle.style..left = '${-HANDLE_OFFSET}px'
                  ..top = '${rect.height+HANDLE_OFFSET}px';
    wHandle.style..left = '${-HANDLE_OFFSET}px'
                  ..top = '${rect.height/2}px';
  }
}