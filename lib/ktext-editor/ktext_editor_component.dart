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
    
class KTextEditorComponent implements ShadowRootAware{
  final Point CURSOR_OFFSET = new Point(8, -8); 
  
  bool active = false;
  bool textVertical = false;
  KText curText;
  String curFont = "Electrolize";
  @NgTwoWay('ktexts')
  List<KText> kTexts;
  List<String> fonts = ["Electrolize", "Quicksand", "Poiret One", "Shadows Into Light", "Open Sans", "Open Sans Condensed", "Raleway"];
  int curFontSize = 15;
  
  Point cursorLoc = new Point(0, 0);
  
  onShadowRoot(ShadowRoot shadowRoot){
  }
  
  void handleClick(Event e){
    cursorLoc = (e as MouseEvent).offset;
    commitCurrentText();
    curText.loc = cursorLoc + CURSOR_OFFSET;
  }
  
  void handleKeyUp(Event e){
      var keyCode = (e as KeyboardEvent).keyCode;
      curText.text += new String.fromCharCode(keyCode);
  }
  
  void handleBlur(Event e){
    active = false;
    commitCurrentText();
  }
  
  void commitCurrentText(){
    if(curText == null) {
      curText = new KText('', cursorLoc + CURSOR_OFFSET, curFont, curFontSize, textVertical, 'ktext${kTexts.length}');
    }
    else if(!curText.text.isEmpty){
      curText.setAnimation(new KTextAnimation(curText, new FadeInTween('${curText.id}-enter', 1000), new FadeOutTween('${curText.id}-leave', 1000), kTexts.length*1000, 2000));
      kTexts.add(curText);
      curText = new KText('', cursorLoc + CURSOR_OFFSET, curFont, curFontSize, textVertical, 'ktext${kTexts.length}');
    }
  }
  
  void setCurFont(String font) {
    curFont = font;
    if(curText != null) {
      curText.font = curFont;
    }
  }
  
  void increaseFontSize() {
    curFontSize++;
    if(curText != null) {
      curText.size = curFontSize;
    }
  }
  
  void decreaseFontSize() {
    curFontSize--;    
    if(curText != null) {
      curText.size = curFontSize;
    }
  }
  
  void changeTextOrientation() {
    textVertical = !textVertical;
    if(curText != null) {
      curText.vertical = textVertical;
    }
  }
}