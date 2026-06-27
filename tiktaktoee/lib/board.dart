/// Manages the Tic-Tac-Toe board.
  class Board {
  // Stores the board cells.
  final List<String> _cells = List.generate(9, (index) => '${index + 1}');

  // All possible winning combinations.
  final List<List<int>> _winningCombinations = [
    [0, 1, 2], // Top row
    [3, 4, 5], // Middle row
    [6, 7, 8], // Bottom row
    [0, 3, 6], // Left column
    [1, 4, 7], // Middle column
    [2, 5, 8], // Right column
    [0, 4, 8], // Main diagonal
    [2, 4, 6], // Secondary diagonal
  ];

  /// Displays the board.
  void displayBoard() {
    print('');
    print('     TIC - TAC - TOE');
    print('');
    print(' ${_cells[0]} | ${_cells[1]} | ${_cells[2]} ');
    print('---+---+---');
    print(' ${_cells[3]} | ${_cells[4]} | ${_cells[5]} ');
    print('---+---+---');
    print(' ${_cells[6]} | ${_cells[7]} | ${_cells[8]} ');
    print('');
  }

  /// Checks if the position is between 1 and 9.
  bool isValidPosition(int position) {
    return position >= 1 && position <= 9;
  }

  /// Checks if the selected cell is empty.
  bool isCellEmpty(int position) {
    int index = position - 1;
    return _cells[index] != 'X' && _cells[index] != 'O';
  }

  /// Places the player's symbol on the board.
  bool placeMove(int position, String symbol) {
    if (!isValidPosition(position)) {
      return false;
    }

    if (!isCellEmpty(position)) {
      return false;
    }

    _cells[position - 1] = symbol;
    return true;
  }

  /// Checks whether the current player has won.
  bool checkWinner(String symbol) {
    for (var combination in _winningCombinations) {
      if (_cells[combination[0]] == symbol &&
          _cells[combination[1]] == symbol &&
          _cells[combination[2]] == symbol) {
        return true;
      }
    }

    return false;
  }

  /// Checks whether the board is full.
  bool isBoardFull() {
    for (String cell in _cells) {
      if (cell != 'X' && cell != 'O') {
        return false;
      }
    }

    return true;
  }

  /// Resets the board for a new game.
  void resetBoard() {
    for (int i = 0; i < 9; i++) {
      _cells[i] = '${i + 1}';
    }
  }
}