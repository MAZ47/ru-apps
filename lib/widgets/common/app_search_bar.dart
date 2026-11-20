import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// One reusable search bar used on Home (display-only) and Directory
/// (live filtering). Pass [onChanged] to make it interactive; omit it
/// for a static display-only bar.
class AppSearchBar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;

  const AppSearchBar({super.key, required this.placeholder, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.minTapTarget,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          const Icon(Icons.search, color: AppColors.slateGrey),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: onChanged == null
                ? Text(placeholder, style: AppTypography.body)
                : TextField(
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: placeholder,
                      hintStyle: AppTypography.body,
                    ),
                    style: AppTypography.body.copyWith(color: Colors.black87),
                  ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }
}





