
## A) Pet Project: Rediscovering Coding Through Tetris
Project Description:

After a long break from hands-on coding, I wanted to jump back in with something fun, simple, and a little nostalgic. I decided to create a Tetris game, a project that feels approachable yet offers enough complexity to keep things interesting.

The main goal was to not only build something functional but to use it as a playground to practice key software engineering skills, like Git version control and modular coding. Tetris was a perfect choice because of its well-defined mechanics and opportunities for gradual improvement. This wasn’t just about making a game—it was about reigniting my passion for programming while applying what I’ve learned in a meaningful way.

## 1. Using Git: A Journey of Version Control
Throughout this project, I used Git as my primary tool for version control, which helped me keep track of my progress, experiment with ideas safely, and avoid major disasters (like losing hours of work).

## 2. UML Diagrams
- Include at least three UML diagrams:

  
  - Use-Case Diagram
    
 ![WhatsApp Image 2025-01-20 at 02 21 29_3eb43c09](https://github.com/user-attachments/assets/2808322f-253c-4a12-9853-8d2315074b38)



  - Activity Diagram


![Tetris_Activity_Diagram]![Tetris_Activity_Diagram](https://github.com/user-attachments/assets/bd51033c-c808-497f-8fd8-ebefea6bab40)



  
  - Class Diagram

 ![image](https://github.com/user-attachments/assets/453e0013-f2b5-4336-8319-49223e8c9472)

## 3. Requirements
#### Trello

- **At start**

Tetris App Requirements
![nAWZn6h - Imgur](https://github.com/user-attachments/assets/a40b3f66-a5d5-40a9-807f-489aea7a2303)

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


[Project_Analysis.pdf](https://github.com/user-attachments/files/18479314/Project_Analysis.pdf)


## 5. Domain-Driven Design (DDD)


 
1.  **Possible Domains for the game:**
   

![Screenshot 2025-01-21 004442](https://github.com/user-attachments/assets/8843511b-5aa2-4c06-9511-69b315cc4be8)




2.  **Core Domains:**

  ![Screenshot 2025-01-21 004342](https://github.com/user-attachments/assets/2a20577b-88bc-4b27-a5ea-77d644358ced)


3.  **Core Mapping:**
  
 
![Screenshot 2025-01-21 004553](https://github.com/user-attachments/assets/45592bbc-054c-438c-a0d5-a906cfaaf2fe)




4. **Model Complexity vs Business Differentiation

![Screenshot 2025-01-21 004458](https://github.com/user-attachments/assets/e3f0582b-19cd-40a5-9524-1ee09872fcd0)


---
## 6. Metrics
I used Dart's linter to make sure my code adheres to best practices and maintains high quality. After running the linter, the results showed that my codebase is clean, with only a few minor warnings and no major errors. This highlights that the project is well-structured and follows standard coding conventions.

Linter Screenshots:

![first one](https://github.com/user-attachments/assets/99ceb657-d59a-4b62-a69d-e51ad6ec2f1c)
![second one](https://github.com/user-attachments/assets/cbf3b399-eb5c-4654-bf50-21ceba992463)


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
  
     [Clean.Code.Cheat.Sheet.for.Tetris.Project.pdf](https://github.com/user-attachments/files/18479305/Clean.Code.Cheat.Sheet.for.Tetris.Project.pdf)



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
Set up GitHub Actions to automate the workflow:

1. Installation of all the dependencies

2. Executing Successful Runs

3. Build the APK (
"Not a bug, it's a feature that won't leave!" 😄)

You can view the GitHub Actions workflow configuration [here](https://github.com/Swapnaneel2002/tet-project/blob/main/.github/workflows/flutter-ci.yml)

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

## Conclusion

Working on this Tetris project has been an incredibly rewarding journey. It wasn’t just about building a game I’ve always wanted to create; it was about challenging myself, learning new skills, and applying the concepts I’ve studied in a real-world scenario. From designing game mechanics to setting up workflows, I got to experience what it’s like to take an idea and turn it into something tangible.

One of the most valuable parts of this project was learning how to use Git and GitHub effectively. Creating branches, merging changes, and troubleshooting CI/CD workflows taught me so much about collaboration and organization. Of course, it wasn’t always smooth sailing—I ran into plenty of issues along the way. But every mistake, from merge conflicts to failed workflows, helped me grow and gave me skills I didn’t even realize I needed. Now, looking back, I’m proud of how much I was able to accomplish.

Another highlight for me was revisiting the fundamentals of clean code and functional programming. Concepts like immutability, higher-order functions, and encapsulation made the code more organized and easier to work with. Seeing these principles in action was a great reminder of how important it is to build a solid foundation in programming.

## Final Remarks

This project has been so much more than just a class assignment it’s been a journey of discovery and growth. One of my favorite moments was when I accidentally broke my workflow because of a missing dependency. It felt like the end of the world at the time, but figuring out what went wrong and fixing it taught me so much about debugging and patience. YAML files aren’t as scary anymore (well, almost).

Another memorable moment was when I messed up some code while working with Git branches. Recovering my changes felt like a small victory and gave me confidence in using tools like Git to navigate challenges.

This project has shown me how far I’ve come and given me a glimpse of where I can go. I’ve learned what it takes to organize a project, plan workflows, and create something I’m proud of. It’s been a fantastic learning experience, and I can’t wait to take these skills into future projects—and maybe even my career someday. This Tetris game may just be a simple project, but to me, it’s a milestone in my coding journey.
