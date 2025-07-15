import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_settings.dart';

class BraveryOrConfessionRules extends StatelessWidget {
  const BraveryOrConfessionRules({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors.background, // black
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/app_name_dark.png",
                width: 300,
                height: MediaQuery.sizeOf(context).height * 0.18,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: appColors.accent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: appColors.accent,
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
                        Text(
                          'Bravoure ou Confession',
                          style: TextStyle(
                            color: appColors.textDark,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "Oyez, oyez !\nIci, un héros sera choisi ! Il devra décider : agir avec bravoure ou dire la vérité ! S’il refuse les deux, qu’il boive trois grandes gorgées sous les rires de l’assemblée !\nÀ qui le tour ?",
                          style: TextStyle(
                            color: appColors.textDark,
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.containerBackground,
                              foregroundColor: appColors.textDark,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BraveryOrConfessionSettings(),
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