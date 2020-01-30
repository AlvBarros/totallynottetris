import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/scenes/maingame/tiles/formation.dart';
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
  }) {
    initialize();
  }

  @override
  List<SceneComponent> sceneComponents;

  List<List<Tile>> gameMatrix;
  int matrixWidth = 8;
  int matrixHeight = 16;

  void initialize() {
    sceneComponents = List<SceneComponent>();
    _frameCount = 0.0;
    gameMatrix = List<List<Tile>>();
    for (int i = 0; i < matrixHeight; i++) {
      List<Tile> row = List<Tile>();
      for (int z = 0; z < matrixWidth; z++) {
        row.add(Tile.empty(this.game));
      }
      gameMatrix.add(row);
    }

    // gameMatrix[3][2] = Tile.green(this.game);
    // gameMatrix[5][3] = Tile.purple(this.game);
    // gameMatrix[7][5] = Tile.blue(this.game);
    // gameMatrix[9][0] = Tile.yellow(this.game);
    // gameMatrix[11][2] = Tile.red(this.game);

    currentFormation = Formation.random(game);
    currentFormation.currentPosition.forEach((row) {
      row.forEach((List<int> coords) {
        if (coords[0] >= 0 && coords[1] >= 0) {
          currentFormation.tile.beingMoved = true;
          gameMatrix[coords[1]][coords[0]] = currentFormation.tile;
        }
      });
    });
  }

  @override
  void render(Canvas c) {
    double frameLeftBorder =
        (game.screenSize.width - matrixWidth * gameMatrix[0][0].size) * 0.5 -
            5.0;
    Rect frame = Rect.fromLTWH(
        frameLeftBorder,
        15,
        matrixWidth * gameMatrix[0][0].size + 10.0,
        matrixHeight * gameMatrix[0][0].size + 10.0);
    Paint framePaint = Paint()..color = Colors.white;
    c.drawRect(frame, framePaint);
    for (int y = 0; y < gameMatrix.length; y++) {
      List<Tile> row = gameMatrix[y];
      // y position = top of the frame + (n of rows * tile size)
      double yPosition = 20.0 + (y * gameMatrix[0][0].size);
      for (int x = 0; x < row.length; x++) {
        // x position = left of the frame + (current tile * tile size) + 5.0
        double xPosition = frameLeftBorder + (x * gameMatrix[0][0].size) + 5.0;
        row[x].render(c, Position(xPosition, yPosition));
      }
    }

    sceneComponents
        .forEach((SceneComponent sceneComponent) => sceneComponent.render(c));
    // Rect measureHeightRect =
    //     Rect.fromLTWH(10.0, 0.0, 5.0, game.screenSize.height * 0.65);
    // Rect measureHeightRect2 = Rect.fromLTWH(20.0, game.screenSize.height * 0.68,
    //     5.0, game.screenSize.height * 0.35);
    // Paint measurePaint = Paint()..color = Colors.green;
    // c.drawRect(measureHeightRect, measurePaint);
    // c.drawRect(measureHeightRect2, measurePaint);
  }

  double _frameCount;
  Formation currentFormation;

  @override
  void update(double t) {
    if (_frameCount != null) {
      _frameCount = _frameCount + t;
      if (_frameCount > 0.5) {

        List<dynamic> result = currentFormation.gravity(game, gameMatrix);
        gameMatrix = result[0];
        print(result[1]);
        if(result[1]){
          gameMatrix.forEach((row) {
            row.forEach((Tile tile) {
              tile.beingMoved = false;
            });
          });
          print('creating new formation');
          currentFormation = Formation.random(game);
        }

        _frameCount = 0.0;
      }
    } else {
      _frameCount = 0.0;
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
  }

  @override
  void onTapUp(TapUpDetails details) {
    
  }
}
