library player;

import 'package:angular/angular.dart';
import 'dart:html';
import '../ktext.dart';
import '../ktext-animation/ktext_animation.dart';

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