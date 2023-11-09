// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:book_app_rafi/app/data/database.dart';
import 'package:book_app_rafi/app/integrations/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class ReadModel {
  String? id;
  String? bookId;
  int? prePage;
  int? newPage;
  DateTime? time;

  ReadModel({this.id, this.bookId, this.prePage, this.newPage, this.time});

  ReadModel fromJson(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>?;
    return ReadModel(
      id: doc.id,
      bookId: json?['bookId'],
      prePage: json?['prePage'],
      newPage: json?['newPage'],
      time: (json?['time'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'bookId': bookId,
        'prePage': prePage,
        'newPage': newPage,
        'time': time
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(
        readCollection,
      ),
      storageReference: firebaseStorage.ref(readCollection));

  Future<ReadModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      db.edit(toJson);
    }
    return this;
  }

  Future delete() async {
    (id == null) ? toast("Error Invalid ID") : await db.delete(id!);
  }

  Stream<List<ReadModel>> streamList() async* {
    var Query = db.collectionReference.orderBy("time", descending: true);
    yield* Query.snapshots().map((query) {
      List<ReadModel> list = [];
      for (var doc in query.docs) {
        list.add(
          ReadModel().fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
