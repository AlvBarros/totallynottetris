import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/tetris.dart';
import 'package:tetris/util/scene_background.dart';
import 'package:tetris/util/scene_component.dart';

abstract class GameScene {
  TetrisGame game;
  SceneBackground sceneBackground;
  List<SceneComponent> sceneComponents;
  
  void update(double t){}
  void render(Canvas c){}

  void onTapDown(TapDownDetails details) {}
}