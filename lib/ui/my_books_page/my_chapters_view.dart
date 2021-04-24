import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:reading_book/ui/add_book_page/add_chapter_view.dart';
import 'package:reading_book/ui/chapter_page/chapter_view_model.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/my_books_page/my_books_view_model.dart';
import 'package:reading_book/ui/shared/drawer.dart';

import 'my_books_view.dart';
import 'my_chapters_view_model.dart';

class MyChapterView extends StatefulWidget{
  final idBook;
  MyChapterView({this.idBook});
  @override
  State<StatefulWidget> createState() {
    return _MyChapterView(idBook: idBook);
  }

}
class _MyChapterView extends State<MyChapterView>{
  var isHover;
  final idBook;
  _MyChapterView({this.idBook});
  List<Chapter> chapters;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHover=false;
  }
  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size.width*0.1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Thư viện của tôi'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height*0.9,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)
                                )
                            )
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookView()));
                        },
                        child: Text('Back')
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)
                                )
                            )
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddChapterView(idBook: idBook,)));
                        },
                        child: Text('Đăng chapter mới')
                    )
                  ],
                )
                ,
                ViewModelProvider<MyChapterViewModel>.withConsumer(
                  viewModelBuilder: ()=>MyChapterViewModel(),
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
                    return
                    Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Tên chapter')),
                          DataColumn(label: Text('Mô Tả')),
                          DataColumn(label: Text('    Action'))
                        ],
                        rows:
                          chapters!=null?
                          chapters?.map((e) =>
                              DataRow(cells: [
                                DataCell(Text(e.title)),
                                DataCell(
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text(e.content,
                                        maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    )

                                ),
                                DataCell(
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        IconButton(
                                          icon:Icon(Icons.edit),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
                                          },
                                        ),
                                        SizedBox(width: 2,),
                                        IconButton(
                                          icon:Icon(Icons.delete),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
                                          },
                                        )
                                      ],
                                    )
                                )
                              ]),
                          )?.toList()
                          : [
                            DataRow(cells: [
                              DataCell(Text('')),
                              DataCell(
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    child: Text('',
                                      maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  )
                              ),
                              DataCell(Text('')),
                            ])
                          ]
                      ),
                    ),
                  );
                  }
                )
              ],

            )
        ),
      ),
    );
  }


}