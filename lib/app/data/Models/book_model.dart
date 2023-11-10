// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:book_app_rafi/app/data/Models/read_model.dart';
import 'package:book_app_rafi/app/data/database.dart';
import 'package:book_app_rafi/app/integrations/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class BookModel {
  String? id;
  String? title;
  String? category;
  int? page;
  String? image;
  DateTime? time;
  ReadModel? readModel;

  BookModel(
      {this.id, 
      this.title, 
      this.category, 
      this.page, 
      this.image, 
      this.time, 
      this.readModel}
      );

  BookModel fromJson(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>?;
    return BookModel(
      id :  doc.id,
      title : json?['title'],
      category : json?['category'],
      page : json?['page'].toInt(),
      image : json?['image'],
      time : (json?['time'] as Timestamp?)?.toDate(),
      readModel : ReadModel().fromJson(doc),
    );
  }

  Map<String, dynamic> get toJson => {
    'id': id,
    'title': title,
    'category': category,
    'page': page,
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

  Stream<List<BookModel>> streamList() async* {
  var Query = db.collectionReference.orderBy("time", descending: true);
  yield* Query.snapshots().map((query) {
    List<BookModel> list = [];
    for (var doc in query.docs) {
      list.add(
        BookModel().fromJson(
          doc,
        ),
      );
    }
    return list;
  });
}

}