import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/ui/detail_page/detail_view.dart';

class BookList extends StatelessWidget{
  final List<Book> books;
  BookList({this.books});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width*0.8 / 3;
    return Container(
      //height: MediaQuery.of(context).size.height*0.8,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: (itemWidth / itemHeight),
          children: books.map((e) => BookListElement(book: e,)).toList(),
         ),
    );
  }
}
class BookListElement extends StatelessWidget{
  final Book book;
  BookListElement({this.book});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width*0.7 / 2;
    return Container(
      height: 100,
      width: 200,
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
                      image: NetworkImage(book.imagePath!=null?book.imagePath:"https://yesoffice.com.vn/wp-content/themes/zw-theme//assets/images/default.jpg"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Center(
                      child: Text(book.name, style: TextStyle(fontSize: 24),),
                    )
                  ),
                  Flexible(child:
                    Text(book.description,
                      maxLines: 4,overflow: TextOverflow.ellipsis,)
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.account_circle,color: Colors.grey,size: 12,),
                              SizedBox(width: 5,),
                              Text(book.author, style: TextStyle(fontSize: 12),),
                            ],
                          )),
                          SizedBox(width: 2,),
                          Expanded(
                            child: Container(
                              width: itemWidth*0.1,
                              height: 25,
                              padding: EdgeInsets.only(right: 5,bottom: 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ElevatedButton(
                                onPressed:(){
                                  print(book.name+" a");
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailBook(book:book)));
                                },
                                child: Center(child: Text('Đọc')),
                              ),
                            ),
                          )
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
    );
  }

}