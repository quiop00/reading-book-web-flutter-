import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/ui/reading_page/reading_view.dart';

class ChapterList extends StatefulWidget{
  final Book book;
  ChapterList({this.book});
  @override
  State<StatefulWidget> createState() {
    return _ChapterList(book: book);
  }
}
class _ChapterList extends State<ChapterList>{
  final Book book;
  _ChapterList({this.book});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width*0.8 / 3;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: (itemWidth / 30),
          children: book.chapters.map((e) => ChapterElement(chapter: e,id: book.id,)).toList(),
      ),
    );
  }

}
class ChapterElement extends StatelessWidget{
  final Chapter chapter;
  final String id;
  ChapterElement({this.chapter,this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white
        ),
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingView(chapter: chapter,id: id,)));
        },
        child: Text(chapter.title, style: TextStyle(color: Colors.black),),
      ),
    );
  }

}