import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/modern_ui.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return ModernScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            ModernIconButton(
              icon: Icons.arrow_back,
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 32),

            const ModernHeader(
              title: 'Reset Password',
              subtitle: 'Enter your email to receive a reset link',
            ),
            const SizedBox(height: 32),

            ModernContentCard(
              child: Column(
                children: [
                  ModernTextField(
                    hintText: 'Email',
                    controller: controller.emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ModernButton(
                        text: 'Send Reset Link',
                        onPressed: controller.sendResetEmail,
                        isLoading: controller.isLoading.value,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
