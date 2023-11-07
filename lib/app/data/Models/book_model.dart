import 'dart:io';

import 'package:book_app_rafi/app/data/database.dart';
import 'package:book_app_rafi/app/integrations/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class BookModel {
  String? id;
  String? title;
  String? category;
  int? page;
  int? readPage;
  String? image;
  DateTime? time;

  BookModel(
      {this.id, this.title, this.category, this.page, this.image, this.time});

  BookModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
      id =  doc.id;
      title = json?['title'];
      category = json?['category'];
      page = json?['page'].toInt();
      readPage = json?['readPage'].toInt();
      image = json?['image'];
      time = (json?['time'] as Timestamp?)?.toDate();
  }
  Map<String, dynamic> get toJson => {
    'id': id,
    'title': title,
    'category': category,
    'page': page,
    'readPage': readPage,
    'image': image,
    'time': time
  };

  Database db = Database(
    collectionReference: firebaseFirestore.collection(
      booksCollection,
    ),
    storageReference: firebaseStorage.ref(booksCollection));

  Future<BookModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }
  Future delete() async {
    (id == null) ? toast("Error Invalid ID") : await db.delete(id!, url: image);
  }

  Stream<List<BookModel>> streamList({int? limit}) async* {
    var query = db.collectionReference.orderBy("time", descending: true);
    if (limit is int) {
      query = query.limit(limit);
    }
    yield* query.snapshots().map((query) {
      List<BookModel> list = [];
      for (var doc in query.docs) {
        list.add(
          BookModel.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}