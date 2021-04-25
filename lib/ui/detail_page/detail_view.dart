import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/components/chapter_list.dart';
import 'package:reading_book/components/comment.dart';
import 'package:reading_book/components/introduction.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/ui/chapter_page/chapter_view.dart';
import 'package:reading_book/ui/shared/drawer.dart';

class DetailBook extends StatefulWidget{
  final Book book;
  DetailBook({this.book});
  @override
  State<StatefulWidget> createState() {
    return _DetailBook(book: book);
  }
}
class _DetailBook extends State<DetailBook> with SingleTickerProviderStateMixin{
  final Book book;
  _DetailBook({this.book});
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24);
    final double itemWidth = size.width*0.71;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      drawer: DrawerWidget(),
      body: Container(
        height: MediaQuery.of(context).size.height*0.9,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 100),
            child: Column(
              children: [
              Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: itemWidth*0.28,
                      height: itemHeight*0.65,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(book.imagePath),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 40),
                              margin:EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(book.name, style: TextStyle(fontSize: 30),)
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 40),
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.account_circle,color: Colors.grey,size: 12,),
                                      SizedBox(width: 5,),
                                      Text(book.author),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20,left: 40),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: (){},
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                        child: Text('Đọc từ đầu')
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side: BorderSide(color: Colors.red)
                                            )
                                        )
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
             ),
              Divider(height: 1,),
              Container(
                height: 500,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width :MediaQuery.of(context).size.width*0.5,
                      child: TabBar(
                        tabs: [
                            Tab(child: Text('Giới thiệu',style: TextStyle(color: Colors.black),),), // you can specify pages here if you want
                            Tab(child: Text('Danh sách chương',style: TextStyle(color: Colors.black),),),
                            Tab(child: Text('Bình luận',style: TextStyle(color: Colors.black),),)
                          ],
                        controller: _tabController,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Flexible(
                      child: Container(

                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            IntroductionView(introduction: book.description,),
                            ChaptersView(idBook: book.id,),
                            CommentWidget(idBook:book.id)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }


}