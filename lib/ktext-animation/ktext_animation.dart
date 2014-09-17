library kTextAnimation;

import 'dart:html';
import 'dart:async';
import 'ktext_tween.dart';
import '../ktext.dart';

class KTextAnimation {
  List<Map<String, String>> keyframeStyles;
  int startTime;
  int lastTime;
  List<int> intervals;
  KTextTween enter;
  KTextTween leave;
  KText kText;
  Element elem;
  static ShadowRoot root;
  Element get parent => root.querySelector('#main-player');
  // all css manipulation needs to be done to the shadowroot stylesheet
  CssStyleSheet get stylesheet => root.styleSheets[0] as CssStyleSheet;
  
  KTextAnimation(this.kText, this.enter, this.leave, this.startTime, this.lastTime){
    assert(this.kText.id != null);
    elem = new SpanElement();
    elem.id = kText.id;
    elem.classes.add('ktext');
    if(kText.vertical) {
      elem.classes.add('text-vertical');
    }
    elem.innerHtml = kText.text;
    elem.style..left = '${kText.loc.x}px'
              ..top = '${kText.loc.y}px'
              ..fontFamily = kText.font
              ..fontSize = '${kText.size}pt';
  }
  
  void playEnterAnim() {
    elem.classes.add("enter");
    parent.append(elem);
    injectAnim(true);
    elem.on['animationend'].listen((Event e) {
      elem.classes.remove("enter");      
      new Future.delayed(new Duration(milliseconds: lastTime), () => playLeaveAnim());
    });
  }
  
  void playLeaveAnim() {
    elem.classes.add("leave");
    injectAnim(false);
    elem.on['animationend'].listen((Event e) {
      elem.classes.remove('leave');
      elem.remove();
    });    
  }
  
  void play(){
    new Future.delayed(new Duration(milliseconds: startTime), () => playEnterAnim());
  }
  
  void injectAnim(bool isEnter){
    KTextTween tween = isEnter ? enter : leave;
    String head = '#${elem.id}.${isEnter ? 'enter' : 'leave'}';
    String body = '-webkit-animation: ${tween.name} ${tween.duration}ms';
    injectCssRule(head, body);
    
    String keyframeHead = '@-webkit-keyframes ${tween.name}';
    String keyframeBody = tween.keyframesToString();
    injectCssRule(keyframeHead, keyframeBody);
  }
  
  void injectCssRule(String head, String body) {
    stylesheet.insertRule('${head} { ${body} }', 0);
  }
  
  // iterate through all CSS rules to find and remove one with matching tag name
  // TODO: NYI
  void removeCssRule(String head) {
  }
}