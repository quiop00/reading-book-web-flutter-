import 'package:image_picker/image_picker.dart';
import 'package:provider_architecture/_base_viewmodels.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class AddBookModel extends BaseViewModel{
  final _api=locator<FirebaseService>();
  Book book;
  int response;
  String imagePath="https://firebasestorage.googleapis.com/v0/b/reading-book-flutter.appspot.com/o/images%2Fdefault.jpg?alt=media&token=e9590c7a-8a71-4af8-8d83-0df94cfa6f03";
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
  uploadFile(PickedFile file)async {
    final dateTime = DateTime.now();
    final path = '$dateTime';
    if (file == null) {
      return;
    }
    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .refFromURL("gs://reading-book-flutter.appspot.com")
        .child('/images/${path}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    uploadTask =ref.putData(await file.readAsBytes(), metadata);
    await uploadTask.whenComplete(() async{
      imagePath= await ref.getDownloadURL();
    });
    notifyListeners();
  }
}