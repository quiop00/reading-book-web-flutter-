import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class MyBookViewModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  List<Book> books;
  VoidCallback onSuccess;
  getMyBooks({VoidCallback onSuccess})async{
    await _api.getMyBooks().then((value){
         books= value;
         this.onSuccess=onSuccess;
         notifyListeners();
      }).onError((error, stackTrace){
      print(error.message);
    });
  }
}