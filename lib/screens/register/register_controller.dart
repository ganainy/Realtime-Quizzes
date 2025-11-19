import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../../layouts/home/home.dart';
import '../../main_controller.dart';
import '../../models/download_state.dart';
import '../../models/user.dart';
import '../../shared/shared.dart';

class RegisterController extends GetxController {
  var pickedImageObs = Rxn<XFile?>();
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

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? imageUrl,
  }) async {
    // Ensure a profile image is selected
    if (pickedImageObs.value == null) {
      mainController
          .errorDialog('Please select a profile picture before registering.');
      return;
    }
    downloadState.value = DownloadState.LOADING;

    try {
      // Create user with email and password
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // User created successfully, save user info to Firestore
      await saveUserToFirestore(name, email);
      Shared.loggedUser = UserModel(email: auth.currentUser?.email);

      // Upload image if selected
      if (pickedImageObs.value != null) {
        final imageSnapshot = await uploadImage(email);
        final downloadUrl = await getImageDownloadURL(imageSnapshot);
        await updateUserImageUrl(email, downloadUrl);
      }

      downloadState.value = DownloadState.SUCCESS;
      Get.to(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      downloadState.value = DownloadState.INITIAL;

      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        mainController.errorDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        mainController
            .errorDialog('The account already exists for that email.');
      } else {
        debugPrint('Registration error: ${e.message}');
        mainController
            .errorDialog(e.message ?? 'An error occurred during registration.');
      }
    } catch (error) {
      downloadState.value = DownloadState.INITIAL;
      debugPrint('Registration error: $error');
      mainController.errorDialog(error.toString());
    }
  }

  getImageFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      pickedImageObs.value = pickedFile;
    }
  }

  Future<TaskSnapshot> uploadImage(String? email) async {
    //upload image to firebase storage
    final bytes = await pickedImageObs.value!.readAsBytes();
    return await storage
        .ref()
        .child('users/${pickedImageObs.value!.name}')
        .putData(bytes);
  }

  Future<String> getImageDownloadURL(TaskSnapshot imageSnapshot) async {
    return await imageSnapshot.ref.getDownloadURL();
  }

  Future<void> updateUserImageUrl(String? userEmail, String? imageUrl) async {
    return await usersCollection.doc(userEmail).update({'imageUrl': imageUrl});
  }

  Future<void> saveUserToFirestore(
    String name,
    String email,
  ) async {
    UserModel user = UserModel(name: name, email: email);
    await usersCollection.doc(user.email).set(userModelToJson(user));
  }
}
