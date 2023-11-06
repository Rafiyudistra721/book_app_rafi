// ignore_for_file: must_be_immutable

import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/login_controller.dart';
import 'package:intl/intl.dart';

class LoginView extends GetView<LoginController> {
  GlobalKey<FormState> form = GlobalKey();
  final authC = Get.find<LoginController>();
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorThird,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                80.height,
                SizedBox(
                  height: 250,
                  width: 300,
                  child: Image.asset("assets/icon/login_icon.png"),
                ),
                Obx(() => Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Form(
                          key: form,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                if (controller.isRegister)
                                  TextFormField(
                                    validator: (value) =>
                                        value == null || value == ''
                                            ? 'this field is required'
                                            : null,
                                    controller: controller.nameC,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                10.height,
                                TextFormField(
                                  validator: (value) =>
                                      value == null || value == ''
                                          ? 'this field is required'
                                          : null,
                                  controller: controller.emailC,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email_rounded),
                                  ),
                                ),
                                10.height,
                                TextFormField(
                                  validator: (value) =>
                                      value == null || value == ''
                                          ? 'this field is required'
                                          : null,
                                  controller: controller.passwordC,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                ),
                                10.height,
                                if (controller.isRegister)
                                  TextFormField(
                                    validator: (value) =>
                                        value == null || value == ''
                                            ? 'Confirm Your password'
                                            : null,
                                    controller: controller.password2C,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      prefixIcon:
                                          Icon(Icons.check_circle_rounded),
                                    ),
                                  ),
                                10.height,
                                if (controller.isRegister)
                                  ListTile(
                                    leading: Container(
                                        width: 24,
                                        alignment: Alignment.centerLeft,
                                        child: const Icon(
                                          Icons.calendar_today,
                                        )),
                                    onTap: () async =>
                                        await controller.handleBirthDate(context),
                                    title: const Text(
                                      "Birth Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    subtitle: Text(
                                        controller.selectedDate is DateTime
                                            ? DateFormat("EEE, dd MMM y")
                                                .format(controller.selectedDate!)
                                            : '--'),
                                  ),
                                40.height,
                                Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      child: const Text("Forgot the Password?"),
                                    )),
                                15.height,
                                Obx(
                                  () => InkWell(
                                    onTap: controller.isSaving
                                        ? null
                                        : () async {
                                            if (form.currentState!.validate()) {
                                              print("Submit");
                                              controller.isSaving = true;
                                              controller.isRegister
                                                  ? controller.passwordC.text ==
                                                          controller
                                                              .password2C.text
                                                      ? await controller
                                                          .register()
                                                      : toast(
                                                          'The password you entered does not match')
                                                  : await controller.login();
                                              controller.isSaving = false;
                                            }
                                          },
                                    child: Container(
                                      height: 45,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: const LinearGradient(
                                            colors: <Color>[
                                              colorPrimary,
                                              colorSecondary
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                      ),
                                      child: controller.isRegister
                                          ? controller.isSaving
                                              ? const Center(
                                                  child: Text("Loading..."),
                                                )
                                              : const Center(
                                                  child: Text(
                                                    "Register",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                          : controller.isSaving
                                              ? const Center(
                                                  child: Text("Loading..."))
                                              : const Center(
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                    ),
                                  ),
                                ),
                                15.height,
                                GestureDetector(
                                  child: Text(controller.isRegister
                                      ? "Already Have an Account? Login Here!"
                                      : "Don't have an account yet? Register Here!"),
                                  onTap: () {
                                    controller.isRegister =
                                        !controller.isRegister;
                                    controller.nameC.clear();
                                    controller.passwordC.clear();
                                    controller.password2C.clear();
                                    controller.emailC.clear();
                                  },
                                ),
                              ],
                            ),
                          )),
                    )),
              ],
            ),
          ),
        ));
  }
}
