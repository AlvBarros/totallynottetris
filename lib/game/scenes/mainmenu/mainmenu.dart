import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tetris/game/scenes/mainmenu/mainmenu_background.dart';
import 'package:tetris/game/scenes/mainmenu/mainmenu_options.dart';
import 'package:tetris/game/scenes/mainmenu/mainmenu_title.dart';
import 'package:tetris/game/tetris.dart';

import 'package:tetris/util/game_scene.dart';
import 'package:tetris/util/scene_background.dart';
import 'package:tetris/util/scene_component.dart';

class MainMenuScene implements GameScene {
  TetrisGame game;
  final int screenWidth;
  final int screenHeight;

  @override
  SceneBackground sceneBackground;
  
  @override
  List<SceneComponent> sceneComponents;

  MainMenuScene({
    @required this.screenWidth,
    @required this.screenHeight,
    @required this.game
  }) { initialize(); }

  void initialize() {
    sceneComponents = List<SceneComponent>();

    sceneBackground = MainMenuBackground();
    sceneComponents.add(MainMenuTitle(screenWidth: screenWidth, screenHeight: screenHeight));
    sceneComponents.add(MainMenuOptions(game: game, screenWidth: screenWidth, screenHeight: screenHeight));
  }

  @override
  void render(Canvas c) {
    sceneComponents.forEach((SceneComponent sceneComponent) => sceneComponent.render(c));
  }

  @override
  void update(double t) {
    sceneComponents.forEach((SceneComponent sceneComponent) => sceneComponent.update(t));
  }

  @override
  void onTapDown(TapDownDetails details) {
    sceneComponents.forEach((SceneComponent component) => component.onTapDown(details));
  }
}