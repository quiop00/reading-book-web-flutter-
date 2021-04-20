import 'package:flutter/material.dart';

class SlideBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SlideBar();
  }
}
class _SlideBar extends State<SlideBar>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      padding: EdgeInsets.only(top: 34),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Thể loại'),
          SizedBox(height: 10,),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: ListView(
              children: [
                CategoryElement(category: 'Tiên hiệp',),
                CategoryElement(category: 'Kiếm hiệp',),
                CategoryElement(category: 'Huyền huyễn',),
                CategoryElement(category: 'Light novel',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class CategoryElement extends StatefulWidget{
  final String category;
  CategoryElement({this.category});
  @override
  State<StatefulWidget> createState() {
    return _CategoryElement(category: category);
  }

}
class _CategoryElement extends State<CategoryElement>{
  final category;
  bool isHover=false;
  _CategoryElement({this.category});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 40,
        color: isHover?Colors.blueAccent:Colors.white,
        child: Card(
          child: Column(
            children: [
              Text(category),
            ],
          ),
        ),
      ),
      onTap: (){

      },
      onHover: (hover){
        setState(() {
          isHover=hover;
        });
      },
    );
  }

}