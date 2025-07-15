import 'package:aphero/features/shared/game_menu.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class VictoryScreen extends StatefulWidget {
  final Map<String, int> soldierPunishments;

  const VictoryScreen({super.key, required this.soldierPunishments});

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<MapEntry<String, int>> _getSortedRanking(Map<String, int> punishments) {
    final sortedEntries = punishments.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return sortedEntries;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final sortedRanking = _getSortedRanking(widget.soldierPunishments);

    return Scaffold(
      backgroundColor: appColors.background,
      body: ScaleTransition(
        scale: _animation,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: appColors.background,
                child: Center(
                  child: Image.asset(
                    "assets/images/victory.png",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            Container(
              color: appColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Classement Général",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: appColors.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (sortedRanking.isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: sortedRanking.asMap().entries.map((entry) {
                          final index = entry.key;
                          final soldierEntry = entry.value;
                          final rank = index + 1;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: appColors.accent,
                                    shape: BoxShape.circle,
                                    border: Border.all(color:Colors.white, width: 1.5)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    rank.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.textLight,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black, width: 1.5)
                                    ),
                                    child: Text(
                                      soldierEntry.key,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: appColors.textDark,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black, width: 1.5)
                                  ),
                                  child: Text(
                                    "${soldierEntry.value} gl${soldierEntry.value > 1 ? '' : ''}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.textDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GameMenu(),
                            ),
                          );  
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: Colors.white, width: 2)
                          ),
                        ),
                        child: const Text("Retour au Menu"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
