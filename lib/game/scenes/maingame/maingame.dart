import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:tetris/game/scenes/maingame/buttons/move_buttons.dart';
import 'package:tetris/game/scenes/maingame/buttons/pause_button.dart';
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

  PauseButton pauseButton;
  MoveLeftButton moveLeftButton;
  MoveRightButton moveRightButton;

  List<String> movementQueue;

  void initialize() {
    movementQueue = List<String>();
    sceneComponents = List<SceneComponent>();
    pauseButton = PauseButton(game);
    moveLeftButton = MoveLeftButton(game);
    moveRightButton = MoveRightButton(game);
    _frameCount = 0.0;
    gameMatrix = List<List<Tile>>();
    for (int i = 0; i < matrixHeight; i++) {
      List<Tile> row = List<Tile>();
      for (int z = 0; z < matrixWidth; z++) {
        row.add(Tile.empty(this.game));
      }
      gameMatrix.add(row);
    }

    currentFormation = Formation(game);
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
    pauseButton.render(c);
    moveLeftButton.render(c);
    moveRightButton.render(c);

    double frameLeftBorder =
        (game.screenSize.width - matrixWidth * gameMatrix[0][0].size) * 0.5 -
            5.0;
    Rect frame = Rect.fromLTWH(
        frameLeftBorder,
        game.screenSize.height * 0.05,
        matrixWidth * gameMatrix[0][0].size + 10.0,
        matrixHeight * gameMatrix[0][0].size + 10.0);
    Paint framePaint = Paint()..color = Colors.white;
    c.drawRect(frame, framePaint);
    for (int y = 0; y < gameMatrix.length; y++) {
      List<Tile> row = gameMatrix[y];
      // y position = top of the frame + (n of rows * tile size)
      double yPosition =
          game.screenSize.height * 0.05 + 5.0 + (y * gameMatrix[0][0].size);
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
    if (currentFormation == null) {
      currentFormation = Formation(game);
    }
    if (!pauseButton.paused) {
      if (_frameCount != null) {
        _frameCount = _frameCount + t;
        if (movementQueue.length > 0) {
          movementQueue.forEach((movement) {
            gameMatrix = currentFormation.move(gameMatrix, movement: movement);
          });
          movementQueue = List<String>();
        }
        if (_frameCount > 0.3) {
          List<dynamic> result = currentFormation.gravity(gameMatrix);
          gameMatrix = result[0];
          if (result[1]) {
            gameMatrix.forEach((row) {
              row.forEach((Tile tile) {
                tile.beingMoved = false;
              });
            });
            currentFormation = null;
            clearFullLines();
          }
          _frameCount = 0.0;
        }
      } else {
        _frameCount = 0.0;
      }
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    sceneComponents.forEach(
        (SceneComponent sceneComponent) => sceneComponent.onTapDown(details));
  }

  @override
  void onTapUp(TapUpDetails details) {
    pauseButton.onTapUp(details);
    bool moveLeft = moveLeftButton.onTapUp(details) ?? false;
    bool moveRight = moveRightButton.onTapUp(details) ?? false;
    // print('${moveLeft ? "left" : moveRight ? "right" : "none"}');
    if (moveLeft) {
      movementQueue.add("left");
    }
    if (moveRight) {
      movementQueue.add("right");
    }
  }

  void clearFullLines() {
    for(int r = gameMatrix.length - 1; r >= 0; r--){
      List<Tile> currentRow = gameMatrix[r];
      int numOccupied = currentRow.where((tile) => tile.occupied).length;
      if (numOccupied == currentRow.length) {
        gameMatrix.remove(currentRow);
      }
    }
    List<List<Tile>> templateList = List<List<Tile>>();
    while(templateList.length != 16) {
      templateList.add(<Tile>[
        Tile.empty(game), Tile.empty(game), Tile.empty(game), Tile.empty(game),
        Tile.empty(game), Tile.empty(game), Tile.empty(game), Tile.empty(game),
      ]);
    }
    gameMatrix.forEach((row) {
      templateList.add(List.from(row));
    });
    gameMatrix = templateList.sublist(
      (templateList.length) - 16,
      (templateList.length)
      );
  }
}
