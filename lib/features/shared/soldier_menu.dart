import 'package:flutter/material.dart';
import 'package:aphero/features/shared/game_menu.dart';
import 'package:aphero/main.dart';

List<String> soldierNames = [];

class SoldierMenu extends StatefulWidget {
  const SoldierMenu({super.key});

  @override
  State<SoldierMenu> createState() => _SoldierMenuState();
}

class _SoldierMenuState extends State<SoldierMenu> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Black background
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: AppColors.containerBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---- Header (AP / Flag / Soldier Icon) ----
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          borderSide: const BorderSide(
                            color: AppColors.textDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.accent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Plus Button
                  InkWell(
                    onTap: _addSoldierTitle,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        border: Border.all(color: AppColors.textDark, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: soldierNames.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucun soldat ajouté pour l’instant",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )
                    : ListView.builder(
                        itemCount: soldierNames.length,
                        itemBuilder: (context, index) {
                          final title = soldierNames[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: AppColors.textDark,
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
                  backgroundColor: AppColors.textDark,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Lancer le jeu",
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addSoldierTitle() {
    final newTitle = _titleController.text.trim();
    if (newTitle.isNotEmpty) {
      setState(() => soldierNames.add(newTitle));
      _titleController.clear();
    }
  }
}