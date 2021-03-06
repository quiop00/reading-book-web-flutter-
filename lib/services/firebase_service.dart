import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/models/comment.dart';
import 'package:uuid/uuid.dart';
class FirebaseService{
  var  firebase = FirebaseFirestore.instance;
  Future<int> addBook(Book book)async{
   var user=FirebaseAuth.instance.currentUser;
   if(user.email==null) return 2;
   book.author= user.email;
   Map<String,dynamic> data=book.toJson();
    try{
        await firebase.collection('books').add(data)
            .catchError((onError){
            print(onError.message);
        });
    }
    catch(err){
        print(err.message);
        return 2;
    }
   return 1;
  }
  Future<int> addChapters(Chapter chapter,String idBook)async{
    var user=FirebaseAuth.instance.currentUser;
    if(user.email==null) return 2;
    var uuid= Uuid();
    chapter.id=uuid.v1();
    try{
      await FirebaseFirestore.instance
          .collection("books")
          .doc(idBook)
          .collection("chapters")
          .add(chapter.toJson()
      );
      return 1;
    }
    catch(err){
      print(err.message);
      return 2;
    }
    return 1;
  }
  Future<List<Book>> getBooks()async{
    List<Book> books;
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    try{
        QuerySnapshot snapshot= await firebase.collection('books').get();
        books = snapshot.docs.map((doc) {
          var book= Book.fromJson(doc.data());
          book.id= doc.id;
          return book;
        } ).toList();
        return books;
    }
    catch(err){
    }
    return null;
  }
  Future<List<Book>> getMyBooks()async{
    List<Book> books;
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    var user=FirebaseAuth.instance.currentUser;
    if(user.email==null) return null;
    try{
      QuerySnapshot snapshot= await firebase.collection('books').get();
      books = snapshot.docs.map((doc) {
        var book= Book.fromJson(doc.data());
        book.id= doc.id;
        return book;
      } ).toList();
      books= books.where((element) => element.author==user.email).toList();
      return books;
    }
    catch(err){
    }
    return null;
  }
  Future<List<Chapter>> getChapters(String idBook)async{
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    var user=FirebaseAuth.instance.currentUser;
    //if(user.email==null) return null;
    try{
      QuerySnapshot snapshots= await firebase.collection('books')
                                                       .doc(idBook)
                                                       .collection("chapters").orderBy("timeStamp").get();
      List<Chapter> chapters;
      var i =0;
      chapters = snapshots.docs.map((doc) {
        var chapter= Chapter.fromJson(doc.data());
        chapter.numberOfChapter= i;
        i++;
        return chapter;
      } ).toList();
      return chapters;
    }
    catch(err){
    }
    return null;
  }
  Future<Map<String,dynamic>> getPreNextChapter(String idBook,int idChapter)async{
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    //if(user.email==null) return null;
    Map<String,dynamic> preNext= {
      "prev":null,
      "next":null
    };
    try{
      QuerySnapshot snapshots= await firebase.collection('books')
          .doc(idBook)
          .collection("chapters").orderBy("timeStamp").get();
      List<Chapter> chapters;
      var i =0;
      chapters = snapshots.docs.map((doc) {
        var chapter= Chapter.fromJson(doc.data());
        chapter.numberOfChapter= i;
        i++;
        return chapter;
      } ).toList();
      if(idChapter!=0)
        preNext["prev"] = chapters[idChapter-1];
      if(idChapter!=chapters.length-1)
         preNext["next"] =chapters[idChapter+1];
    }
    catch(err){
    }
    return preNext;
  }
  // Future<Chapter> getPreChapter(String idBook,int idChapter)async{
  //   if(firebase==null)
  //     firebase = FirebaseFirestore.instance;
  //   //if(user.email==null) return null;
  //   try{
  //     if(idChapter==0)
  //       return null;
  //     QuerySnapshot snapshots= await firebase.collection('books')
  //         .doc(idBook)
  //         .collection("chapters").orderBy("timeStamp").get();
  //     List<Chapter> chapters;
  //     var i =0;
  //     chapters = snapshots.docs.map((doc) {
  //       var chapter= Chapter.fromJson(doc.data());
  //       chapter.numberOfChapter= i;
  //       i++;
  //       return chapter;
  //     } ).toList();
  //     return chapters[idChapter-1];
  //   }
  //   catch(err){
  //   }
  //   return null;
  // }
  Future<int> comment(Comment comment,String idBook) async{
    var user=FirebaseAuth.instance.currentUser;
    if(user.email==null) return 0;
    comment.user= user.email;
    comment.timestamp = DateTime.now().millisecondsSinceEpoch;
    Map<String,dynamic> data=comment.toJson();
    try{
      List<Comment> comments= await getComments(idBook);
      if(comments==null)
        comments =[];
      comments.add(comment);
      var data= comments.map((e) => e.toJson()).toList();
      await firebase.collection('books').doc(idBook).update({"comments":data})
          .catchError((onError){
        print(onError.message);
      });
    }
    catch(err){
      print(err.message);
      return 2;
    }
    return 1;
  }
  Future<List<Comment>> getComments(String idBook)async{
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    var user=FirebaseAuth.instance.currentUser;
    if(user.email==null) return null;
    try{
      DocumentSnapshot documentSnapshot= await firebase.collection('books').doc(idBook).get();
      var data = documentSnapshot.data();
      Book book= Book.fromJson(data);
      return book.comments;
    }
    catch(err){
    }
    return null;
  }

}
