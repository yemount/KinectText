library kTextAnimation;

import 'dart:html';
import 'dart:async';
import '../ktext.dart';
import 'ktext_tween.dart';
import 'fade_in_tween.dart';
import 'fade_out_tween.dart';

class KTextAnimation {
  List<Map<String, String>> keyframeStyles;
  int startTime;
  int lastTime;
  List<int> intervals;
  KTextTween enter;
  KTextTween leave;
  KText kText;
  Element elem;
  String color;
  static ShadowRoot root;
  Element get parent => root.querySelector('#main-player');
  // all css manipulation needs to be done to the shadowroot stylesheet
  CssStyleSheet get stylesheet => root.styleSheets[0] as CssStyleSheet;
  var animationEndListener;
  
  KTextAnimation.useDefault(this.kText) {
    enter = new FadeInTween('${kText.idStr}-enter', 1000);
    leave = new FadeOutTween('${kText.idStr}-leave', 1000);
    startTime = 1*1000;
    lastTime = 2000;
  }
  
  KTextAnimation(this.kText, this.enter, this.leave, this.startTime, this.lastTime);
  
  void playEnterAnim() {
    elem.classes.add("enter");
    parent.append(elem);
    List<int> hashes = injectAnim(true);
    animationEndListener = elem.on['animationend'].listen((Event e) {
      animationEndListener.cancel();
      elem.classes.remove("enter");      
      new Future.delayed(new Duration(milliseconds: lastTime), () => playLeaveAnim());
      hashes.forEach((hash) => removeAnim(hash));
    });
  }
  
  void playLeaveAnim() {
    elem.classes.add("leave");
    List<int> hashes = injectAnim(false);
    animationEndListener = elem.on['animationend'].listen((Event e) {
      animationEndListener.cancel();
      elem.classes.remove('leave');
      elem.remove();
      hashes.forEach((hash) => removeAnim(hash));
    });    
  }
  
  void play(){
    makeDomElement();
    new Future.delayed(new Duration(milliseconds: startTime), () => playEnterAnim());
  }
  
  void makeDomElement() {
    elem = new SpanElement();
    elem.id = kText.idStr;
    elem.classes.add('ktext');
    if(kText.vertical) {
      elem.classes.add('text-vertical');
    }
    elem.innerHtml = kText.text;
    elem.style..left = '${kText.loc.x}px'
              ..top = '${kText.loc.y}px'
              ..fontFamily = kText.font
              ..fontSize = '${kText.size}pt'
              ..transformOrigin = '0% 0%'
              ..transform = 'scale(${kText.scale.x}, ${kText.scale.y}) rotate(${kText.vertical ? 90 : 0}deg)';
  }
  
  List<int> injectAnim(bool isEnter) {
    int animHash, keyHash;
    KTextTween tween = isEnter ? enter : leave;
    String head = '#${elem.id}.${isEnter ? 'enter' : 'leave'}';
    String body = '-webkit-animation: ${tween.name} ${tween.duration}ms';
    animHash = injectCssRule(head, body);
    
    String keyframeHead = '@-webkit-keyframes ${tween.name}';
    String keyframeBody = tween.keyframesToString();
    keyHash = injectCssRule(keyframeHead, keyframeBody);
    return [animHash, keyHash];
  }
  
  void removeAnim(int hash) {
    for(int i = 0; i < stylesheet.cssRules.length; i++) {
      var rule = stylesheet.cssRules[i];
      if(rule.hashCode == hash) {
        stylesheet.removeRule(i);
        return;
      }
    }
  }
  
  int injectCssRule(String head, String body) {
    stylesheet.insertRule('${head} { ${body} }', 0);
    return stylesheet.rules.first.hashCode;
  }
  
  // iterate through all CSS rules to find and remove one with matching tag name
  // TODO: NYI
  void removeCssRule(String head) {
  }
}