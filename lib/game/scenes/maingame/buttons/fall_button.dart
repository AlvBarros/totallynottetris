import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/tetris.dart';
import 'package:tetris/util/scene_component.dart';

class FallButton implements SceneComponent {
  final TetrisGame game;
  double width;
  double height;

  bool paused = false;

  Rect tapbox;
  Path arrow;
  Rect arrowRect;

  FallButton(this.game) {
    initialize();
  }
  void initialize() {
    this.height = this.game.screenSize.height * 0.03;
    this.width = this.height * 0.2;

    double top = this.game.screenSize.height * 0.8;
    double bottom = this.game.screenSize.height * 0.85;
    double left = this.game.screenSize.width * 0.40;
    double right = this.game.screenSize.width * 0.60;

    arrow = Path();
    arrow.moveTo(left, top + (bottom - top) * 0.5);
    arrow.lineTo(left + (right - left) * 0.5, bottom);
    arrow.lineTo(right, top + (bottom - top) * 0.5);
    arrow.lineTo(right, top + (bottom - top) * 0.2);
    arrow.lineTo(left + (right - left) * 0.5, top + (bottom - top) * 0.7);
    arrow.lineTo(left, top + (bottom - top) * 0.2);

    this.arrowRect =
        Rect.fromLTWH(left * 0.95, top * 0.97, (right - left) * 1.25, (bottom - top) * 2);
  }

  @override
  onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
    return null;
  }

  @override
  onTapUp(TapUpDetails details) {
    if (arrowRect.contains(details.globalPosition)) {
      return true;
    }
  }

  @override
  void render(Canvas c) {
    Paint paint = Paint()..color = Colors.white;

    // Paint redPaint = Paint()..color = Colors.red;
    // Rect arrowRect =
    //     Rect.fromLTWH(left * 0.95, top * 0.97, (right - left) * 1.25, (bottom - top) * 2);
    // c.drawRect(arrowRect, redPaint);

    c.drawPath(arrow, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
