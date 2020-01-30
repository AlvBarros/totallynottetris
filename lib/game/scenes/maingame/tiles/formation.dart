import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/game/scenes/maingame/tiles/tile.dart';
import 'package:tetris/game/tetris.dart';

class Formation {
  static List<List<List<bool>>> _possibleFormations = [
    [
      [false, true], //    X
      [true, true], //  X X
      [true, false] //  X
    ],
    [
      [true, false], //  X
      [true, true], //  X X
      [false, true] //    X
    ],
    [
      [true, true], // X X
      [true, true] // X X
    ],
    [
      [true], //  X
      [true], //  X
      [true], //  X
      [true] //  X
    ],
    [
      [true, false], //  X
      [true, true], //  X X
      [true, false] //  X
    ]
  ];
  static List<List<List<List<int>>>> _possibleStartingPositions = [
    [
      [
        [4, -2]
      ],
      [
        [3, -1],
        [4, -1]
      ],
      [
        [3, 0]
      ]
    ],
    [
      [
        [3, -2]
      ],
      [
        [3, -1],
        [4, -1]
      ],
      [
        [4, 0]
      ]
    ],
    [
      [
        [3, -1],
        [4, -1]
      ],
      [
        [3, 0],
        [4, 0]
      ]
    ],
    [
      [
        [3, -3]
      ],
      [
        [3, -2]
      ],
      [
        [3, -1]
      ],
      [
        [3, 0]
      ]
    ],
    [
      [
        [4, -2]
      ],
      [
        [3, -1],
        [4, -1]
      ],
      [
        [3, 0]
      ]
    ]
  ];

  TetrisGame game;
  double tileSize;
  Tile tile;
  List<List<bool>> currentFormation;
  List<List<List<int>>> currentPosition;

  static Formation random(TetrisGame game) {
    Color randomColor =
        Tile.colors[Random().nextInt(Tile.colors.length)];
    int formation = Random().nextInt(_possibleFormations.length);
    // int formation = 0;
    
    print('selected formation: $formation');
    print('selected color: ${randomColor.toString()}');

    return new Formation(
        game: game,
        currentFormation: _possibleFormations[formation],
        currentPosition: _possibleStartingPositions[formation],
        color: randomColor);
  }

  Formation({
    this.game,
    this.tileSize,
    Color color,
    this.currentFormation,
    this.currentPosition,
  }) {
    this.tile = Tile.fromColor(game, color);
  }

  List<dynamic> gravity(TetrisGame game, List<List<Tile>> gameMatrix) {
    bool anyTileHasAnyOccupiedTileBelow = false;
    currentPosition.forEach((row) {
      row.forEach((List<int> coords) {
        int x = coords[0];
        int y = coords[1];
        if (x > -2 && y > -2) {
          if (y < gameMatrix.length - 1) {
            if (gameMatrix[y + 1][x].occupied &&
                !gameMatrix[y + 1][x].beingMoved) {
              anyTileHasAnyOccupiedTileBelow = true;
            }
          } else {
            anyTileHasAnyOccupiedTileBelow = true;
          }
        }
      });
    });

    if (!anyTileHasAnyOccupiedTileBelow) {
      currentPosition.forEach((row) {
        row.forEach((List<int> coords) {
          int x = coords[0];
          int y = coords[1];
          coords[1] = y + 1;
          y = y + 1;
          if (x >= 0 && y >= 0) {
            this.tile.beingMoved = true;
            gameMatrix[y][x] = this.tile;
            // if (y > 0) {
            //   gameMatrix[y - 1][x] = Tile.empty(game);
            // }
          }
        });
      });
    }

    for (int y = 0; y < gameMatrix.length; y++) {
      for (int x = 0; x < gameMatrix[y].length; x++) {
        if (gameMatrix[y][x].beingMoved &&
            !currentPosition.any((row) {
              return row.any((List<int> pos) {
                return pos[0] == x && pos[1] == y;
              });
            })) {
          gameMatrix[y][x] = Tile.empty(game);
        }
      }
    }

    return [gameMatrix, anyTileHasAnyOccupiedTileBelow];
  }
}
