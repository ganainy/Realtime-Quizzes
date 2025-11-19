import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layouts/home/home.dart';
import '../../main_controller.dart';
import '../../models/download_state.dart';
import '../../models/user.dart';
import '../../shared/shared.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var downloadState = DownloadState.INITIAL.obs;

  late MainController mainController;
  @override
  void onInit() {
    try {
      mainController = Get.find<MainController>();
    } catch (e) {
      mainController = Get.put(MainController());
    }
  }

  changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    downloadState.value = DownloadState.LOADING;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //user logged successfully, save user info
      Shared.loggedUser = UserModel(email: auth.currentUser?.email);
      debugPrint('Login email : ${auth.currentUser?.email}');
      Get.off(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      downloadState.value = DownloadState.INITIAL;

      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        mainController.errorDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        mainController.errorDialog('Wrong password provided for that user.');
      } else {
        debugPrint('Login error: ${e.message}');
        mainController
            .errorDialog(e.message ?? 'An error occurred during login.');
      }
    } catch (error) {
      downloadState.value = DownloadState.INITIAL;
      debugPrint('Login error: $error');
      mainController.errorDialog(error.toString());
    }
  }
}
