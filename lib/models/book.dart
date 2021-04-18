import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/models/comment.dart';

class Book {
  String idAuthor;
  final String name;
  final String author;
  //final List<String> categories;
  List<Chapter> chapters;
  final String imagePath;
  List <Comment> comments;
  Book({this.name,this.author,this.chapters,this.imagePath,this.comments});
  factory Book.fromJson(Map<String,dynamic> json){
    return Book(
        name: json['name'],
        author: json['author'],
        chapters: (json['chapters'] as List)
            ?.map((e) => e==null?null:Chapter.fromJson(e as Map<String,dynamic>)),
        imagePath: json['imagePath'],
        comments: (json['comments'] as List)
            ?.map((e) => e==null?null:Comment.fromJson(e as Map<String,dynamic>)) 
    );
  }
  Map<String,dynamic> toJson()=>
    <String,dynamic>{
       'name': this.name,
       'author': this.author,
       'chapter': this.chapters,
       'imagePath': this.imagePath,
       'comments':this.comments
    };

}