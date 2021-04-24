import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/ui/reading_page/reading_view.dart';

import 'chapter_view_model.dart';

class ChaptersView extends StatefulWidget{
  final String idBook;
  ChaptersView({this.idBook});
  @override
  State<StatefulWidget> createState() {
    return _ChaptersView(idBook: idBook);
  }
}
class _ChaptersView extends State<ChaptersView>{
  final String idBook;
  _ChaptersView({this.idBook});
  List<Chapter> chapters;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width*0.8 / 3;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    return ViewModelProvider<ChaptersViewModel>.withConsumer(
        viewModelBuilder: ()=>ChaptersViewModel(),
          onModelReady: (model)=>{
              model.getChapters(idBook,onSuccess: (){
              chapters=model.chapters;
            })
          },
          builder:(context,model,_){
            print(idBook);
            if(model.chapters==null)
              return Container(child: Text('No data'),);
            else
              chapters = model.chapters;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: (itemWidth / 30),
                children: chapters.map((e) => ChapterElement(chapter: e,id: idBook,)).toList(),
            ),
          );
      }
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