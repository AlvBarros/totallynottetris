import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/tetris.dart';
import 'package:tetris/util/scene_component.dart';

class PauseButton implements SceneComponent {
  final TetrisGame game;
  double width;
  double height;

  bool paused = false;

  Rect firstRect;
  Rect secondRect;
  Rect wholePauseButtonRect;
  Path triangle;

  void renderCurrentIcon(Canvas c) {
    Paint whitePaint = Paint()..color = Colors.white;
    if (!paused) {
      c.drawRect(firstRect, whitePaint);
      c.drawRect(secondRect, whitePaint);
    } else {
      c.drawPath(triangle, whitePaint);
    }
  }

  PauseButton(this.game) {
    initialize();
  }
  void initialize() {
    this.height = this.game.screenSize.height * 0.03;
    this.width = this.height * 0.2;

    this.wholePauseButtonRect = Rect.fromLTWH(this.game.screenSize.width * 0.87,
        this.game.screenSize.height * 0.047, this.width * 5.0, this.height * 1.3);

    this.firstRect = Rect.fromLTWH(this.game.screenSize.width * 0.88,
        this.game.screenSize.height * 0.05, this.width, this.height);
    this.secondRect = Rect.fromLTWH(this.game.screenSize.width * 0.91,
        this.game.screenSize.height * 0.05, this.width, this.height);

    this.triangle = Path();
    this.triangle.moveTo(
        this.game.screenSize.width * 0.88, this.game.screenSize.height * 0.05);
    this.triangle.lineTo(this.game.screenSize.width * 0.91 + this.width,
        this.game.screenSize.height * 0.065);
    this.triangle.lineTo(
        this.game.screenSize.width * 0.88, this.game.screenSize.height * 0.08);
  }

  @override
  onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
    return null;
  }

  @override
  onTapUp(TapUpDetails details) {
    if (wholePauseButtonRect.contains(details.globalPosition)){
      paused = !paused;
    }
  }

  @override
  void render(Canvas c) {
    // Paint test = Paint()..color = Colors.red;
    // c.drawRect(wholePauseButtonRect, test);
    renderCurrentIcon(c);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
