import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
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
      print(idBook);
      List<Chapter> chapters= await getChapters(idBook);
      if(chapters==null)
        chapters =[];
      chapters.add(chapter);
      var data= chapters.map((e) => e.toJson()).toList();
      await firebase.collection('books').doc(idBook).update({"chapter":data});
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
        print(snapshot);
        books = snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList();
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
    print(user.email);
    try{
      QuerySnapshot snapshot= await firebase.collection('books').get();
      books = snapshot.docs.map((doc) {
        print(doc.data());
        var book= Book.fromJson(doc.data());
        print(book.author);
        book.id= doc.id;
        return book;
      } ).toList();
      books= books.where((element) => element.author==user.email).toList();
      print(books.length);
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
    if(user.email==null) return null;
    try{
      DocumentSnapshot documentSnapshot= await firebase.collection('books').doc(idBook).get();
      var data = documentSnapshot.data();
      Book book= Book.fromJson(data);
      return book.chapters;
    }
    catch(err){
    }
    return null;
  }



}
