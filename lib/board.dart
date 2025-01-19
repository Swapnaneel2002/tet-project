import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'piece.dart';
import 'tile.dart';
import 'values.dart';



/*

GAME BOARD

This is a 2x2 grid with null representing an empty space.
We will store the tetromino type to represent the correct color for landed pieces

*/

int row_length = 10;
int colLength = 15;

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    row_length,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.T);

  // current score
  int currentScore = 0;

  // game over
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // initalize game
    startGame();
  }

  void startGame() {
    currentPiece.initalizePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);

    gameLoop(frameRate);
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          // clear lines
          clearLines();

          // check for landing
          checkLanding();

          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          // move current piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your score is: $currentScore'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Reset the game
                resetGame();

                Navigator.of(context).pop();
              },
              child: const Text('PLAY AGAIN'),
            ),
          ],
        );
      },
    );
  }

  // check for collision in future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision({Direction? direction}) {
    // Loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // Calculate the row and column of the current position
      int row = (currentPiece.position[i] / row_length).floor();
      int col = currentPiece.position[i] % row_length;

      // Adjust the row and column based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // Check if the piece is out of bounds (either too low or too far to the left or right)
      if (row >= colLength || col < 0 || col >= row_length) {
        return true;
      }

      // Check if the current position is already occupied by another piece in the game board
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    // If no collisions are detected, return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(direction: Direction.down)) {
      // mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / row_length).floor();
        int col = currentPiece.position[i] % row_length;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // create new piece
      createNewPiece();
    }
  }

  // create new piece
  void createNewPiece() {
    // create a Random object to generate random tetromino types
    Random rand = Random();

    // create new piece with random tetromino type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initalizePiece();

    // Since our game over condition is if there is a piece at the top level,
    // you want to check if the game is over when you create a new piece,
    // instead of every frame, because new pieces are allowed to go through the top level
    // but if there is already a piece in the top level when the new piece is created,
    // then game over
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // clear lines
  void clearLines() {
    // Step 1: Loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // Step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // Step 3: Check if the row is full (all columns in the row are filled with pieces)
      for (int col = 0; col < row_length; col++) {
        // If there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // Step 4: If the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // Step 5: Move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // Copy the row above to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // Step 6: Set the top row to empty
        gameBoard[0] = List.generate(row_length, (col) => null);

        // Step 7: Increase the score!
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    // Check if any columns in the top row are filled
    for (int col = 0; col < row_length; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // If the top row is empty, the game is not over
    return false;
  }

  // move left
  void moveLeft() {
    // make sure the piece can move there before moving there
    if (!checkCollision(direction: Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }

    // check for landing
    checkLanding();
  }

  // move right
  void moveRight() {
    // make sure the piece can move there before moving there
    if (!checkCollision(direction: Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }

    // check for landing
    checkLanding();
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });

    // check for landing
    checkLanding();
  }

  void resetGame() {
    // Clear the game board
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        row_length,
        (j) => null,
      ),
    );

    // new game
    gameOver = false;
    currentScore = 0;

    // Create a new piece
    createNewPiece();

    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // grid
            Expanded(
              child: GridView.builder(
                itemCount: row_length * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: row_length,
                ),
                itemBuilder: (context, index) {
                  int row = (index / row_length).floor();
                  int col = index % row_length;

                  // tetromino tile
                  if (currentPiece.position.contains(index)) {
                    return Tile(
                      color: currentPiece.color,
                    );
                  }

                  // game board tile
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Tile(
                      color: tetrominoColors[tetrominoType],
                    );
                  }

                  // blank tile
                  else {
                    return Tile(
                      color: Colors.grey[900],
                    );
                  }
                },
              ),
            ),

            // score
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "SCORE: $currentScore",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            // buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // left
                  IconButton(
                    onPressed: moveLeft,
                    color: Colors.grey,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  // rotate
                  IconButton(
                    onPressed: rotatePiece,
                    color: Colors.grey,
                    icon: const Icon(Icons.rotate_right),
                  ),

                  // right
                  IconButton(
                    onPressed: moveRight,
                    color: Colors.grey,
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
