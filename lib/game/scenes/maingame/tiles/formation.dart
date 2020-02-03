import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/game/scenes/maingame/tiles/tile.dart';
import 'package:tetris/game/tetris.dart';

class Formation {
  TetrisGame game;
  Tile tile;
  List<List<List<int>>> currentPosition;

  Formation(
    this.game,
  ) {
    Color randomColor = Tile.colors[Random().nextInt(Tile.colors.length)];
    this.tile = Tile.fromColor(game, randomColor);
    tile.beingMoved = true;
    tile.occupied = true;

    List<List<List<List<int>>>> possibleStartingPositions = [
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
          [3, -2]
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
          [3, -1]
        ],
        [
          [3, 0],
          [4, 0]
        ]
      ],
      [
        [
          [4, -2]
        ],
        [
          [4, -1]
        ],
        [
          [4, 0],
          [3, 0]
        ]
      ]
    ];

    int formation = Random().nextInt(possibleStartingPositions.length);

    print('selected formation: $formation');
    print('selected color: ${randomColor.toString()}');

    currentPosition = List.from(possibleStartingPositions[formation]);
  }

  List<dynamic> gravity(List<List<Tile>> gameMatrix) {
    bool anyTileHasAnyOccupiedTileBelow = false;
    currentPosition.forEach((row) {
      row.forEach((List<int> coords) {
        int x = coords[0];
        int y = coords[1];
        if (x > -2 && y > -2) {
          if (y < gameMatrix.length - 1) {
            if (y >= 0) {
              if (gameMatrix[y + 1][x].occupied &&
                  !gameMatrix[y + 1][x].beingMoved) {
                anyTileHasAnyOccupiedTileBelow = true;
              }
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

  List<List<Tile>> move(List<List<Tile>> gameMatrix, {String movement}) {
    if (movement == "left") {
      // if any block can't go left
      bool anyBlockCantGoLeft = false;
      currentPosition.forEach((List<List<int>> row) {
        row.forEach((List<int> coords) {
          if (coords[1] >= 0) {
            // if block is on wall
            if (coords[0] == 0 ||
                // or there is a block on left that is occupied and does not belong to formation
                (gameMatrix[coords[1]][coords[0] - 1].occupied &&
                    !gameMatrix[coords[1]][coords[0] - 1].beingMoved)) {
              anyBlockCantGoLeft = true;
            }
          }
        });
      });

      // if every block can go left
      if (!anyBlockCantGoLeft) {
        currentPosition.forEach((List<List<int>> row) {
          row.forEach((List<int> coords) {
            coords[0] = coords[0] - 1;
          });
        });
        return resetMatrix(gameMatrix);
      }
    }

    if (movement == "right") {
      // if any block can't go right
      bool anyBlockCantGoRight = false;
      currentPosition.forEach((List<List<int>> row) {
        row.forEach((List<int> coords) {
          if (coords[1] >= 0) {
            // if block is on wall
            if (coords[0] == gameMatrix[0].length - 1 ||
                // or there is a block on right that is occupied and does not belong to formation
                (gameMatrix[coords[1]][coords[0] + 1].occupied &&
                    !gameMatrix[coords[1]][coords[0] + 1].beingMoved)) {
              anyBlockCantGoRight = true;
            }
          }
        });
      });

      // if every block can go right
      if (!anyBlockCantGoRight) {
        currentPosition.forEach((List<List<int>> row) {
          row.forEach((List<int> coords) {
            coords[0] = coords[0] + 1;
          });
        });
        return resetMatrix(gameMatrix);
      }
    }
    return gameMatrix;
  }

  List<List<Tile>> resetMatrix(List<List<Tile>> gameMatrix) {
    for (int y = 0; y < gameMatrix.length; y++) {
      for (int x = 0; x < gameMatrix[y].length; x++) {
        if (gameMatrix[y][x].beingMoved) {
          gameMatrix[y][x] = Tile.empty(game);
        }
      }
    }

    currentPosition.forEach((row) {
      row.forEach((List<int> coords) {
        if (coords[0] >= 0 &&
            coords[1] >= 0 &&
            coords[0] < gameMatrix.length &&
            coords[1] < gameMatrix[0].length) {
          gameMatrix[coords[1]][coords[0]] = this.tile;
        }
      });
    });
    return gameMatrix;
  }

  void fallDown(List<List<Tile>> gameMatrix) {
    // gather every column's top tile's x
    List<int> everyColumnsTopTilesX = List<int>();

    // begin with empty list setting every column
    // to bottom
    for (var c = 0; c < gameMatrix[0].length; c++) everyColumnsTopTilesX.add(0);

    // for each row
    for (int y = 0; y < gameMatrix.length; y++) {
      // for each column
      for (int x = 0; x < gameMatrix[x].length; x++) {
        // if current tile is occupied and not from the formation
        Tile currentTile = gameMatrix[y][x];
        if (currentTile.occupied && !currentTile.beingMoved) {
          // if column stored is 0 or y is less than current
          if (everyColumnsTopTilesX[x] == 0 || y < everyColumnsTopTilesX[x]) {
            everyColumnsTopTilesX[x] = y;
          }
        }
      }
    }
/*
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
*/

    // get currentPosition's lowest tile for every column
    List<List<int>> currentLowestTileForEveryColumn =
        currentPosition.map((List<List<int>> row) {
      /*
        [
          [3, -1],
          [4, -1]
        ],
      */
      
    }).toList();

    var test = 0;
  }
}
