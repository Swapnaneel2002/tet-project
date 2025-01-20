import 'dart:js_interop';
import 'dart:ui';
import 'board.dart';
import 'values.dart';
import 'package:flutter/material.dart';


class Piece {
  // the type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  // initial rotation state
  int rotationState = 1;

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ??
        const Color(0xFFFFFFFF); // Default to white if no color is found
  }

  // generate the ints
  void initalizePiece() {
  const Map<Tetromino, List<int>> initialPositions = {
    Tetromino.L: [-26, -16, -6, -5],
    Tetromino.J: [-25, -15, -5, -6],
    Tetromino.I: [-4, -5, -6, -7],
    Tetromino.O: [-15, -16, -5, -6],
    Tetromino.S: [-15, -14, -6, -5],
    Tetromino.Z: [-17, -16, -6, -5],
    Tetromino.T: [-26, -16, -6, -15],
  };

  position = initialPositions[type] ?? [];
}


  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += row_length;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;

      default:
    }
  }

  // check for collision
  bool positionIsValid(int position) {
  if (position < 0) return false; // Prevent invalid positions
  
  int row = (position / rowLength).floor();
  int col = position % rowLength;

  // Validate position within bounds and ensure it’s not occupied
  return !(row < 0 || col < 0 || gameBoard[row][col] != null);
}

  // new piece position is valid
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the col of position
      int col = pos % row_length;

      // check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == row_length - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first col and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }

  // rotate piece
  void rotatePiece() {
    // new position
    List<int> newPosition = [];

    // Rotate the piece based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*

            o
            o
            o o

            */

            // assign new position
            newPosition = [
              position[1] - row_length,
              position[1],
              position[1] + row_length,
              position[1] + row_length + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
              
            o o o
            o

            */

            // assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + row_length - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o o
              o
              o

            */

            // assign new position
            newPosition = [
              position[1] + row_length,
              position[1],
              position[1] - row_length,
              position[1] - row_length - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

                o
            o o o

            */

            // assign new position
            newPosition = [
              position[1] - row_length + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = 0; // Reset rotation state to 0
            }

            break;
        }
        break;

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*

              o
              o
            o o

            */
            newPosition = [
              position[1] - row_length,
              position[1],
              position[1] + row_length,
              position[1] + row_length - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

            o 
            o o o
              
            */
            newPosition = [
              position[1] - row_length - 1,
              position[1],
              position[1] - 1,
              position[1] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o o 
            o
            o
              
            */
            newPosition = [
              position[1] + row_length,
              position[1],
              position[1] - row_length,
              position[1] - row_length + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
          
            o o o
                o
              
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + row_length + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = 0; // Reset rotation state to 0
            }

            break;
        }
        break;

      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*

            o o o o
          
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

            o
            o
            o
            o
          
            */
            newPosition = [
              position[1] - row_length,
              position[1],
              position[1] + row_length,
              position[1] + 2 * row_length
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o o o o
          
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

            o
            o
            o
            o
          
            */
            newPosition = [
              position[1] + row_length,
              position[1],
              position[1] - row_length,
              position[1] - 2 * row_length
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = 0; // Reset rotation state to -1
            }
            break;
        }
        break;

      case Tetromino.O:
        /*
        The O tetromino does not need to be rotated

        o o
        o o

        */
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*

            o o
          o o

            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + row_length - 1,
              position[1] + row_length
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:

            /*

            o
            o o
              o

            */
            newPosition = [
              position[0] - row_length,
              position[0],
              position[0] + 1,
              position[0] + row_length + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o o
          o o

            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + row_length - 1,
              position[1] + row_length
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

          o
          o o
            o

            */
            newPosition = [
              position[0] - row_length,
              position[0],
              position[0] + 1,
              position[0] + row_length + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = 0; // Reset rotation state to 0
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*

            o o
              o o

             */
            newPosition = [
              position[0] + row_length - 2,
              position[1],
              position[2] + row_length - 1,
              position[3] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
            
              o
            o o
            o

            */
            newPosition = [
              position[0] - row_length + 2,
              position[1],
              position[2] - row_length + 1,
              position[3] - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o o
              o o
              
            */
            newPosition = [
              position[0] + row_length - 2,
              position[1],
              position[2] + row_length - 1,
              position[3] + 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              o
            o o
            o

            */
            newPosition = [
              position[0] - row_length + 2,
              position[1],
              position[2] - row_length + 1,
              position[3] - 1
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              // Update the rotation state
              rotationState = 0; // Reset rotation state to 0
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*

            o
            o o
            o

            */
            newPosition = [
              position[2] - row_length,
              position[2],
              position[2] + 1,
              position[2] + row_length
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

            o o o
              o

            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + row_length
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

              o
            o o
              o

            */
            newPosition = [
              position[1] - row_length,
              position[1] - 1,
              position[1],
              position[1] + row_length
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              o
            o o o

            */
            newPosition = [
              position[2] - row_length,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0; // Reset rotation state to 0
            }
            break;
        }
        break;
    }
  }
}
