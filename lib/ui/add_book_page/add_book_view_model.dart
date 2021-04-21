import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class AddBookModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  Book book;
  int response;
  AddBookModel();
  bool isBusy=false;
  addBook()async{
    isBusy =true;
    await _api.addBook(book).then((value) {
      print(value);
      response =value;
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
    isBusy =false;
    notifyListeners();
  }
}