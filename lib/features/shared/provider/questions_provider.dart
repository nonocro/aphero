import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aphero/features/shared/provider/game_settings_provider.dart';

@immutable
class Question {
  final String type;
  final String question;
  final String style;
  final int difficulty;
  final int punishment;

  const Question({
    required this.type,
    required this.question,
    required this.style,
    required this.difficulty,
    required this.punishment,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      question: json['question'],
      style: json['style'],
      difficulty: json['difficulty'],
      punishment: json['punishment'],
    );
  }
}

@immutable
class QuestionsState {
  final List<Question> availableQuestions;
  final Question? currentQuestion;

  const QuestionsState({
    required this.availableQuestions,
    this.currentQuestion,
  });

  QuestionsState copyWith({
    List<Question>? availableQuestions,
    Question? currentQuestion,
  }) {
    return QuestionsState(
      availableQuestions: availableQuestions ?? this.availableQuestions,
      currentQuestion: currentQuestion ?? this.currentQuestion,
    );
  }
}

class QuestionsAsyncNotifier extends AsyncNotifier<QuestionsState> {
  @override
  Future<QuestionsState> build() async {
    final gameSettings = ref.watch(gameSettingsProvider).gameSettings;
    String data = "";

    switch (gameSettings.gameName) {
      case "bravery_or_confession":
        data = await rootBundle.loadString('assets/bravery_or_confession_questions.json');
        break;
      case "babylon_tower":
        data = await rootBundle.loadString('assets/babylon_tower_questions.json');
        break;
      default:
        throw Exception("Unknown game name: ${gameSettings.gameName}");
    }

    final List<dynamic> jsonResult = json.decode(data);
    debugPrint("Loaded ${jsonResult.length} questions for game: ${gameSettings.gameName}");
    
    final List<Question> loadedQuestions = jsonResult
        .map((e) => Question.fromJson(e))
        .toList();

    Question? initialQuestion;
    if (loadedQuestions.isNotEmpty) {
      final randomIndex = Random().nextInt(loadedQuestions.length);
      initialQuestion = loadedQuestions.removeAt(randomIndex);
    }

    return QuestionsState(
      availableQuestions: loadedQuestions,
      currentQuestion: initialQuestion,
    );
  }

  void getFollowingQuestion() {
    if (state.hasValue) {
      final currentAvailableQuestions = List<Question>.from(state.value!.availableQuestions);

      if (currentAvailableQuestions.isNotEmpty) {
        final newIndex = Random().nextInt(currentAvailableQuestions.length);
        final newQuestion = currentAvailableQuestions.removeAt(newIndex);

        state = AsyncData(state.value!.copyWith(
          availableQuestions: currentAvailableQuestions,
          currentQuestion: newQuestion,
        ));
      } else {
        state = AsyncData(state.value!.copyWith(
          currentQuestion: null,
        ));
      }
      ref.read(gameSettingsProvider).passTurn();
    }
  }
}

final questionsProvider = AsyncNotifierProvider<QuestionsAsyncNotifier, QuestionsState>(
  QuestionsAsyncNotifier.new,
);