library player;

import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';
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
    selector: 'ktext-player',
    templateUrl: 'packages/angular_dart_demo/ktext-player/ktext_player_component.html',
    cssUrl: 'packages/angular_dart_demo/ktext-player/ktext_player_component.css',
    publishAs: 'player')
    
class KTextPlayerComponent implements ShadowRootAware{
  @NgTwoWay('ktexts')
  List<KText> kTexts;
  
  onShadowRoot(ShadowRoot shadowRoot){
    KTextAnimation.root = shadowRoot;
  }
  
  void play() {
    for(KText text in kTexts) {
      text.anim.play();
    }
  }
}