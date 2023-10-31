import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 199,
                  width: 252,
                  child: Image.asset("assets/icon/login_icon.png"),
                ),
                Obx(() => Form(
                        child: Column(
                      children: [
                        TextFormField(
                          
                        )
                      ],
                    )))
              ],
            ),
          ),
        ));
  }
}
