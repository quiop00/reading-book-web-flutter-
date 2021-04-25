import 'dart:html';

import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class ReadViewModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  Chapter nextChapter;
  Chapter preChapter;
  VoidCallback onSuccess;
  getPreNextChapter(String idBook,int idChapter,{VoidCallback onSuccess})async{
    await _api.getPreNextChapter(idBook,idChapter).then((value){
      nextChapter= value["next"];
      preChapter = value["prev"];
      this.onSuccess=onSuccess;
      notifyListeners();
    }).onError((error, stackTrace){
      print(error.message);
    });
  }
}