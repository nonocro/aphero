import 'package:aphero/features/shared/provider/soldiers_provider.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/shared/game_menu.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoldierMenu extends ConsumerWidget {
  SoldierMenu({super.key});

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = context.appColors;
    List<Soldier> soldiers = ref.watch(soldiersProvider).soldiers;

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
                mainAxisSize: MainAxisSize.min, // This keeps the Column height minimal
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start, // Align images at the top of the row
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
                        onTap: () => _addSoldierTitle(ref),
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
                    child: soldiers.isEmpty
                        ? const Center(
                          child: Text(
                              "Aucun soldat ajouté pour l’instant",
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: soldiers.length,
                            itemBuilder: (context, index) {
                              final title = soldiers[index].name;
                              return Container(
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
      )
    );
  }

  void _addSoldierTitle(WidgetRef ref) {
    final newTitle = _titleController.text.trim();
    if (newTitle.isNotEmpty) {
      ref.read(soldiersProvider.notifier).addSoldier(newTitle);
      _titleController.clear();
    }
  }
}