import 'package:flutter/material.dart';
import 'package:reading_book/components/book_list.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:reading_book/ui/add_book_page/add_book_view.dart';
import 'package:reading_book/ui/detail_page/detail_view.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/login_page/login_view.dart';
import 'package:reading_book/ui/my_books_page/my_books_view.dart';
import 'package:reading_book/ui/register_page/register_view.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:'/home',
      routes: {
        '/home': (context)=>HomeView(),
        '/login': (context)=>LoginView(),
        '/register':(context)=>RegisterView(),
        '/detail':(context)=>DetailBook(),
        '/my-book':(context)=>MyBookView()
      },
      home: HomeView(),
    );
  }
}

