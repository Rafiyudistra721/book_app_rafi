// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:book_app_rafi/app/routes/app_pages.dart';
import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  BottomNav({this.initialindex});
  int? initialindex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: colorThird,
      color: colorBlack,
      activeColor: colorPrimary,
      style: TabStyle.fixedCircle,
      items: const [
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.add),
        TabItem(icon: Icons.person)
      ],
      onTap: (index) {
        if (index == 0) {
          Get.toNamed(Routes.HOME);
        } else if (index == 1) {
          Get.toNamed(Routes.FORM);
        } else if (index == 2) {
          Get.toNamed(Routes.PROFILE);
        }
      },
      initialActiveIndex: initialindex,
      );
  }
}