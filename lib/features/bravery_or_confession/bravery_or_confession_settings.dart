import 'package:aphero/features/bravery_or_confession/section_label.dart';
import 'package:aphero/features/bravery_or_confession/select_button.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FractionallySizedBox(        
            widthFactor: 0.9,
            heightFactor: 0.9,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
          
                  const SectionLabel("Nombre de Questions :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _questionOptions.map((q) {
                      final selected = _questionCount == q;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SelectButton(
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
          
                  const SectionLabel("Niveau de Difficultés :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _difficultyOptions.map((d) {
                      final selected = _difficulty == d;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SelectButton(
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
          
                  const SectionLabel("Styles des Questions :"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _styleOptions.map((s) {
                      final selected = _style == s;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SelectButton(
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
          
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
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
        )
      )
    );
  }
}