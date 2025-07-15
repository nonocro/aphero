import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Soldier {
  Soldier({
    required this.name,
    required this.points,
  });

  String name;
  int points;
}

class SoldiersNotifier extends ChangeNotifier {
  final soldiers = <Soldier>[];

  void addSoldier(String soldierName) {
    soldiers.add(Soldier(name: soldierName, points: 0));
    notifyListeners();
  }

  void removeSoldier(String soldierNameToDelete) {
    soldiers.remove(soldiers.firstWhere((soldier) => soldier.name == soldierNameToDelete));
    notifyListeners();
  }
}

final soldiersProvider = ChangeNotifierProvider<SoldiersNotifier>((ref) {
  return SoldiersNotifier();
});