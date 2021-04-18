import 'package:provider_architecture/provider_architecture.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';

class HomeViewModel extends BaseViewModel{
  final _api=locator<FirebaseService>();


}