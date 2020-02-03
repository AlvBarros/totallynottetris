import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/tetris.dart';
import 'package:tetris/util/scene_component.dart';

class MoveLeftButton implements SceneComponent {
  final TetrisGame game;

  MoveLeftButton(this.game) {
    initialize();
  }
  void initialize() {
    double top = this.game.screenSize.height * 0.8;
    double bottom = this.game.screenSize.height * 0.85;
    double left = this.game.screenSize.width * 0.10;
    double right = this.game.screenSize.width * 0.30;

    arrowPath = Path();
    arrowPath.moveTo(left + (right - left) * 0.50, top);
    arrowPath.lineTo(left + (right - left) * 0.3, top + (bottom - top) * 0.5);
    arrowPath.lineTo(left + (right - left) * 0.50, bottom);
    arrowPath.lineTo(left + (right - left) * 0.65, bottom);
    arrowPath.lineTo(
        left +
            (right - left) * 0.3 +
            ((right - left) * 0.65 - (right - left) * 0.5),
        top + (bottom - top) * 0.5);
    arrowPath.lineTo(left + (right - left) * 0.65, top);

    arrowRect =
        Rect.fromLTWH(left, top * 0.97, right - left, (bottom - top) * 2);
  }

  Path arrowPath;
  Rect arrowRect;

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
    Paint whitePaint = Paint()..color = Colors.white;

    // Paint redPaint = Paint()..color = Colors.red;
    // double top = this.game.screenSize.height * 0.8;
    // double bottom = this.game.screenSize.height * 0.85;
    // double left = this.game.screenSize.width * 0.10;
    // double right = this.game.screenSize.width * 0.30;
    // arrowRect = Rect.fromLTWH(left, top * 0.97, right - left, (bottom - top) * 2);
    // c.drawRect(arrowRect, redPaint);

    c.drawPath(arrowPath, whitePaint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

class MoveRightButton implements SceneComponent {
  final TetrisGame game;

  MoveRightButton(this.game) {
    initialize();
  }
  void initialize() {
    double top = this.game.screenSize.height * 0.8;
    double bottom = this.game.screenSize.height * 0.85;
    double left = this.game.screenSize.width * 0.70;
    double right = this.game.screenSize.width * 0.90;

    arrowPath = Path();
    arrowPath.moveTo(left + (right - left) * 0.50, top);
    // arrowPath.lineTo(left + (right - left) * 0.3, top + (bottom - top) * 0.5);
    arrowPath.lineTo(right - (right - left) * 0.3, top + (bottom - top) * 0.5);
    // arrowPath.lineTo(left + (right - left) * 0.50, bottom);
    arrowPath.lineTo(right - (right - left) * 0.5, bottom);
    // arrowPath.lineTo(left + (right - left) * 0.65, bottom);
    arrowPath.lineTo(right - (right - left) * 0.65, bottom);
    // arrowPath.lineTo(
    //     left + (right - left) * 0.3 + ((right - left) * 0.65 - (right - left) * 0.5),
    //     top + (bottom - top) * 0.5);
    arrowPath.lineTo(
        right -
            (right - left) * 0.3 -
            ((right - left) * 0.65 - (right - left) * 0.5),
        top + (bottom - top) * 0.5);
    // arrowPath.lineTo(left + (right - left) * 0.65, top);
    arrowPath.lineTo(left + (right - left) * 0.35, top);

    arrowRect =
        Rect.fromLTWH(left, top * 0.97, right - left, (bottom - top) * 2);
  }

  Path arrowPath;
  Rect arrowRect;

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
    Paint whitePaint = Paint()..color = Colors.white;

    // Paint redPaint = Paint()..color = Colors.red;
    // double top = this.game.screenSize.height * 0.8;
    // double bottom = this.game.screenSize.height * 0.85;
    // double left = this.game.screenSize.width * 0.70;
    // double right = this.game.screenSize.width * 0.90;
    // arrowRect =
    //     Rect.fromLTWH(left, top * 0.97, right - left, (bottom - top) * 2);
    // c.drawRect(arrowRect, redPaint);

    c.drawPath(arrowPath, whitePaint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
