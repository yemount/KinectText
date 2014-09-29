library kTextAnimation;

import 'dart:html';
import 'dart:async';
import '../ktext.dart';
import 'ktext_tween.dart';
import 'fade_in_tween.dart';
import 'fade_out_tween.dart';
import 'spin_in_tween.dart';
//import 'spin_out_tween.dart';

class KTextAnimation {
  List<Map<String, String>> keyframeStyles;
  int startTime;
  int lastTime;
  List<int> intervals;
  KTextTween enter;
  KTextTween leave;
  KText kText;
  Element elem;
  List<Element> children = new List<Element>();
  String color;
  static ShadowRoot root;
  Element get parent => root.querySelector('#main-player');
  // all css manipulation needs to be done to the shadowroot stylesheet
  CssStyleSheet get stylesheet => root.styleSheets[0] as CssStyleSheet;
  
  KTextAnimation.useDefault(this.kText) {
    enter = new SpinInTween(1000, kText);
    leave = new FadeOutTween(1000, kText);
    startTime = 1*1000;
    lastTime = 2000;
  }
  
  KTextAnimation(this.kText, this.enter, this.leave, this.startTime, this.lastTime);
  
  void playEnterAnim() {
    parent.append(elem);
    for(int i = 0; i < children.length; i++){
      Element char = children[i];
      new Future.delayed(new Duration(milliseconds: i*enter.duration~/children.length), () {
        elem.append(char);
        List<int> hashes = injectAnim(char.id, 'enter', enter);
        var animationEndListener;
        animationEndListener = char.on['animationend'].listen((Event e) {
          animationEndListener.cancel();
          hashes.forEach((hash) => removeAnim(hash));
          if(i == children.length - 1) new Future.delayed(new Duration(milliseconds: lastTime), () => playLeaveAnim());
        });
      });
    }
  }
  
  void playLeaveAnim() {
    List<int> hashes = new List<int>();
    for(int i = 0; i < children.length; i++){
      Element char = children[i];
      new Future.delayed(new Duration(milliseconds: i*enter.duration~/children.length), () {
        List<int> hashes = injectAnim(char.id, 'leave', leave);
        
        var animationEndListener;
        animationEndListener = char.on['animationend'].listen((Event e) {
          animationEndListener.cancel();
          hashes.forEach((hash) => removeAnim(hash));
          if(i != children.length - 1){
            char.style.opacity = '0';
          } else {
            elem.remove();
          }
        });
      });
    }
  }
  
  void play(){
    makeDomElement();
    new Future.delayed(new Duration(milliseconds: startTime), () => playEnterAnim());
  }
  
  void makeDomElement() {
    elem = new SpanElement();
    elem.id = kText.idStr;
    elem.classes.add('ktext');
    elem.style..left = '${kText.loc.x}px'
              ..top = '${kText.loc.y}px'
              ..fontFamily = kText.font
              ..fontSize = '${kText.size}pt'
              ..transformOrigin = '0% 0%'
              ..transform = 'scale(${kText.scale.x}, ${kText.scale.y}) rotate(${kText.vertical ? 90 : 0}deg)';
    
    if(!kText.cbc) {
      elem.innerHtml = kText.text;
    } else {
      for(int i = 0; i < kText.text.codeUnits.length; i++){
        int charCode = kText.text.codeUnits[i];
        var span = new SpanElement();
        span.innerHtml = new String.fromCharCode(charCode);
        span.id = '${elem.id}-${i}';
        children.add(span);
      };
    }
  }
  
  List<int> injectAnim(String id, String animType, KTextTween tween) {
    int animHash, keyHash;
    String head = '#${id}';
    String body = '-webkit-animation: ${id}-${animType} ${tween.duration}ms; -webkit-animation-timing-function: ease-in-out';
    animHash = injectCssRule(head, body);
    
    String keyframeHead = '@-webkit-keyframes ${id}-${animType}';
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
  
}