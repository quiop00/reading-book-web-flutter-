import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class HomeViewModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  List<Book> books;
  VoidCallback onSuccess;
  VoidCallback onLoading;
  VoidCallback onError;
  getBooks({VoidCallback onSuccess,
            VoidCallback onLoading,
            VoidCallback onError})async{
    await _api.getBooks().then((value){
      this.onLoading=onLoading;
      this.books=value;
      this.onSuccess=onSuccess;
      this.onError =onError;
      notifyListeners();
    }).catchError((err){
      print(err);
    });
  }

}