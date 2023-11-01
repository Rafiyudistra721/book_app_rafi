// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  GlobalKey<FormState> form = GlobalKey();
  final authC = Get.find<LoginController>();
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 80),
                        SizedBox(
                          height: 250,
                          width: 300,
                          child: Image.asset("assets/icon/login_icon.png"),
                        ),
                Obx(() => Card(
                  child: Form(
                      key: form,
                      child: Column(
                        children: [
                          if (controller.isRegister)
                          TextFormField(
                            controller: controller.nameC,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
                            controller: controller.emailC,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                          ),
                          TextFormField(
                            controller: controller.passwordC,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () => authC.login(), 
                            child: const Text("Login"))
                        ],
                      )),
                )),
              ],
            ),
          ),
        ));
  }
}
