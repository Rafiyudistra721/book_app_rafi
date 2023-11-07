// ignore_for_file: avoid_print, prefer_final_fields

import 'package:book_app_rafi/app/data/Models/user_model.dart';
import 'package:book_app_rafi/app/routes/app_pages.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../integrations/firestore.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

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
  RxString _selectedGender = ''.obs;
  RxString get selectedGender => _selectedGender;

  void setSelectedGender(String value) {
    _selectedGender = value.obs;
    update();
  }

  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  handleBirthDate(dynamic context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate:
                DateTime(selectedDate?.year ?? DateTime.now().year - 100),
            lastDate: DateTime.now()) ??
        selectedDate;
  }

  login() async {
    try {
      // ignore: unused_local_variable
      final myUser = await _auth.signInWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      if (myUser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Failed to Login",
          middleText:
              "Verify your email first, Does verification need to be resent?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
            Get.snackbar('Success', 'Verification code has been sent to your email');
          },
          textConfirm: 'Yes',
          textCancel: 'No',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast("No User found for that email");
      } else if (e.code == 'wrong-password') {
        toast("Wrong password provided for that user");
      } else {
        toast(e.toString());
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  register() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        username: nameC.text,
        email: emailC.text,
        password: passwordC.text,
        birthDate: selectedDate,
        image: '',
        time: DateTime.now(),
        gender: selectedGender.string

      );
      UserCredential myUser = await _auth.createUserWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      await myUser.user!.sendEmailVerification();
      user.id = myUser.user!.uid;
      if (user.id != null) {
        firebaseFirestore.collection(usersCollection)
            .doc(user.id)
            .set(user.toJson);
      }
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      if (e.code == 'weak-password') {
        toast('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        toast('An account already exists for this email');
      } else {
        toast(e.toString());
      }
    }
  }

  void logout() async {
    Get.defaultDialog(
        title: 'Logout',
        middleText: 'Are you sure?',
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.back();
          isSaving = false;
          emailC.clear();
          passwordC.clear();
          Get.offAndToNamed(Routes.LOGIN);
        },
        textConfirm: 'Yes',
        textCancel: 'No');
  }

  streamUser(User? fuser) {
    if (fuser != null) {
      currentUser.bindStream(UserModel().streamList(fuser.uid));
      print("auth id = ${fuser.uid}");
    } else {
      print("null auth");
      user = UserModel();
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, streamUser);
  }

  @override
  void onClose() {
    emailC.clear();
    passwordC.clear();
    password2C.clear();
    nameC.clear();
  }
}
