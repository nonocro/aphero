import 'dart:convert';
import 'dart:math';
import 'package:aphero/features/shared/victory_screen.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_settings.dart';
import 'package:aphero/main.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:aphero/features/shared/soldier_menu.dart';

// Helper model for a question
class BoCQuestion {
  final String type;
  final String question;
  final String style;
  final int difficulty;
  final int punishment;

  BoCQuestion({
    required this.type,
    required this.question,
    required this.style,
    required this.difficulty,
    required this.punishment,
  });

  factory BoCQuestion.fromJson(Map<String, dynamic> json) {
    return BoCQuestion(
      type: json['type'],
      question: json['question'],
      style: json['style'],
      difficulty: json['difficulty'],
      punishment: json['punishment'],
    );
  }
}

class BraveryOrConfessionGame extends StatefulWidget {
  const BraveryOrConfessionGame({super.key});

  @override
  State<BraveryOrConfessionGame> createState() => _BraveryOrConfessionGameState();
}

class _BraveryOrConfessionGameState extends State<BraveryOrConfessionGame> {
  List<BoCQuestion> _questions = [];
  int _currentIndex = 0;
  int _revealed = 0;
  late String _currentSoldier;
  late String _bravoureQuestion;
  late String _confessionQuestion;
  late int _currentPunishment;
  bool _loading = true;
  bool _gameOver = false;

  Map<String, int> _soldierPunishments = {};


  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final String data = await rootBundle.loadString(
          'assets/bravery_or_confession_questions.json');
      final List<dynamic> jsonResult = json.decode(data);

      List<BoCQuestion> filtered = jsonResult
          .map((e) => BoCQuestion.fromJson(e))
          .where((q) {
        bool styleOk = gameSetting.style == "Aléatoire" || q.style == gameSetting.style.toLowerCase();
        bool diffOk = q.difficulty <= gameSetting.difficulty;
        return styleOk && diffOk;
      })
          .toList();

      _questions = filtered;

      _soldierPunishments = { for (var name in soldierNames) name : 0 };
       if (soldierNames.isEmpty) {
        _soldierPunishments["Joueur"] = 0;
      }


      if (_questions.isEmpty || gameSetting.nbQuestion <= 0) {
        setState(() {
          _loading = false;
          _gameOver = true;
        });
        return;
      }


