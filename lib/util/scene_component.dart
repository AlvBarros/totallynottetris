import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';

abstract class SceneComponent {
  void update(double t) {}
  void render(Canvas c) {}

  onTapDown(TapDownDetails details) {}
  onTapUp(TapUpDetails details) {}
}