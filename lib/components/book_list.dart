import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width*0.8 / 2;
    return Container(
      //height: MediaQuery.of(context).size.height*0.8,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
             BookListElement(),
             BookListElement(),
             BookListElement(),
             BookListElement(),
             BookListElement(),
              ],
         ),
    );
  }
}
class BookListElement extends StatelessWidget{
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
                      image: NetworkImage("http://product.hstatic.net/1000219449/product/upload_20256996a8e04dab81373e98cf37d344_grande.jpg"),
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
                      child: Text("Cậu bé đeo tất xanh", style: TextStyle(fontSize: 30),),
                    )
                  ),
                  Flexible(child:
                    Text('Tại trong tan hoang quật khởi, tại trong tịch diệt khôi phục. Biển cả thành bụi, lôi điện khô kiệt, sợi u vụ kia lại một lần tới gần đại địa, thế gian gông xiềng được mở ra, một cái thế giới hoàn toàn mới như vậy để lộ một góc thần bí ',
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
                              Text('Nguyễn Văn An'),
                            ],
                          )),
                          Container(
                            width: itemWidth*0.1,
                            height: 25,
                            padding: EdgeInsets.only(right: 5,bottom: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ElevatedButton(
                              onPressed:(){},
                              child: Center(child: Text('Đọc')),
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