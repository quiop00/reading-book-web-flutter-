import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class AddChapterModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  Chapter chapter;
  int response;
  AddChapterModel();
  bool isBusy=false;
  addChapter(String idBook)async{
    isBusy =true;
    await _api.addChapters(chapter,idBook).then((value) {
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