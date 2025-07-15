import 'package:aphero/features/shared/provider/soldiers_provider.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/shared/game_menu.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoldierMenu extends ConsumerStatefulWidget {
  const SoldierMenu({super.key});

  @override
  ConsumerState<SoldierMenu> createState() => _SoldierMenuState();
}

class _SoldierMenuState extends ConsumerState<SoldierMenu> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<Soldier> _animatedSoldiers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialSoldiers = ref.read(soldiersProvider).soldiers;
      Future.delayed(const Duration(milliseconds: 200), () {
        for (int i = 0; i < initialSoldiers.length; i++) {
          Future.delayed(Duration(milliseconds: i * 150), () {
            if (_listKey.currentState != null) {
              _animatedSoldiers.add(initialSoldiers[i]);
              _listKey.currentState!.insertItem(i);
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addSoldierTitle() {
    final newTitle = _titleController.text.trim();
    if (newTitle.isNotEmpty) {
      final newSoldier = Soldier(name: newTitle, points: 0);
      ref.read(soldiersProvider.notifier).addSoldier(newTitle);

      final int newIndex = _animatedSoldiers.length;
      _animatedSoldiers.add(newSoldier);
      _listKey.currentState!.insertItem(newIndex, duration: const Duration(milliseconds: 600));
      _titleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: appColors.containerBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/logo_light.png",
                        width: 150,
                        height: 150,
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/soldier.png",
                        width: 100,
                        height: 160,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Titre du Soldat",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: appColors.textDark,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: appColors.accent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: TextStyle(color: appColors.textDark),
                          cursorColor: appColors.accent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: _addSoldierTitle,
                        child: Container(
                          decoration: BoxDecoration(
                            color: appColors.accentLight,
                            border: Border.all(
                              color: appColors.textDark,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.add,
                            color: appColors.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _animatedSoldiers.isEmpty && ref.watch(soldiersProvider).soldiers.isEmpty
                        ? const Center(
                            child: Text(
                              "Aucun soldat ajouté pour l’instant",
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                            ),
                          )
                        : AnimatedList(
                            key: _listKey,
                            initialItemCount: _animatedSoldiers.length,
                            itemBuilder: (context, index, animation) {
                              final title = _animatedSoldiers[index].name;
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  axisAlignment: -1.0,
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: appColors.accent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        color: appColors.textDark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GameMenu(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.textDark,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Lancer le jeu",
                      style: TextStyle(
                        color: appColors.textLight,
                        fontSize: 16,
                      ),
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