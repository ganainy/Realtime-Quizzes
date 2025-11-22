import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/screens/login/login_controller.dart';

import '../../customization/theme.dart';
import '../../models/download_state.dart';
import '../../shared/modern_ui.dart';
import '../register/register.dart';
import '../reset_password/reset_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ModernScaffold(
      body: Obx(() {
        return Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  const ModernHeader(
                    title: 'Login',
                    subtitle: 'Login to access your challenges and statistics',
                  ),
                  const SizedBox(height: 48),

                  // Email Field
                  ModernTextField(
                    controller: emailController,
                    hintText: 'Email address',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter Email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  ModernTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isPasswordVisible: loginController.isPasswordVisible.value,
                    onVisibilityChanged: () {
                      loginController.changePasswordVisibility();
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ResetPasswordScreen());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color:
                              isDark ? secondaryTextDark : secondaryTextLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  ModernButton(
                    text: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginController.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    isLoading: loginController.downloadState.value ==
                        DownloadState.LOADING,
                  ),
                  const SizedBox(height: 24),

                  // Register Link
                  _buildRegisterLink(context, isDark),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRegisterLink(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? secondaryTextDark : secondaryTextLight,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.off(() => RegisterScreen());
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Register',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
