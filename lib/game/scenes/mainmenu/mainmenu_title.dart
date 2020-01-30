import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';

import 'package:flutter/material.dart';

import 'package:tetris/util/scene_component.dart';

class MainMenuTitle implements SceneComponent {
  final int screenWidth;
  final int screenHeight;

  MainMenuTitle({ 
    @required this.screenWidth,
    @required this.screenHeight 
  });

  final String _title = "Totally Not Tetris";
  final TextConfig config = TextConfig(
    fontSize: 32.0, 
    fontFamily: 'Roboto',
    color: Colors.white,
    );

  @override
  void render(Canvas c) {
    config.render(c, _title, Position(this.screenWidth*0.2, this.screenHeight*0.2));
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
    return null;
  }

}