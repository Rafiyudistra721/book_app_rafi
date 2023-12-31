import 'package:book_app_rafi/app/modules/login/controllers/login_controller.dart';
import 'package:book_app_rafi/app/routes/app_pages.dart';
import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:book_app_rafi/app/widgets/book_list.dart';
import 'package:book_app_rafi/app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<LoginController>();
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
                Column(
                  children: [
                    30.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                            backgroundColor: colorThird,
                            radius: 20,
                            child: Icon(Icons.person)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hai...",
                              style: TextStyle(color: colorWhite, fontSize: 15),
                            ),
                            Obx(() => Text(
                                  authC.user.username ?? '',
                                  style: const TextStyle(
                                      color: colorWhite, fontSize: 13),
                                )),
                          ],
                        ),
                        150.width,
                        IconButton(
                            onPressed: () => authC.logout(),
                            icon: const Icon(Icons.notifications,
                                color: colorWhite)),
                      ],
                    ),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Book List",
                          style: TextStyle(color: colorWhite),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORM);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: colorWhite,
                            ))
                      ],
                    ),
                    Obx(() {
                      if (controller.listBook.isEmpty) {
                        return const Center(
                            child: Column(
                          children: [
                            Text("No Book was Found",
                                style: TextStyle(color: colorWhite)),
                            Text(
                              "Add your First Book!",
                              style: TextStyle(color: colorWhite),
                            )
                          ],
                        ));
                      } else {
                        return Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listBook.length,
                            itemBuilder: (context, index) {
                              return BookList(
                                index: index,
                                book: controller.listBook[index],
                              );
                            },
                          ),
                        );
                      }
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(
          initialindex: 0,
        ));
  }
}
