import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/components/comment.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/ui/shared/drawer.dart';

import 'reading_view_model.dart';

class ReadingView extends StatefulWidget{
  final Chapter chapter;
  final String id;
  ReadingView({this.chapter,this.id});
  @override
  State<StatefulWidget> createState() {
    return _ReadingView(chapter: chapter,id: id);
  }
}
class _ReadingView extends State<ReadingView>{
  final Chapter chapter;
  final String id;
  _ReadingView({this.chapter,this.id});
  var _widthComment;
  var _isExpanded;
  Chapter pre;
  Chapter next;
  bool hasNext;
  bool hasPre;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widthComment = 0;
    _isExpanded = false;
    hasNext=false;
    hasPre=false;
  }
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text('Đọc truyện'),
        ),
        body: Center(
           child: ViewModelProvider<ReadViewModel>.withConsumer(
                    viewModelBuilder: ()=>ReadViewModel(),
                    onModelReady: (model)=>{
                        model.getPreNextChapter(id,chapter.numberOfChapter,onSuccess: (){
                        pre = model.preChapter;
                        next=model.nextChapter;
                    })},
                    builder:(context,model,_) {
                      return
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width-60,
                          height: MediaQuery.of(context).size.height-40,
                          child: Row(
                              children:[
                                Container(
                                  width: MediaQuery.of(context).size.width-60-_widthComment,
                                  height: MediaQuery.of(context).size.height-40,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              child: Container(
                                                child: Text('Chương trước',style: TextStyle(fontSize: 30),),
                                              ),
                                              onPressed: model.preChapter!=null?(){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingView(chapter: model.preChapter,id: id,)));
                                              }:null,
                                            ),
                                            ElevatedButton(
                                              child: Container(
                                                child: Text('Chương sau',style: TextStyle(fontSize: 30),),
                                              ),
                                              onPressed: model.nextChapter!=null?(){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingView(chapter: model.nextChapter,id: id,)));
                                              }:null,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text(chapter.title,style: TextStyle(fontSize: 50),),
                                        Divider(height: 1,),
                                        SizedBox(height: 10,),
                                        Text(chapter.content,style: TextStyle(fontSize: 20)),
                                        SizedBox(height: 10,)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Visibility(
                                      visible: _isExpanded,
                                      child: Row(
                                          children: [
                                            VerticalDivider(width: 2,),
                                            Expanded(
                                              child: Container(
                                                  width: _widthComment,
                                                  height: MediaQuery.of(context).size.height-40,
                                                  child: CommentWidget(idBook: id,)
                                              ),
                                            ),
                                          ]
                                      ),
                                    )
                                )
                              ]
                          ),
                        );
                    }

          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.comment
          ),
          onPressed: (){
              setState(() {
                _widthComment = _isExpanded?0:MediaQuery.of(context).size.width*0.4;
                _isExpanded = !_isExpanded;
              });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
  }

}