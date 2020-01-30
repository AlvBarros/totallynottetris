import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class Tile {
  static int size = 36;
  Color color;
  bool occupied;

  Tile({Color color = Colors.black, bool occupied = false}) {
    this.color = color;
    this.occupied = occupied;
    // print('$color tile created');
  }

  void render(Canvas canvas, Position position) {
    Rect rect = Rect.fromLTWH(position.x, position.y, Tile.size.toDouble(), Tile.size.toDouble());
    Paint paint = Paint();
    paint.color = this.color == null ? Colors.black : this.color;
    canvas.drawRect(rect, paint);
  }

  List<Color> _colors = [
    Colors.black, Colors.green, Colors.pink,
    Colors.purple, Colors.yellow, Colors.grey,
    Colors.blueAccent, Colors.red
  ];

  // static Tile random() {

  // }

  static Tile empty() => Tile(color: Colors.black, occupied: false);
  static Tile green() => Tile(color: Colors.green, occupied: true);
  static Tile pink() => Tile(color: Colors.pink, occupied: true);
  static Tile purple() => Tile(color: Colors.purple, occupied: true);
  static Tile yellow() => Tile(color: Colors.yellow, occupied: true);
  static Tile grey() => Tile(color: Colors.grey, occupied: true);
  static Tile blue() => Tile(color: Colors.blueAccent, occupied: true);
  static Tile red() => Tile(color: Colors.red, occupied: true);
}