import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_header.dart';
import 'medical_screen.dart';

class MedicalLoginScreen extends StatefulWidget {
  const MedicalLoginScreen({super.key});

  @override
  State<MedicalLoginScreen> createState() => _MedicalLoginScreenState();
}

class _MedicalLoginScreenState extends State<MedicalLoginScreen> {
  final _id = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    final auth = context.read<AuthProvider>();
    final ok = await auth.login(
      usernameOrId: _id.text.trim(),
      password: _password.text,
      scope: 'medical',
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MedicalScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Check your credentials.')),
      );
    }
  }

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Medical Records Login', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            TextField(
              controller: _id,
              decoration: const InputDecoration(
                labelText: AppStrings.usernameOrId,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.password,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.royalBlue,
                  minimumSize: const Size.fromHeight(AppSpacing.minTapTarget),
                ),
                onPressed: _busy ? null : _signIn,
                child: _busy
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
                    : const Text(AppStrings.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}