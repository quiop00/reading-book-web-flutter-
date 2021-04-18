import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
   final String user;
   final String content;
   final Timestamp timestamp;
   Comment({this.user,this.content,this.timestamp});
   factory Comment.fromJson(Map<String,dynamic> json)=>
       Comment(
          user: json['user'],
          content: json['content'],
          timestamp: json['time']
       );
   Map<String, dynamic> toJson()=>
       <String,dynamic>{
          'user' : user,
          'content': content,
          'time' :timestamp
       };

}