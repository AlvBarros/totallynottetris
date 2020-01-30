import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:tetris/game/scenes/maingame/maingame.dart';

import 'package:tetris/game/scenes/mainmenu/mainmenu.dart';
import 'package:tetris/util/game_scene.dart';

class TetrisGame extends Game {
  Size screenSize;
  GameScene currentScene;
 
  TetrisGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    currentScene = MainMenuScene(
      game: this,
      screenWidth: screenSize.width.toInt(),
      screenHeight: screenSize.height.toInt()
      );
  }

  void resize(Size size) {
    screenSize = size;
  }

  @override
  void render(Canvas canvas) {
    currentScene.render(canvas);
  }

  @override
  void update(double t) {
    currentScene.update(t);
  }

  void redirectToScene(GameScene nextScene) {
    currentScene = nextScene;
  }

  void onTapDown(TapDownDetails details) {
    // print('tap captured on tetris.dart');
    currentScene.onTapDown(details);
  }

  void onTapUp(TapUpDetails details) {
    print('tap up captured on tetris.dart');
    currentScene.onTapUp(details);
  }
}