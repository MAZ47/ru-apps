import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';
import '../widgets/ru_seal.dart';

/// Initial route shown for ~1.5s before pushing the main app shell.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.royalBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _controller,
              child: const RuSeal(size: 120),
            ),
            const SizedBox(height: AppSpacing.md),
            FadeTransition(
              opacity: _controller,
              child: Text(
                AppStrings.appName,
                style: AppTypography.screenTitle.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'University of Rajshahi',
              style: AppTypography.label.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.lg),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
