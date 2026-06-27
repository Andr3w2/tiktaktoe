import 'dart:io';

import 'board.dart';
import 'player.dart';

/// Controls the game flow.
class Game {
  final Board _board = Board();

  final Player _playerOne = Player(
    name: 'Player 1',
    symbol: 'X',
  );

  final Player _playerTwo = Player(
    name: 'Player 2',
    symbol: 'O',
  );

  late Player _currentPlayer;

  Game() {
    _currentPlayer = _playerOne;
  }

  /// Starts the game.
  void start() {
    bool playAgain = true;

    while (playAgain) {
      _board.resetBoard();
      _currentPlayer = _playerOne;

      print('');
      print('===================================');
      print('         TIC - TAC - TOE');
      print('===================================');
      print('');
      print('${_playerOne.name} -> X');
      print('${_playerTwo.name} -> O');
      print('');

      bool gameOver = false;

      while (!gameOver) {
        _board.displayBoard();

        int position = _readMove();

        _board.placeMove(position, _currentPlayer.symbol);

        if (_board.checkWinner(_currentPlayer.symbol)) {
          _board.displayBoard();

          print('===================================');
          print('Congratulations!');
          print('${_currentPlayer.name} wins!');
          print('===================================');

          gameOver = true;
        } else if (_board.isBoardFull()) {
          _board.displayBoard();

          print('===================================');
          print("It's a draw!");
          print('===================================');

          gameOver = true;
        } else {
          _changeTurn();
        }
      }

      playAgain = _askPlayAgain();
    }

    print('');
    print('Thanks for playing!');
  }

  /// Reads and validates the player's move.
  int _readMove() {
    while (true) {
      stdout.write(
          '${_currentPlayer.name} (${_currentPlayer.symbol}) - Enter a position (1-9): ');

      String? input = stdin.readLineSync();

      if (input == null || input.trim().isEmpty) {
        print('\nInvalid input.\n');
        continue;
      }

      int? position = int.tryParse(input);

      if (position == null) {
        print('\nPlease enter numbers only.\n');
        continue;
      }

      if (!_board.isValidPosition(position)) {
        print('\nPosition must be between 1 and 9.\n');
        continue;
      }

      if (!_board.isCellEmpty(position)) {
        print('\nThat position is already occupied.\n');
        continue;
      }

      return position;
    }
  }

  /// Changes the current player.
  void _changeTurn() {
    if (_currentPlayer == _playerOne) {
      _currentPlayer = _playerTwo;
    } else {
      _currentPlayer = _playerOne;
    }
  }

  /// Asks if the players want another game.
  bool _askPlayAgain() {
    while (true) {
      print('');
      print('Play again?');
      print('1 - Yes');
      print('2 - No');

      stdout.write('Option: ');

      String? option = stdin.readLineSync();

      if (option == '1') {
        return true;
      }

      if (option == '2') {
        return false;
      }

      print('\nInvalid option.\n');
    }
  }
}