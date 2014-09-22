library ktext_controller;

import 'package:angular/angular.dart';
import 'dart:html';
import 'ktext-animation/ktext_animation.dart';
import 'package:vector_math/vector_math.dart';

@Controller(
    selector: '[ktext]',
    publishAs: 'ctrl')
class KTextController {
  List<KText> kTexts;
  double maxTime = 10000.0;

  KTextController() {
    kTexts = _loadData();
  }

  List<KText> _loadData() {
    return [
    ];
  }
  
  void add(KText kText) {
    kText.id = getNextId();
    kTexts.add(kText);
    kText.registered = true;
  }
  
  String getNextId() {
    return 'ktext${kTexts.length}';
  }
}

class KText {
  String text = '';
  bool vertical = false;
  Point loc;
  Vector2 scale = new Vector2(1.0, 1.0);
  int size;
  String font;
  String id;
  KTextAnimation anim;
  bool editing = true;
  bool registered = false;

  KText() {
    size = 15;
    font = 'Electrolize';
    loc = new Point(-100, -100);
    text = '';
  }
    
  KText.fromKText(KText kText) {
    this..font = kText.font
        ..size = kText.size
        ..loc = kText.loc;
  }
  
  // TODO: set animation with params
  void commit() {
    
  }
  
  void setAnimation(KTextAnimation _anim) {
    anim = _anim;
    print(this.anim == null);
  }
}

