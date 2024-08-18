import 'package:flutter/material.dart';

import 'hangman.dart';

class PlaygorundController extends ChangeNotifier {
  var player = HangmanPlayer();

  void guessLetter(String letter) {
    player.guessLetter(letter);

    notifyListeners();
  }

  void refresh() {
    player = HangmanPlayer();

    notifyListeners();
  }
}