      setState(() {
        _currentIndex = 0;
        _setupTurn();
        _loading = false;
      });

    } catch (e) {
      setState(() {
        _loading = false;
        _gameOver = true;
      });
    }
  }

  void _setupTurn() {
     if (_gameOver) return;

    if (soldierNames.isEmpty) {
      _currentSoldier = "Joueur";
    } else {
      _currentSoldier = (soldierNames.toList()..shuffle()).first;
      _soldierPunishments.putIfAbsent(_currentSoldier, () => 0);
    }

    final bravoureList = _questions.where((q) => q.type == "action").toList();
    final confessionList = _questions.where((q) => q.type == "truth").toList();

    _bravoureQuestion = bravoureList.isNotEmpty
        ? bravoureList[Random().nextInt(bravoureList.length)].question.replaceAll("@user_name", _currentSoldier)
        : "Aucune bravoure disponible";

    _confessionQuestion = confessionList.isNotEmpty
        ? confessionList[Random().nextInt(confessionList.length)].question.replaceAll("@user_name", _currentSoldier)
        : "Aucune confession disponible";

    if (_questions.isNotEmpty) {
      _currentPunishment = _questions[_currentIndex % _questions.length].punishment;
    } else {
      _currentPunishment = 3;
    }

    _revealed = 0;
  }


  void _nextTurn() {
    final nextIndex = _currentIndex + 1;

    if (nextIndex >= gameSetting.nbQuestion) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VictoryScreen(soldierPunishments: _soldierPunishments),
        ),
      );
    } else {
      setState(() {
        _currentIndex = nextIndex;
        _setupTurn(); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries = _soldierPunishments.entries.toList();

    sortedEntries.sort((a, b) => a.value.compareTo(b.value));

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              // Header Row
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
              const SizedBox(height: 10),
              Text(
                _currentSoldier,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                "Punitions: ${_soldierPunishments[_currentSoldier] ?? 0} Goulée${(_soldierPunishments[_currentSoldier] ?? 0) > 1 ? 's' : ''}",
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _FlipCard(
                         key: ValueKey('bravoure_card_$_currentIndex'), // Key changes per turn for animation
                        revealed: _revealed == 1,
                        frontColor: AppColors.containerBackground,
                        backColor: AppColors.containerBackground,
                        icon: Icons.local_fire_department,
                        label: "Bravoure",
                        frontLabelColor: AppColors.textDark,
                        backTextColor: AppColors.textDark,
                        question: _bravoureQuestion,
                        onTap: () {
                          if (_revealed == 0 && !_gameOver) {
                            setState(() {
                              _revealed = 1;
                            });
                          } else if (_revealed == 1 && !_gameOver) {
                             setState(() {
                              _revealed = 0;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FlipCard(
                         key: ValueKey('confession_card_$_currentIndex'),
                        revealed: _revealed == 2,
                        frontColor: AppColors.accent,
                        backColor: AppColors.accent,
                        frontLabelColor: AppColors.textLight,
                        backTextColor: AppColors.textLight,
                        icon: Icons.theater_comedy,
                        label: "Confession",
                        question: _confessionQuestion,
                        onTap: () {
                          if (_revealed == 0 && !_gameOver) {
                            setState(() {
                              _revealed = 2;
                            });
                          } else if (_revealed == 2 && !_gameOver) {
                             setState(() {
                              _revealed = 0;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.textLight, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "Punition de ce tour: $_currentPunishment Goulée${_currentPunishment > 1 ? 's' : ''}",
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                      border: Border.all(color: AppColors.textLight, width: 2),
                    ),
                  ),
                   FractionallySizedBox(
                      widthFactor: (_currentIndex) / (gameSetting.nbQuestion),
                       child: Container(
                         height: 18,
                         decoration: BoxDecoration(
                           color: AppColors.accent,
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                   ),

                  Positioned.fill(
                    child: Center(
                      child: Text(
                        "$_currentIndex/${gameSetting.nbQuestion}",
                        style: TextStyle(
                          color: (_currentIndex / gameSetting.nbQuestion) > 0.5 ? AppColors.textLight : AppColors.textDark,
                          fontWeight: FontWeight.bold,
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
                      onPressed: (_revealed != 0 && !_gameOver) ? () {
                        _nextTurn();
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.textLight,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.3),
                        disabledForegroundColor: AppColors.textLight.withValues(alpha: 0.3),
                      ),
                      child: const Text("Héroïque"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (_revealed != 0 && !_gameOver) ? () {
                        setState(() {
                          _soldierPunishments[_currentSoldier] =
                              (_soldierPunishments[_currentSoldier] ?? 0) + _currentPunishment;
                        });
                        _nextTurn();
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        foregroundColor: AppColors.textLight,
                        side: const BorderSide(color: AppColors.textLight, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                         disabledBackgroundColor: AppColors.background.withValues(alpha: 0.3),
                        disabledForegroundColor: AppColors.textLight.withValues(alpha: 0.3),
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

class _FlipCard extends StatefulWidget {
  final bool revealed;
  final Color frontColor;
  final Color backColor;
  final IconData icon;
  final String label;
  final Color frontLabelColor;
  final Color backTextColor;
  final String question;
  final VoidCallback onTap;

  const _FlipCard({
    super.key,
    required this.revealed,
    required this.frontColor,
    required this.backColor,
    required this.icon,
    required this.label,
    required this.frontLabelColor,
    required this.backTextColor,
    required this.question,
    required this.onTap,
  });

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);

    if (widget.revealed) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.revealed != oldWidget.revealed) {
      if (widget.revealed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFrontContent() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: widget.frontColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.textLight, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: widget.frontLabelColor, size: 48),
            const SizedBox(height: 10),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.frontLabelColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackContent() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: widget.backColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.textLight, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.question,
            style: TextStyle(
              color: widget.backTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double angle = _animation.value;

          final bool isFrontVisible = angle < pi / 2;

          final Widget displayWidget = isFrontVisible
              ? _buildFrontContent()
              : _buildBackContent();

          final Matrix4 transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFrontVisible
                ? displayWidget
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: displayWidget,
                  ),
          );
        },
      ),
    );
  }
}
