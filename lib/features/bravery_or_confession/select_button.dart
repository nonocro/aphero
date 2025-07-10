import 'package:aphero/main.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectButton({super.key, 
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.background,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.textLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? AppColors.textDark : AppColors.textLight,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}