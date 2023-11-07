import 'package:flutter/material.dart';

class ReadModel {
  String? id;
  String? bookId;
  int? prePage;
  int? newPage;
  DateTime? time;

  ReadModel({this.id, this.bookId, this.prePage, this.newPage, this.time});
}