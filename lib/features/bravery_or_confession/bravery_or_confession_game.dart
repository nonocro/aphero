import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aphero/features/bravery_or_confession/util_widgets/flip_card.dart';
import 'package:aphero/features/shared/provider/game_settings_provider.dart';
import 'package:aphero/features/shared/provider/questions_provider.dart';
import 'package:aphero/features/shared/provider/soldiers_provider.dart';
import 'package:aphero/theme/app_colors_extension.dart';

class BraveryOrConfessionGame extends ConsumerWidget {
  const BraveryOrConfessionGame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = context.appColors;
    final questionsAsyncValue = ref.watch(questionsProvider);
    final gameSettings = ref.watch(gameSettingsProvider).gameSettings;
    final soldiers = ref.watch(soldiersProvider).soldiers;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: appColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department, color: appColors.textLight, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          "Bravoure ou Confession ?",
                          style: TextStyle(
                            color: appColors.textLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.person, color: appColors.textLight, size: 18),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: appColors.background,
                        border: Border.all(color: appColors.textLight, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.close, color: appColors.textLight, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                soldiers.isNotEmpty
                    ? soldiers[ref.watch(gameSettingsProvider).gameSettings.turn % soldiers.length].name
                    : "No soldiers available",
                style: TextStyle(
                  color: appColors.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: questionsAsyncValue.when(
                  data: (questionsState) {
                    final currentQuestion = questionsState.currentQuestion;
                    final questionText = currentQuestion?.question ?? "No further question";
                    return Row(
                      children: [
                        Expanded(
                          child: FlipCard(
                            key: ValueKey('bravoure_card_${gameSettings.turn}'),
                            frontColor: appColors.containerBackground,
                            backColor: appColors.containerBackground,
                            icon: Icons.local_fire_department,
                            label: "Bravoure",
                            frontLabelColor: appColors.textDark,
                            backTextColor: appColors.textDark,
                            question: questionText.replaceAll('@user_name', soldiers[ref.watch(gameSettingsProvider).gameSettings.turn % soldiers.length].name),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FlipCard(
                            key: ValueKey('confession_card_${gameSettings.turn}'),
                            frontColor: appColors.accent,
                            backColor: appColors.accent,
                            frontLabelColor: appColors.textLight,
                            backTextColor: appColors.textLight,
                            icon: Icons.theater_comedy,
                            label: "Confession",
                            question: questionText.replaceAll('@user_name', soldiers[ref.watch(gameSettingsProvider).gameSettings.turn % soldiers.length].name),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator(color: appColors.accent)),
                  error: (err, stack) => Center(
                    child: Text(
                      'Error loading questions: $err',
                      style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: appColors.background,
                  border: Border.all(color: appColors.textLight, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: questionsAsyncValue.when(
                  data: (questionsState) {
                    final punishment = questionsState.currentQuestion?.punishment ?? 0;
                    return Text(
                      "Punition de ce tour: $punishment Goulée${punishment > 1 ? 's' : ''}",
                      style: TextStyle(
                        color: appColors.textLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    );
                  },
                  loading: () => Text(
                    "Punition de ce tour: Chargement...",
                    style: TextStyle(color: appColors.textLight),
                  ),
                  error: (err, stack) => const Text(
                    "Punition de ce tour: Erreur",
                      style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: appColors.textLight, width: 2),
                    ),
                  ),
                  questionsAsyncValue.when(
                    data: (questionsState) {
                      final turn = gameSettings.turn;
                      final nbQuestion = gameSettings.nbQuestion;
                      final widthFactor = nbQuestion > 0 ? (turn / nbQuestion) : 0.0;
                      return FractionallySizedBox(
                        widthFactor: widthFactor,
                        child: Container(
                          height: 18,
                          decoration: BoxDecoration(
                            color: appColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (err, stack) => const SizedBox.shrink(),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: questionsAsyncValue.when(
                        data: (questionsState) {
                          final turn = gameSettings.turn;
                          final nbQuestion = gameSettings.nbQuestion;
                          return Text(
                            "$turn/$nbQuestion",
                            style: TextStyle(
                              color: (turn / nbQuestion) > 0.5 ? appColors.textLight : appColors.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        loading: () => Text(
                          "Chargement...",
                          style: TextStyle(color: appColors.textDark),
                        ),
                        error: (err, stack) => const Text(
                          "Erreur",
                          style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(questionsProvider.notifier).getFollowingQuestion();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.accent,
                        foregroundColor: appColors.textLight,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        disabledBackgroundColor: appColors.accent.withValues(alpha: 0.3),
                        disabledForegroundColor: appColors.textLight.withValues(alpha: 0.3),
                      ),
                      child: const Text("Héroïque"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(questionsProvider.notifier).getFollowingQuestion();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.background,
                        foregroundColor: appColors.textLight,
                        side: BorderSide(color: appColors.textLight, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        disabledBackgroundColor: appColors.background.withValues(alpha: 0.3),
                        disabledForegroundColor: appColors.textLight.withValues(alpha: 0.3),
                        disabledMouseCursor: SystemMouseCursors.basic,
                      ),
                      child: const Text("Punition"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}