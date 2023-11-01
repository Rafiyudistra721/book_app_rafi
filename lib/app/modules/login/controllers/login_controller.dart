// ignore_for_file: avoid_print

import 'package:book_app_rafi/app/data/class_model.dart';
import 'package:book_app_rafi/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  var role = "user";

  var currentUser = UserModel().obs;
  UserModel get user => currentUser.value;
  set user(UserModel value) => currentUser.value = value;

  var _isRegister = false.obs;
  bool get isRegister => _isRegister.value;
  set isRegister(value) => _isRegister.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  late Rx<User?> firebaseUser;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController password2C = TextEditingController();

  login() async {
    try {
      // ignore: unused_local_variable
      final myUser = await _auth.signInWithEmailAndPassword(
        email: emailC.text, password: passwordC.text);
      // if (myUser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
      // } else {
        // Get.defaultDialog(
          // title: "Failed to Login",
          // middleText: "Verify your email first, Does verification need to be resent?",
          // onConfirm: () async {
            // await myUser.user!.sendEmailVerification();
            // Get.back();
          // },
          // textConfirm: 'Yes',
          // textCancel: 'No',
        // );
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User found for that email");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user");
      } else {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }
  register() {}
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
