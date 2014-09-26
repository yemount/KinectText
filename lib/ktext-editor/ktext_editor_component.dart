library editor;

import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';
import '../ktext-animation/ktext_animation.dart';

@Component(
    selector: 'ktext-editor',
    templateUrl: 'packages/angular_dart_demo/ktext-editor/ktext_editor_component.html',
    cssUrl: 'packages/angular_dart_demo/ktext-editor/ktext_editor_component.css',
    publishAs: 'editor')
    
class KTextEditorComponent{
  final Point CURSOR_OFFSET = new Point(8, -8); 
  @NgTwoWay('ktctrl')
  KTextController ktctrl;
  List<String> fonts = ["Electrolize", "Quicksand", "Poiret One", "Shadows Into Light", "Open Sans", "Open Sans Condensed", "Raleway"];
  KText curText;
  
  KTextEditorComponent() {
    curText = new KText();
  }
  
  void onClick(Event e){
    commitCurrentText(e);
    curText.editing = true;
  }
  
  void onBlur(Event e){
    commitCurrentText(e);
    curText.editing = false;
  }
  
  void onKeyUp(Event e){
    if(curText.editing){
      var keyCode = (e as KeyboardEvent).keyCode;
      curText.text += new String.fromCharCode(keyCode);
    }
  }
  
  void animateCurText() {
    curText.setAnimation(new KTextAnimation.useDefault(curText));
  }
  
  void commitCurrentText(Event e){
    if(!curText.registered && !curText.text.isEmpty){
      ktctrl.add(curText);
    }
    if(!curText.text.isEmpty) {
      curText = new KText.fromKText(curText);
    }
    if(e.type == "click") {
      Point offset = (e as MouseEvent).offset;
      curText.loc..x = offset.x.toDouble()
                ..y = offset.y.toDouble();
    }
  }
  
  void select(KText kText) {
    curText = kText;
  }
  
  void setCurFont(String font) {
    curText.font = font;
  }
  
  void increaseFontSize() {
    curText.size += 1;
  }
  
  void decreaseFontSize() {
    curText.size -= 1;
  }
  
  void changeTextOrientation() {
    curText.vertical = !curText.vertical;
  }
}