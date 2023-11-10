import 'package:book_app_rafi/app/modules/home/views/home_view.dart';
import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  const FormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThird,
      appBar: AppBar(
        backgroundColor: colorThird,
        title: const Text(
          "Book's Form",
          style: TextStyle(color: colorPrimary, fontSize: 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAll(HomeView());
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Card(
                margin: const EdgeInsets.all(16),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.book,
                            color: colorPrimary,
                            size: 30,
                          ),
                          10.height,
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(color: colorPrimary),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorPrimary)
                                )
                                ),
                                
                            ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
