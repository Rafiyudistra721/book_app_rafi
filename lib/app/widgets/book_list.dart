
import 'package:book_app_rafi/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookList extends GetView<HomeController> {
BookList({required this.books});
BookList books;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(books);
    return ListView.builder(itemBuilder: itemBuilder);
  }
}