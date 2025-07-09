import 'package:aphero/main.dart';
import 'package:flutter/material.dart';
import 'package:aphero/features/bravery_or_confession/bravery_or_confession_rules.dart';
import 'package:aphero/features/under_border/under_border.dart';
import 'package:aphero/features/joust_of_secrets/joust_of_secrets.dart';
import 'package:aphero/features/joust_of_horses/joust_of_horses.dart';
import 'package:aphero/features/gossip_hunting/gossip_hunting.dart';
import 'package:aphero/features/taboos_of_heroes/taboos_of_heroes.dart';
import 'package:aphero/features/arrow_of_destiny/arrow_of_destiny.dart';
import 'package:aphero/features/babylon_tower/BabylonTower.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // black
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
                Image.asset(
                  "assets/images/app_name_dark.png",
                  width: 300,
                  height: (MediaQuery.of(context).size.height * 0.2),
                ),
              // -- Main Container with border, holds the 2x4 "buttons" grid --
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.containerBackground, // white
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.accent, // orange border
                    width: 5,
                  ),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                // 2 columns x 4 rows
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    _buildSquare(icon: Icons.whatshot, color: AppColors.accent, size: 50, context: context, destination: const BraveryOrConfessionRules()),
                    _buildSquare(icon: Icons.theater_comedy, color: AppColors.background, size: 100, context: context, destination: const UnderBorder()),

                    _buildSquare(icon: Icons.fort, color: AppColors.background, size: 100, context: context, destination: const BabylonTower()),
                    _buildSquare(icon: Icons.content_cut, color: AppColors.accent, size: 100, context: context, destination: const JoustOfSecrets()),

                    _buildSquare(icon: Icons.pets, color: AppColors.accent, size: 100, context: context, destination: const GossipHunting()),
                    _buildSquare(icon: Icons.security, color: AppColors.background, size: 100, context: context, destination: const TaboosOfHeroes()),

                    _buildSquare(icon: Icons.center_focus_strong, color: AppColors.background, size: 100, context: context, destination: const ArrowOfDestiny()),
                    _buildSquare(icon: Icons.directions_run, color: AppColors.accent, size: 100, context: context, destination: const JoustOfHorses()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for each icon "square" in the grid.
  Widget _buildSquare({
    required IconData icon,
    required Color color,
    required double size,
    required BuildContext context,
    required Widget destination, // Add this parameter
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size * 0.8,
            color: AppColors.textLight, // white icon
          ),
        ),
      ),
    );
  }
}