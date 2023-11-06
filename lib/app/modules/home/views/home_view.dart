import 'package:book_app_rafi/app/data/class_model.dart';
import 'package:book_app_rafi/app/modules/login/controllers/login_controller.dart';
import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            colorPrimary,
            colorSecondary,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              30.height,
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: colorThird,
                    radius: 20,
                    child: Icon(Icons.person)),
                  10.width,
                   const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hai...", style: TextStyle(color: colorWhite),),
                      Text("Username", style: TextStyle(color: colorWhite),),
                    ],
                  ),
                  170.width,
                  const Icon(Icons.notifications, color: colorWhite),
                ],
              )
            ],
          ),),
      )
    );
  }
}
