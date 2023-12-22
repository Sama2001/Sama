import 'dart:io';

List<String> board = List.generate(9, (index) => (index + 1).toString());
enum players1 {X,O} 
void main() {

  int currentPlayer = 1; 

  while (true) {
    printBoard();

    
    int move = getPlayerMove(currentPlayer);

    
    updateBoard(move, currentPlayer);

    
    if (checkWinner(currentPlayer)) {
      printBoard();
      print("Player $currentPlayer wins!");
      break;
    } else if (board.every((cell) => cell == 'X' || cell == 'O')) {
      printBoard();
      print("It's a draw!");
      break;
    }

    currentPlayer = 3 - currentPlayer;
  }
}


void printBoard() {
  print(" ${board[0]} | ${board[1]} | ${board[2]} ");
  print("---+---+---");
  print(" ${board[3]} | ${board[4]} | ${board[5]} ");
  print("---+---+---");
  print(" ${board[6]} | ${board[7]} | ${board[8]} ");
}

int getPlayerMove(int currentPlayer) {
  int move;
  while (true) {

    stdout.write("Player $currentPlayer, please enter the number of the square where you want to place your ${currentPlayer == 1 ? 'X' : 'O'} : ");
    String input = stdin.readLineSync() ?? "";
    try {
      move = int.parse(input);
      if (move >= 1 && move <= 9 && board[move - 1] == move.toString()) {
        break;
      } else {
        print("Invalid move. Please choose a number between 1 and 9.");
      }
    } catch (e) {
      print("Invalid input. Please enter a number between 1 and 9.");
    }
  }
  return move;
}

void updateBoard(int move, int currentPlayer) {
  board[move - 1] = (currentPlayer == 1) ? 'X' : 'O';
}

bool checkWinner(int currentPlayer) {
  List<List<int>> winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pattern in winPatterns) {
    if (board[pattern[0]] == board[pattern[1]] &&
        board[pattern[1]] == board[pattern[2]] &&
        board[pattern[0]] == (currentPlayer == 1 ? 'X' : 'O')) {
      return true;
    }
  }

  return false;
}
