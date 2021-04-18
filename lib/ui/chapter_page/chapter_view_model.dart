import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class ChapterViewModel extends BaseViewModel{
  final _api= locator<FirebaseService>();


}