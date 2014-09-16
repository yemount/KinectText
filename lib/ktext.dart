library ktext_controller;

import 'package:angular/angular.dart';
import 'dart:html';

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

  KText(this.text, this.loc, this.font, this.size, this.vertical);
}

