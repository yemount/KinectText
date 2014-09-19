library editor;

import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';
import '../ktext-animation/fade_in_tween.dart';
import '../ktext-animation/fade_out_tween.dart';
import '../ktext-animation/ktext_animation.dart';

/* Use the @Component annotation to indicate that this class is an
 * Angular component.
 *
 * The selector field defines the CSS selector that will trigger the
 * component. Typically, the CSS selector is an element name.
 *
 * The templateUrl field tells the component which HTML template to use
 * for its view.
 *
 * The cssUrl field tells the component which CSS file to use.
 *
 * The publishAs field specifies that the component instance should be
 * assigned to the current scope under the name specified.
 *
 * The class field and setter annotated with @NgTwoWay and @NgAttr,
 * respectively, identify the attributes that can be set on
 * the component. Users of this component will specify these attributes
 * in the HTML tag that is used to create the component. For example:
 *
 * <rating max-rating="5" rating="mycontrol.rating">
 *
 * The component's public fields are available for data binding from the
 * component's view. Similarly, the component's public methods can be
 * invoked from the component's view.
 */
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
  }
  
  void onBlur(Event e){
    commitCurrentText(e);
  }
  
  void onKeyUp(Event e){
    if(curText.editing){
      var keyCode = (e as KeyboardEvent).keyCode;
      curText.text += new String.fromCharCode(keyCode);
    }
  }
  
  void commitCurrentText(Event e){
    if(!curText.registered && !curText.text.isEmpty){
      curText.editing = false;
      curText.setAnimation(new KTextAnimation(curText, new FadeInTween('${curText.id}-enter', 1000), new FadeOutTween('${curText.id}-leave', 1000), ktctrl.kTexts.length*1000, 2000));
      ktctrl.add(curText);
    }
    if(!curText.text.isEmpty) {
      curText = new KText();
    }
    if(e.type == "click") {
      curText.loc = (e as MouseEvent).offset;
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