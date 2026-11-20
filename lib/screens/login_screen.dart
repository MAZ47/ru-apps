import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_header.dart';
import '../widgets/ru_seal.dart';

/// Shared login screen scaffold for all auth-gated modules
/// (Library, Medical, Student Service, Webmail). Wired to AuthProvider
/// so once the user is signed in, the destination module can rely on
/// the same session.
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.onLoginSuccess,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  /// Called on successful login. Typically `Navigator.pushReplacementNamed`
  /// to the module's home route.
  final VoidCallback onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  @override
  void dispose() {
    _idCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final ok = await auth.login(
      usernameOrId: _idCtrl.text.trim(),
      password: _pwCtrl.text,
    );
    if (!mounted) return;
    if (ok) {
      widget.onLoginSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage ?? AppStrings.invalidCredentials),
          backgroundColor: AppColors.crimsonRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppHeader(title: widget.title, showBackButton: true),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: RuSeal(size: 64)),
                    const SizedBox(height: AppSpacing.md),
                    Icon(widget.icon,
                        size: 36, color: AppColors.royalBlue),
                    const SizedBox(height: AppSpacing.sm),
                    Text(widget.title,
                        textAlign: TextAlign.center,
                        style: AppTypography.sectionHeader),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(widget.subtitle!,
                          textAlign: TextAlign.center,
                          style: AppTypography.body),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    TextFormField(
                      controller: _idCtrl,
                      decoration: const InputDecoration(
                        labelText: AppStrings.usernameOrId,
                        border: OutlineInputBorder(),
                      ),
                      validator: Validators.usernameOrStudentId,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _pwCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: AppStrings.password,
                        border: OutlineInputBorder(),
                      ),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ElevatedButton(
                      onPressed: auth.busy ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.royalBlue,
                        foregroundColor: AppColors.white,
                        minimumSize:
                        const Size.fromHeight(AppSpacing.minTapTarget),
                      ),
                      child: auth.busy
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white),
                        ),
                      )
                          : const Text(AppStrings.signIn),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppStrings.forgotPassword),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}