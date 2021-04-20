import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/models/comment.dart';

class Book {
  String id;
  String idAuthor;
  String name;
  String author;
  String description;
  //final List<String> categories;
  List<Chapter> chapters;
  String imagePath;
  List <Comment> comments;
  Book({this.id,this.name,this.author,this.chapters,this.imagePath,this.comments,this.description});
  factory Book.fromJson(Map<String,dynamic> json){
    return Book(
        name: json['name'],
        author: json['author'],
        chapters: (json['chapters'] as List)
            ?.map((e) => e==null?null:Chapter.fromJson(e as Map<String,dynamic>)),
        imagePath: json['imagePath'],
        comments: (json['comments'] as List)
            ?.map((e) => e==null?null:Comment.fromJson(e as Map<String,dynamic>)) ,
        description: json['description'],
        id: json['id_book']
    );
  }
  Map<String,dynamic> toJson()=>
    <String,dynamic>{
       'name': this.name,
       'author': this.author,
       'chapter': this.chapters,
       'imagePath': this.imagePath,
       'comments':this.comments,
       'description': this.description,
    };

}