class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? image;
  DateTime? birthDate;
  DateTime? time;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.birthDate,
      this.time});
}

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
}

class ReadModel {
  String? id;
  String? bookId;
  int? prePage;
  int? newPage;
  DateTime? time;

  ReadModel({this.id, this.bookId, this.prePage, this.newPage, this.time});
}
