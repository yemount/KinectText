library ktext;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/animate/module.dart';

import 'package:angular_dart_demo/ktext.dart';
import 'package:angular_dart_demo/ktext-editor/ktext_editor_component.dart';

class MyAppModule extends Module {
  MyAppModule() {
    install(new AnimationModule());
    bind(KTextController);
    bind(KTextEditorComponent);
  }
}

void main() {
  applicationFactory()
      .addModule(new MyAppModule())
      .run();
}