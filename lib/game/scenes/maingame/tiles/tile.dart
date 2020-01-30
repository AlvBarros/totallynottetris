import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';

import '../../../tetris.dart';

class Tile {
  double size;
  Color color;
  bool occupied;
  bool justUpdated;
  bool beingMoved;

  Tile({@required TetrisGame game, Color color = Colors.black, bool occupied = false}) {
    this.color = color;
    this.occupied = occupied;
    // matrix size = 10 + % * 8 , 10 + % * 16
    this.size = (game.screenSize.height * 0.6) / 16;
    justUpdated = false;
    beingMoved = false;
  }

  void render(Canvas canvas, Position position) {
    Rect rect = Rect.fromLTWH(position.x, position.y, this.size, this.size);
    Paint paint = Paint();
    paint.color = this.color == null ? Colors.black : this.color;
    canvas.drawRect(rect, paint);
  }

  static List<Color> colors = [
    Colors.green, 
    Colors.pink,
    Colors.purple, 
    Colors.yellow, 
    Colors.grey,
    Colors.blueAccent, 
    Colors.red
  ];

  static Tile empty(TetrisGame game) => Tile(game: game, color: Colors.black, occupied: false);
  static Tile green(TetrisGame game) => Tile(game: game, color: Colors.green, occupied: true);
  static Tile pink(TetrisGame game) => Tile(game: game, color: Colors.pink, occupied: true);
  static Tile purple(TetrisGame game) => Tile(game: game, color: Colors.purple, occupied: true);
  static Tile yellow(TetrisGame game) => Tile(game: game, color: Colors.yellow, occupied: true);
  static Tile grey(TetrisGame game) => Tile(game: game, color: Colors.grey, occupied: true);
  static Tile blue(TetrisGame game) => Tile(game: game, color: Colors.blueAccent, occupied: true);
  static Tile red(TetrisGame game) => Tile(game: game, color: Colors.red, occupied: true);

  static Tile fromColor(TetrisGame game, Color color) => Tile(game: game, color: color, occupied: true);
}