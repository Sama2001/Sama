import 'dart:io';

List<String> board = List.generate(9, (index) => (index + 1).toString()); ///1-9
enum players1 {X,O} 
void main() {

  int player = 1;  ///initial index for current player

  while (true) {
    printing(); ///print the board

    
    int move = getMove(player);

    
    update(move, player); ///update the board

    
    if (WinnerChecker(player)) {
      printing();
      print("Player ${player == 1 ? 'X' : 'O'} wins ^_^");
      break;
    } else if (board.every((cell) => cell == 'X' || cell == 'O')) 
    {
      printing(); ///print the board
      break;
    }

    player = 3 - player;
  }
}

//////////////board printing///////////////////////
void printing() {
  print(" ${board[0]} | ${board[1]} | ${board[2]} ");
  print("---+---+---");
  print(" ${board[3]} | ${board[4]} | ${board[5]} ");
  print("---+---+---");
  print(" ${board[6]} | ${board[7]} | ${board[8]} ");
}

/////////////////////get moves for current player///////////
int getMove(int player) {
  int move;
  while (true) {

    stdout.write("Player $player, please enter the number of the square where you want to place your ${player == 1 ? 'X' : 'O'} : ");
    String input = stdin.readLineSync() ?? "";
    try {
      move = int.parse(input);
      if (move >= 1 && move <= 9 && board[move - 1] == move.toString()) {  /// enterd values (inputs) 1-9 
        break;
      } else {
        print("wrong input, choose a number between 1 and 9.");
      }
    } 
    catch (e) {
      print("wrong input, choose a number between 1 and 9.");
    }
  }
  return move;
}

void update(int move, int player) {
  board[move - 1] = (player == 1) ? 'X' : 'O';
}
/////////////////winner check////////
bool WinnerChecker(int player) {
  List<List<int>> win = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pattern in win) {
    if (board[pattern[0]] == board[pattern[1]] &&
        board[pattern[1]] == board[pattern[2]] &&
        board[pattern[0]] == (player == 1 ? 'X' : 'O')) {
      return true;
    }
  }

  return false;
}
