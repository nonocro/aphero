import 'package:flutter/material.dart';
import 'package:aphero/main.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_game.dart';

// ---- Global GameSetting object ----
class GameSetting {
  int nbQuestion;
  int difficulty;
  String style;

  GameSetting({
    required this.nbQuestion,
    required this.difficulty,
    required this.style,
  });
}

// This instance will be accessible everywhere this file is imported
GameSetting gameSetting = GameSetting(nbQuestion: 50, difficulty: 2, style: "Aléatoire");

class BraveryOrConfessionSettings extends StatefulWidget {
  const BraveryOrConfessionSettings({super.key});

  @override
  State<BraveryOrConfessionSettings> createState() => _BraveryOrConfessionSettingsState();
}

class _BraveryOrConfessionSettingsState extends State<BraveryOrConfessionSettings> {
  int _questionCount = gameSetting.nbQuestion;
  int _difficulty = gameSetting.difficulty;
  String _style = gameSetting.style;

  final List<int> _questionOptions = [20, 30, 50, 100];
  final List<int> _difficultyOptions = [1, 2, 3, 4];
  final List<String> _styleOptions = ["Soft", "Hot", "Aléatoire"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.accent, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_fire_department, color: AppColors.textLight, size: 20),
                            SizedBox(width: 6),
                            Text(
                              "Bravoure ou Confession ?",
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.person, color: AppColors.textLight, size: 18),
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
                            color: AppColors.background,
                            border: Border.all(color: AppColors.textLight, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.close, color: AppColors.textLight, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // Nombre de Questions
                  const _SectionLabel("Nombre de Questions :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _questionOptions.map((q) {
                      final selected = _questionCount == q;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: _SelectButton(
                            label: q.toString(),
                            selected: selected,
                            onTap: () => setState(() {
                              _questionCount = q;
                              gameSetting.nbQuestion = q;
                            }),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),

                  // Niveau de Difficultés
                  const _SectionLabel("Niveau de Difficultés :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _difficultyOptions.map((d) {
                      final selected = _difficulty == d;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: _SelectButton(
                            label: "+" * d,
                            selected: selected,
                            onTap: () => setState(() {
                              _difficulty = d;
                              gameSetting.difficulty = d;
                            }),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),

                  // Styles des Questions
                  const _SectionLabel("Styles des Questions :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _styleOptions.map((s) {
                      final selected = _style == s;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: _SelectButton(
                            label: s,
                            selected: selected,
                            onTap: () => setState(() {
                              _style = s;
                              gameSetting.style = s;
                            }),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),

                  // Lancer ce jeu Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the game page with selected settings
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BraveryOrConfessionGame(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.textLight,
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
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SelectButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.background,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.textLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? AppColors.textDark : AppColors.textLight,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}