library ktext;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/animate/module.dart';

import 'package:angular_dart_demo/ktext.dart';
import 'package:angular_dart_demo/ktext-editor/ktext_editor_component.dart';
import 'package:angular_dart_demo/ktext-editor/ktext-timeline/ktext_timeline_component.dart';
import 'package:angular_dart_demo/ktext-editor/resizable-span/resizable_span.dart';
import 'package:angular_dart_demo/ktext-player/ktext_player_component.dart';
import 'package:angular_dart_demo/draggable/draggable.dart';
import 'package:angular_dart_demo/resize-area/resize-area.dart';

class MyAppModule extends Module {
  MyAppModule() {
    install(new AnimationModule());
    bind(Draggable);
    bind(ResizeArea);
    bind(KTextController);
    bind(KTextEditorComponent);
    bind(KTextPlayerComponent);
    bind(ResizableSpanComponent);
    bind(KTextTimelineComponent);
  }
}

void main() {
  applicationFactory()
      .addModule(new MyAppModule())
      .run();
}