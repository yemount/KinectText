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
  
  int getNextId() {
    return kTexts.length;
  }
}

class KText {
  static List<String> colors = ['#da4336', '#4184f3', '#0e9c57', '#f3b300'];
  String text = '';
  bool vertical = false;
  Point loc;
  Vector2 scale = new Vector2(1.0, 1.0);
  int size;
  String font;
  int id = -1;
  KTextAnimation anim;
  bool editing = true;
  bool registered = false;
  String get timelineColor => colors[id % 4];
  String get idStr => 'ktext${id}';

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
  }
}

