## 1. Git Usage and Basic Commands
- Describe the Git commands you used (e.g., `git init`, `git commit`, `git push`).
- Include examples of time traveling in Git, branching, and merging.
- Add screenshots or links to commits demonstrating your usage.

## 2. UML Diagrams
- Include at least three UML diagrams:

  
  - Use-Case Diagram
    
 ![WhatsApp Image 2025-01-20 at 02 21 29_215dec6e](https://github.com/user-attachments/assets/271fa251-8ad1-4529-a9af-5cd7fafd08a3)


  - Activity Diagram


![Tetris_Activity_Diagram](https://github.com/user-attachments/assets/dada937d-ed00-4970-b08c-04c850f0a261)


  
  - Class Diagram

 ![image](https://github.com/user-attachments/assets/453e0013-f2b5-4336-8319-49223e8c9472)

## 3. Requirements
#### Trello

- **At start**

![Tetris App Requirements](https://imgur.com/1M1c9Ue.png)

**Current Requirements**

- [Tetris App Requirements - Trello Board](https://trello.com/invite/b/678d735b215ae17f2c661f2e/ATTI74abd12c3eb816e9e624f922d3972ea73D3761D8/tetris)


#### Jira

- **At start**

![Image](https://github.com/user-attachments/assets/e0a7facd-831a-47a6-a515-56c5fb0832ed)

**Requirments Currently**

- [Tetris App Requirements - Jira Board](https://swapnaneelsarkhel.atlassian.net/jira/software/projects/SMS/boards/1?atlOrigin=eyJpIjoiNmUzZWRiNTk3MGJlNDNlNGI2ODJlM2NjNmJiZmU2NzEiLCJwIjoiaiJ9)

## 4. Analysis
#### **Checklist for Analysis:**

    Problem Definition
    Target Audience
    Unique Selling Proposition (USP)
    Competitor Analysis
    Core Features
    Technical Feasibility
    User Experience (UX) Design
    Scalability
    Development Timeline
    Risks and Challenges
    Innovation Potential
    Future Expansion

#### Document Analysis

You can find the detailed project analysis checklist in the following PDF document:

## [Project Analysis](Project_Analysis.pdf)

## 5. Domain-Driven Design (DDD)
Here’s how I broke the project into domains:

1.  **Core Domain:**
   
   Game Mechanics

 ![Game Mechanics](https://github.com/user-attachments/assets/c05943a9-645b-4a9d-92af-f07bf12f9ae2)



2.  **Supporting Domain:**

   Input Handling
   
   ![Input](https://github.com/user-attachments/assets/b4612b08-8a03-47a5-bc01-5d0564996ce2)

  UI/Rendering
  
  ![UI](https://github.com/user-attachments/assets/968f77b1-a3a9-4eec-af84-aabcd52420e1)

3.  **Generic Domain:**
  
   Shared Components

![Generic](https://github.com/user-attachments/assets/a329382b-c6f8-49f6-9293-686bd8fa3c05)



4.  **Monitoring Domain:**
  
   Analytics

   ![Monitoring](https://github.com/user-attachments/assets/96804464-375c-4476-a2b4-9934d1892091)


5.  **Unified Visual Representation Domain:**
  
   bird’s-eye view

   ![Screenshot (16)](https://github.com/user-attachments/assets/2b96994a-47a2-47bd-bb5f-637247e635a4)

---
## 6. Metrics
- Run at least two metrics (e.g., SonarQube or others).
- Attach screenshots of the results and explain what they mean for your project.

## 7. Clean Code Development (CCD)
This is how I kept the code clean :-

### Clean Code Cheat Sheet for Tetris Project

1. **Single Responsibility Principle:**
   - Each class focuses on a single task:
     - [`Piece`](./lib/piece.dart): Manages Tetromino-related logic like rotation, validation, and movement.
     - [`GameBoard`](./lib/board.dart): Handles grid operations, game logic (e.g., clearing lines, checking collisions), and board rendering.
   - This keeps the code organized and easy to debug.

2. **Readable Names:**
   - Variables, methods, and constants are intuitively named:
     - Methods like `checkCollision` and `clearLines` in [`board.dart`](./lib/board.dart) clearly describe their function.
     - Constants like `rowLength` and `colLength` in [`values.dart`](./lib/values.dart) define grid dimensions.
   - Clear names improve understanding without needing additional comments.

3. **Encapsulation:**
   - Private fields ensure controlled access:
     - Methods like `positionIsValid` and `piecePositionIsValid` in [`piece.dart`](./lib/piece.dart) handle Tetromino state internally.
   - Encapsulation prevents unintended modifications and ensures data integrity.

4. **DRY Principle:**
   - Reusable logic is centralized to eliminate duplication:
     - Movement methods like `movePiece` in [`piece.dart`](./lib/piece.dart) streamline Tetromino positioning.
     - Grid operations in [`board.dart`](./lib/board.dart), like line clearing, follow a systematic approach to avoid redundant code.
   - This promotes consistency and reduces maintenance effort.

5. **Modular Structure:**
   - The project is divided into well-defined modules:
     - [`GameBoard`](./lib/board.dart): Manages the game loop and board interactions.
     - [`Piece`](./lib/piece.dart): Handles individual Tetromino behavior.
     - [`Tile`](./lib/tile.dart): Focuses on rendering visual components.
   - Modular design simplifies scalability and makes the codebase easier to extend.


## 8. Refactoring
#### **Example 1: Refactoring positionIsValid for Improved Clarity and Efficiency**

**Original Code:**



```dart
bool positionIsValid(int position) {
  try {
    // Get the row and column of the position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // Check if the position is valid
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  } catch (e, stackTrace) {
    debugPrint('Error in positionIsValid: $e');
    debugPrint('Stack Trace: $stackTrace');
    return false;
  }
}
```

**Refactored Code:**

```dart
bool positionIsValid(int position) {
  if (position < 0) return false; // Prevent invalid positions
  
  int row = (position / rowLength).floor();
  int col = position % rowLength;

  // Validate position within bounds and ensure it’s not occupied
  return !(row < 0 || col < 0 || gameBoard[row][col] != null);
}

```

**Why This is Better**

1. Simpler Logic: Removed unnecessary `try-catch` block since most errors are prevented by early checks.
2. Performance: Adds a quick validation check `(position < 0)` to prevent unnecessary calculations.
3. Readability: Consolidates checks into a single return statement for clarity


#### **Example 2: Refactoring initalizePiece for Scalability**

**Original Code:**


```dart
void initalizePiece() {
  switch (type) {
    case Tetromino.L:
      position = [-26, -16, -6, -5];
      break;
    case Tetromino.J:
      position = [-25, -15, -5, -6];
      break;
    case Tetromino.I:
      position = [-4, -5, -6, -7];
      break;
    case Tetromino.O:
      position = [-15, -16, -5, -6];
      break;
    case Tetromino.S:
      position = [-15, -14, -6, -5];
      break;
    case Tetromino.Z:
      position = [-17, -16, -6, -5];
      break;
    case Tetromino.T:
      position = [-26, -16, -6, -15];
      break;
    default:
  }
}



```

**Refactored Code:**


```dart
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

```

**Why This is Better**

1. Scalability: Adding new Tetromino types only requires updating the `initialPositions` map, instead of modifying the switch statement.
2. Readability: Consolidates all Tetromino positions into a single data structure, making it easier to understand and maintain.
3. Efficiency: Eliminates redundant `case` checks by directly accessing the map.


#### **Benefits of These Refactorings**

1. Simplified Logic: Both examples reduce unnecessary complexity in the original code.
2. Improved Maintainability: Changes make the code more flexible and easier to extend with new features.
3. Better Performance: Optimizations in checks and data handling improve the efficiency of critical game logic.


## 9. Build Management
- Document your use of a build tool (e.g., Maven, Gradle).
- Include examples like generating docs or running tests.

The project uses Gradle for building and managing dependencies. Main Gradle files:

- [build.gradle](https://github.com/Swapnaneel2002/Tetris/blob/main/android/build.gradle): Sets up shared settings and dependencies for the project.
- [gradle.properties](https://github.com/Swapnaneel2002/Tetris/blob/main/android/gradle.properties): Stores global settings like JVM options and AndroidX preferences.
- [settings.gradle](): Lists the modules included in the project.
- [app/build.gradle](https://github.com/Swapnaneel2002/Tetris/blob/main/android/app/build.gradle): Configures app-specific dependencies and build options.

## 10. Continuous Delivery
- Describe your pipeline setup using tools like Jenkins or GitHub Actions.
- Include at least two script calls (e.g., Gradle tasks).

## 11. Unit Tests
- Share examples of unit tests integrated into your build.

- [widget_test.dart](https://github.com/Swapnaneel2002/Tetris/blob/main/test/widget_test.dart): Tests widget functionality
- [tile_test.dart](https://github.com/Swapnaneel2002/Tetris/blob/main/test/title_test.dart): Contains unit tests for the Tile widget to verify color, margin, and border radius.

## 12. IDE Usage
- Mention your preferred IDE (e.g., VSCode, IntelliJ).
- Highlight your favorite key shortcuts and productivity tips.

### Key Features Used

#### Extensions
- Flutter
- Dart

#### Integrated Terminal
- Running `flutter run` and Git commands seamlessly.

####Debugging
- Setting breakpoints, inspecting variables, and leveraging hot-reload for faster iteration.

### Favorite Shortcuts
- **Ctrl + Shift + F:** Search across all files
- **Ctrl + /**: Comment/uncomment code
- **F5:** Debugging
- **Ctrl + Z:** Undo the last action
- **Ctrl + C / Ctrl + V:** Copy and paste, essential for efficient coding
- **Ctrl + Y:** Redo the last undone action


## 13. AI Coding Tools
- Document your experience setting up and using AI coding tools (e.g., ZED, Cursor).
- Share personal feedback and screenshots.

#### Tools Used
I chose for GitHub Copilot as my AI coding assistant because of its easy integration with VS Code. It significantly boosted my productivity by providing real-time suggestions, refactorings, and coding patterns.
#### Personal Experience
Setting up GitHub Copilot was straightforward. It easily integrated into my workflow and quickly began assisting with my project.
#### Example on question 15
## 14. Functional Programming
1. **Final Data Structures:**
   - Immutable configurations like Tetromino colors are declared using constants in [`values.dart`](./lib/values.dart).

```dart
const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color(0xFF0000FF),
  Tetromino.I: Color(0xFF00FFFF),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color(0xFF00FF00),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color(0xFF800080),
};
```

2. **Side-Effect-Free Functions:**
   - Pure functions like `isPositionValid` in [`piece.dart`](./lib/piece.dart) ensure that no external states are modified.

```dart
bool isPositionValid(List<int> positions, List<List<Tile?>> board) {
  return positions.every((pos) {
    int row = (pos / rowLength).floor();
    int col = pos % rowLength;

    return row >= 0 &&
           col >= 0 &&
           row < board.length &&
           col < board[0].length &&
           board[row][col] == null;
  });
}
```

3. **Higher-Order Functions:**
   - Processing Tetromino positions with higher-order methods like `forEach`.

```dart
void applyToPositions(List<int> positions, Function(int) callback) {
  positions.forEach(callback);
}

applyToPositions(currentPiece.positions, (pos) {
  int row = (pos / rowLength).floor();
  int col = pos % rowLength;
  print('Row: $row, Col: $col');
});
```

4. **Closures and Anonymous Functions:**
   - Use closures to filter rows in [`board.dart`](./lib/board.dart).

```dart
void clearLines() {
  gameBoard = gameBoard.where((row) {
    return row.any((tile) => tile == null);
  }).toList();
}
```

5. **Functions as Parameters and Return Values:**
   - Movement logic is refactored to return dynamic functions in [`piece.dart`](./lib/piece.dart).

```dart
Function getMovement(Direction direction) {
  switch (direction) {
    case Direction.left:
      return (int pos) => pos - 1;
    case Direction.right:
      return (int pos) => pos + 1;
    case Direction.down:
      return (int pos) => pos + rowLength;
    default:
      return (int pos) => pos;
  }
}

List<int> updatedPositions = currentPiece.positions.map(getMovement(Direction.down)).toList();
```
## 15. AI Coding environment
Set up a running AI Coding environment! Prove it by “coding” something iteratively

![Image](https://github.com/user-attachments/assets/dbd5c639-2fe1-4c1e-ac55-af3237ec5c3f)
![Image](https://github.com/user-attachments/assets/7c7434f9-98f1-4744-b15b-7e1fa55b1160)
