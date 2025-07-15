import 'package:aphero/features/bravery_or_confession/util_widgets/section_label.dart';
import 'package:aphero/features/bravery_or_confession/util_widgets/select_button.dart';
import 'package:aphero/features/shared/provider/game_settings_provider.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BraveryOrConfessionSettings extends ConsumerWidget {
  
  BraveryOrConfessionSettings({super.key});

  final List<int> _questionOptions = [20, 30, 50, 100];
  final List<int> _difficultyOptions = [1, 2, 3, 4];
  final List<String> _styleOptions = ["Soft", "Hot", "Aléatoire"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = context.appColors;

    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.9,
            child: Card(
              color: appColors.background,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionLabel("Nombre de Questions :"),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _questionOptions.map((q) {
                                final selected = ref.watch(gameSettingsProvider).gameSettings.nbQuestion == q;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: SelectButton(
                                      label: q.toString(),
                                      selected: selected,
                                      onTap: () => ref.read(gameSettingsProvider).setNbQuestion(q),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionLabel("Niveau de Difficultés :"),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _difficultyOptions.map((d) {
                                final selected = ref.watch(gameSettingsProvider).gameSettings.difficulty == d;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: SelectButton(
                                      label: "+" * d,
                                      selected: selected,
                                      onTap: () => ref.read(gameSettingsProvider).setDifficulty(d),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionLabel("Styles des Questions :"),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _styleOptions.map((s) {
                                final selected = ref.watch(gameSettingsProvider).gameSettings.style == s;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: SelectButton(
                                      label: s,
                                      selected: selected,
                                      onTap: () => ref.read(gameSettingsProvider).setStyle(s),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BraveryOrConfessionGame(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.accent,
                              foregroundColor: appColors.textLight,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text("Lancer ce jeu"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}