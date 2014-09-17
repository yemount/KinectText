library ktext_controller;

import 'package:angular/angular.dart';
import 'dart:html';
import 'ktext-animation/ktext_animation.dart';

@Controller(
    selector: '[ktext]',
    publishAs: 'ctrl')
class KTextController {
  List<KText> kTexts;

  KTextController() {
    kTexts = _loadData();
  }

  List<KText> _loadData() {
    return [
    ];
  }
}

class KText {
  String text;
  bool vertical;
  Point loc;
  int size;
  String font;
  String id;
  KTextAnimation anim;

  KText(this.text, this.loc, this.font, this.size, this.vertical, this.id);
  
  // TODO: set animation with params
  void commit() {
    
  }
  
  void setAnimation(KTextAnimation _anim) {
    anim = _anim;
  }
}

