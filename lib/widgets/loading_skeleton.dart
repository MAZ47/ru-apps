import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Pulsing grey placeholder-bar skeleton, reusing the same visual rhythm
/// as [EmptyState] so both read as one system while content loads.
class LoadingSkeleton extends StatefulWidget {
  final int rows;
  const LoadingSkeleton({super.key, this.rows = 4});

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final opacity = 0.4 + (_controller.value * 0.3);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Column(
            children: List.generate(widget.rows, (i) => _SkeletonRow(opacity: opacity)),
          ),
        );
      },
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  final double opacity;
  const _SkeletonRow({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Opacity(
            opacity: opacity,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.emptyStateGrey, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Opacity(
              opacity: opacity,
              child: Container(
                height: 14,
                decoration: BoxDecoration(color: AppColors.emptyStateGrey, borderRadius: BorderRadius.circular(7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





