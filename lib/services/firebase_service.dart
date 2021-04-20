import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
class FirebaseService{
  var  firebase = FirebaseFirestore.instance;


  Future<int> addBooks(Book book)async{
   var user=FirebaseAuth.instance.currentUser;
   print(user.email);
   if(user.email==null) return 2;
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
    Map<String,dynamic> data=chapter.toJson();
    try{
      await firebase.collection('books').doc(idBook).collection("chapters").add(data)
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
