import 'package:flutter/material.dart';
import '../../models/department.dart';
import '../../core/theme/app_theme.dart';

/// Horizontal-scroll row of faculty filter chips under Directory's search bar.
class FacultyChipRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const FacultyChipRow({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: Faculty.all.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final faculty = Faculty.all[i];
          final isSelected = faculty == selected;
          return ChoiceChip(
            label: Text(faculty),
            selected: isSelected,
            onSelected: (_) => onSelected(faculty),
            selectedColor: AppColors.royalBlue,
            backgroundColor: AppColors.white,
            labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.slateGrey, fontSize: 12),
            side: BorderSide(color: isSelected ? AppColors.royalBlue : AppColors.chipUnselectedBorder),
            shape: const StadiumBorder(),
          );
        },
      ),
    );
  }
}





