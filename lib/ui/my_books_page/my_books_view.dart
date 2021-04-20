import 'package:flutter/material.dart';
import 'package:reading_book/ui/add_book_page/add_book_view.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/shared/drawer.dart';

class MyBookView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyBookView();
  }

}
class _MyBookView extends State<MyBookView>{
  var isHover;
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBookView()));
                  },
                  child: Text('Đăng truyện mới')
              ),
              Container(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Tên truyện')),
                      DataColumn(label: Text('Mô Tả')),
                      DataColumn(label: Text('    Action'))
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Đế bá')),
                        DataCell(
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text('Mô tả ở đây aaaaaaaaaaaaaaaaaaaaaaaaaaaa Mô tả ở đây Mô tả ở đây Mô tả ở đây Mô tả ở đâyMô tả ở đây',
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

                    ],
                  ),
                ),
              )
            ],

          )
        ),
      ),
    );
  }

}