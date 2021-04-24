import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/login_page/login_view.dart';
import 'package:reading_book/ui/my_books_page/my_books_view.dart';

class DrawerWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DrawerWidget();
  }
}
class _DrawerWidget extends State<DrawerWidget>{
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  var data;
  bool isLogin=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStatusLogin();
  }
  initStatusLogin()async{
    data= await firebaseAuth.currentUser;
    print(data.email);
    if(data!=null)
       setState(() {
         isLogin=true;
       });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children:[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Book life',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Trang chủ"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            isLogin?ListTile(
              leading: Icon(Icons.book),
              title: Text("Truyện của tôi"),
              onTap: () {
                Navigator.pushNamed(context,'/my-book');
              },
            ):SizedBox(height: 1,),
            isLogin?ListTile(
              leading: Icon(Icons.logout),
              title: Text("Đăng xuất"),
              onTap: () {
                setState(() {
                  firebaseAuth.signOut();
                  isLogin=false;
                });
              },
            ):ListTile(
              leading: Icon(Icons.login),
              title: Text("Đăng nhập"),
              onTap: () {
                Navigator.pushNamed(context,'/login');
              },
            ),
          ]

      ),
    );
  }

}