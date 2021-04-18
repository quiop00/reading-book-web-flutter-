import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reading_book/models/book.dart';
class FirebaseService{
  var  firebase = FirebaseFirestore.instance;

  // ignore: missing_return
  Future<DocumentReference> addBooks()async{
   // Map<String,dynamic> data=book.toJson();
    var datas={
      'name':'de ba',
      'author':'hoang duc',
      'chapters': [{
        'title':'Chapter 1',
        'content': 'Chap 1',
        'numberOfChapter': 1
      }]
    };
    try{
        await firebase.collection('books').add(datas);
    }
    catch(err){
        print(err.message);

    }
  }
  Future<DocumentReference> getBooks()async{
    if(firebase==null)
      firebase = FirebaseFirestore.instance;
    try{
        var data= await firebase.collection('books').get();
        // if(data!=null)
        //    for(var i in data){
        //
        //    }
        // for()
        print(data);
    }
    catch(err){

    }
  }

}
