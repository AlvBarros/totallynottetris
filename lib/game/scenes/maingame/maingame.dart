import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/scenes/maingame/tiles/tile.dart';
import 'package:tetris/game/tetris.dart';
import 'package:tetris/util/game_scene.dart';
import 'package:tetris/util/scene_background.dart';
import 'package:tetris/util/scene_component.dart';

class MainGameScene implements GameScene {
  @override
  TetrisGame game;

  @override
  SceneBackground sceneBackground;

  MainGameScene({
    @required this.game,
  }) { initialize(); }

  @override
  List<SceneComponent> sceneComponents;


  List<List<Tile>> gameMatrix;
  int matrixWidth = 8;
  int matrixHeight = 16;

  void initialize() {
    gameMatrix = List<List<Tile>>();
    for(int i = 0; i < matrixHeight; i++) {
      List<Tile> row = List<Tile>();
      for(int z = 0; z < matrixWidth; z++) {
        row.add(Tile.empty());
      }
      gameMatrix.add(row);
    } 

    gameMatrix[3][2] = Tile.green();
    gameMatrix[5][2] = Tile.purple();
    gameMatrix[7][2] = Tile.blue();
    gameMatrix[9][2] = Tile.yellow();
    gameMatrix[11][2] = Tile.red();
  }


  @override
  void render(Canvas c) {
    double frameLeftBorder = (game.screenSize.width - matrixWidth*Tile.size)*0.5 - 10.0;
    Rect frame = Rect.fromLTWH(frameLeftBorder, 45, matrixWidth*Tile.size.toDouble()+10.0, matrixHeight*Tile.size.toDouble()+10.0);
    Paint framePaint = Paint()..color = Colors.white;
    c.drawRect(frame, framePaint);
    for(int y = 0; y < gameMatrix.length; y++) {
      List<Tile> row = gameMatrix[y];
      // y position = top of the frame + (n of rows * tile size)
      double yPosition = 50.0 + (y*Tile.size);
      for(int x = 0; x < row.length; x++) {
        // x position = left of the frame + (current tile * tile size) + 5.0
        double xPosition = frameLeftBorder + (x*Tile.size) + 5.0;
        row[x].render(c, Position(xPosition, yPosition));
      }
    }
  }

  @override
  void update(double t) {
    for (int y = 0; y < gameMatrix.length; y++) {
      for (int x = 0; x < gameMatrix[y].length; x++) {
        Tile currentTile = gameMatrix[y][x];
        if (currentTile.occupied) {
          
        }
      }
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
  }
}
