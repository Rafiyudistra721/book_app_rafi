// ignore_for_file: must_be_immutable

import 'package:book_app_rafi/app/data/Models/book_model.dart';
import 'package:book_app_rafi/app/modules/home/controllers/home_controller.dart';
import 'package:book_app_rafi/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class BookList extends GetView<HomeController> {
  final int index;
  BookList({super.key, required this.index, required this.book});
  BookModel book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.editIndex.value = index;
      },
      child: controller.editIndex.value == index
          ? Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  color: colorSecondary.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(right: 15),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        controller.editIndex.value = -1;
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: colorWhite, shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: colorBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.edit,
                                color: colorWhite,
                                size: 20,
                              ),
                              10.width,
                              const Text(
                                'Edit',
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        20.height,
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.delete,
                                color: colorWhite,
                                size: 20,
                              ),
                              10.height,
                              const Text(
                                'Delete',
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: colorThird,
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(right: 15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.network(
                          book.image ?? '',
                          height: 60,
                          width: 106,
                        ),
                      ),
                    ),
                    18.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        book.title ?? '',
                        style:
                            const TextStyle(color: colorPrimary, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        book.category ?? '',
                        style:
                            const TextStyle(color: colorPrimary, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${book.readModel?.prePage ?? ''} / ${book.page ?? ''}",
                        style: 
                            const TextStyle(color: colorPrimary, fontSize: 12), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
