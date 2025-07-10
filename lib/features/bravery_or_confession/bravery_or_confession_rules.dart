import 'package:aphero/main.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_settings.dart';

class BraveryOrConfessionRules extends StatelessWidget {
  const BraveryOrConfessionRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // black
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // App name image at the top
              Image.asset(
                "assets/images/app_name_dark.png",
                width: 300,
                height: MediaQuery.sizeOf(context).height * 0.18,
              ),
              // Main orange card container
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.accent,
                        width: 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        const Text(
                          'Bravoure ou Confession',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Description
                        const Text(
                          "Oyez, oyez !\nIci, un héros sera choisi ! Il devra décider : agir avec bravoure ou dire la vérité ! S’il refuse les deux, qu’il boive trois grandes gorgées sous les rires de l’assemblée !\nÀ qui le tour ?",
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        // Footer Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.containerBackground,
                              foregroundColor: AppColors.textDark,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                  color: AppColors.background,
                                  width: 2,
                                ),
                              ),
                              side: const BorderSide(
                                color: AppColors.background,
                                width: 2,
                              ),
                            ),
                            onPressed: () {
                              // Navigate to the game page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BraveryOrConfessionSettings(),
                                ),
                              );
                            },
                            child: const Text('Suivant'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}