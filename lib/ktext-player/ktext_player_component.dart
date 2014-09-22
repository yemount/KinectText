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
  @NgTwoWay('ktctrl')
  KTextController ktctrl;
  
  onShadowRoot(ShadowRoot shadowRoot){
    KTextAnimation.root = shadowRoot;
  }
  
  void play() {
    for(KText text in ktctrl.kTexts) {
      if(text.anim != null) {
        text.anim.play();
      }
    }
  }
}