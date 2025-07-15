import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  String gameName;
  int nbQuestion;
  int difficulty;
  String style;
  int turn;

  GameSettings({
    required this.gameName,
    required this.nbQuestion,
    required this.difficulty,
    required this.style,
    required this.turn
  });
}

class GameSettingsNotifier extends ChangeNotifier {
  final gameSettings = GameSettings(gameName: "", nbQuestion: 50, difficulty: 3, style: "random", turn: 1);

  void setGameName(String newGameName){
    gameSettings.gameName = newGameName;
    notifyListeners();
  }

  void setNbQuestion(int newNbQuestion) {
    gameSettings.nbQuestion = newNbQuestion;
    notifyListeners();
  }

  void setDifficulty(int newDifficulty) {
    gameSettings.difficulty = newDifficulty;
    notifyListeners();
  }

  void setStyle(String newStyle) {
    gameSettings.style = newStyle;
    notifyListeners();
  }

  void passTurn(){
    gameSettings.turn++;
    notifyListeners();
  }
}

final gameSettingsProvider = ChangeNotifierProvider<GameSettingsNotifier>((ref) {
  return GameSettingsNotifier();
});