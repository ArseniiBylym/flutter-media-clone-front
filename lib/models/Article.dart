import './User.dart';

class ArticleModel {
  String id;
  String title;
  String description;
  String text;
  String image;
  UserModel author;
  List<Object> comments;
  List<UserModel> likes;
  List<String> tags;

  ArticleModel({this.id, this.title, this.description, this.text, this.image, this.author, this.comments, this.likes, this.tags});
}