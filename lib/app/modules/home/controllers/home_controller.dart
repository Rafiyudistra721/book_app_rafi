// ignore_for_file: invalid_use_of_protected_member

import 'package:book_app_rafi/app/data/Models/book_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final RxInt editIndex = (-1).obs;

  RxList<BookModel> rxBook = RxList<BookModel>();
  List<BookModel> get listBook => rxBook.value;
  set listBook(List<BookModel> value) => rxBook.value = value;

  @override
  void onInit() {
    rxBook.bindStream(BookModel().streamList());
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

}
