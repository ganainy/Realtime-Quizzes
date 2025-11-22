import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendResetEmail() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.back(); // Go back to login screen
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
