import 'dart:html';

import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class MyChapterViewModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  List<Chapter> chapters;
  VoidCallback onSuccess;
  getChapters(String idBook,{VoidCallback onSuccess})async{
    await _api.getChapters(idBook).then((value){
      chapters= value;
      this.onSuccess=onSuccess;
      notifyListeners();
    }).onError((error, stackTrace){
      print(error.message);
    });
  }
}