import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
   String user;
   String content;
   int timestamp;
   Comment({this.user,this.content,this.timestamp});
   factory Comment.fromJson(Map<String,dynamic> json)=>
       Comment(
          user: json['user'],
          content: json['content'],
          timestamp: json['time'] as int
       );
   Map<String, dynamic> toJson()=>
       <String,dynamic>{
          'user' : user,
          'content': content,
          'time' :timestamp
       };

}