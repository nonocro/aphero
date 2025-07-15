import 'package:aphero/features/shared/util_widgets/square.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_rules.dart';
import 'package:aphero/features/under_border/under_border.dart';
import 'package:aphero/features/joust_of_secrets/joust_of_secrets.dart';
import 'package:aphero/features/joust_of_horses/joust_of_horses.dart';
import 'package:aphero/features/gossip_hunting/gossip_hunting.dart';
import 'package:aphero/features/taboos_of_heroes/taboos_of_heroes.dart';
import 'package:aphero/features/arrow_of_destiny/arrow_of_destiny.dart';
import 'package:aphero/features/babylon_tower/babylon_tower.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
                Image.asset(
                  "assets/images/app_name_dark.png",
                  width: 300,
                  height: (MediaQuery.sizeOf(context).height * 0.2),
                ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                decoration: BoxDecoration(
                  color: appColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appColors.accent,
                    width: 5,
                  ),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    Square(icon: Icons.whatshot, color: appColors.accent, size: 50, destination: const BraveryOrConfessionRules(), gameName: "bravery_or_confession"),
                    Square(icon: Icons.theater_comedy, color: appColors.background, size: 100, destination: const UnderBorder(), gameName: "under_border"),

                    Square(icon: Icons.fort, color: appColors.background, size: 100, destination: const BabylonTower(), gameName: "babylon_tower"),
                    Square(icon: Icons.content_cut, color: appColors.accent, size: 100, destination: const JoustOfSecrets(), gameName: "joust_of_secrets"),

                    Square(icon: Icons.pets, color: appColors.accent, size: 100, destination: const GossipHunting(), gameName: "gossip_hunting"),
                    Square(icon: Icons.security, color: appColors.background, size: 100, destination: const TaboosOfHeroes(), gameName: "taboos_of_heroes"),

                    Square(icon: Icons.center_focus_strong, color: appColors.background, size: 100, destination: const ArrowOfDestiny(), gameName: "arrow_of_destiny"),
                    Square(icon: Icons.directions_run, color: appColors.accent, size: 100, destination: const JoustOfHorses(), gameName: "joust_of_horses"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}