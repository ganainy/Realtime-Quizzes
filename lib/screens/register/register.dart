import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/screens/register/register_controller.dart';

import '../../customization/theme.dart';
import '../../models/download_state.dart';
import '../../shared/modern_ui.dart';
import '../login/login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegisterController registerController = Get.put(RegisterController());

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
                    title: 'Register',
                    subtitle:
                        'Register to challenge friends and view your statistics',
                  ),
                  const SizedBox(height: 32),

                  // Profile Picture
                  _buildProfilePicture(isDark),
                  const SizedBox(height: 32),

                  // Name Field
                  ModernTextField(
                    controller: nameController,
                    hintText: 'Name',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

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
                    isPasswordVisible:
                        registerController.isPasswordVisible.value,
                    onVisibilityChanged: () {
                      registerController.changePasswordVisibility();
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Register Button
                  ModernButton(
                    text: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerController.register(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                        );
                      }
                    },
                    isLoading: registerController.downloadState.value ==
                        DownloadState.LOADING,
                  ),
                  const SizedBox(height: 24),

                  // Login Link
                  _buildLoginLink(context, isDark),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfilePicture(bool isDark) {
    return Stack(
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? borderDark : borderLight,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: registerController.pickedImageObs.value == null
                ? Image.asset(
                    'assets/images/user.png',
                    fit: BoxFit.cover,
                  )
                : kIsWeb
                    ? Image.network(
                        registerController.pickedImageObs.value!.path,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(registerController.pickedImageObs.value!.path),
                        fit: BoxFit.cover,
                      ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              registerController.getImageFromGallery();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? secondaryTextDark : secondaryTextLight,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.off(() => LoginScreen());
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Login',
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
