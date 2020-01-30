import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';

import 'package:flutter/material.dart';
import 'package:tetris/game/scenes/maingame/maingame.dart';
import 'package:tetris/game/tetris.dart';

import 'package:tetris/util/scene_component.dart';

class MainMenuOptions with TapDetector implements SceneComponent  {
  final TetrisGame game;
  final int screenWidth;
  final int screenHeight;

  MainMenuOptions({ 
    @required this.game,
    @required this.screenWidth,
    @required this.screenHeight 
  }) { initialize(); }

  final TextConfig config = TextConfig(
    fontSize: 24.0, 
    fontFamily: 'Roboto',
    color: Colors.white,
    );

  List<String> options;

  void initialize() {
    options = List<String>();
    options.add('Play');
    options.add('Quit');
  }

  @override
  void render(Canvas c) {
    config.render(c, options[0], Position(this.screenWidth*0.25, this.screenHeight*0.55));
    // config.render(c, options[1], Position(this.screenWidth*0.25, this.screenHeight*0.55+42));

    // Rect testRect = Rect.fromLTWH(this.screenWidth*0.25, this.screenHeight*0.55, 48.0, 24.0);
    // Paint testPaint = Paint();
    // testPaint.color = Colors.green;
    // c.drawRect(testRect, testPaint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void onTapDown(TapDownDetails details) {
    print('tapdown on ${details.globalPosition.dx}:${details.globalPosition.dy}');
    if (details.globalPosition.dx >= this.screenWidth*0.25 &&
        details.globalPosition.dx <= this.screenWidth*0.25 + 48.0 &&
        details.globalPosition.dy >= this.screenHeight*0.55 &&
        details.globalPosition.dy <= this.screenHeight*0.55 + 24.0) {
      game.redirectToScene(MainGameScene(game: game));
    }
  }

}