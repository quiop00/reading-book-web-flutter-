import 'package:flutter/material.dart';

class AddBookView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddBookView();
  }
}
class _AddBookView extends State<AddBookView>{
  TextEditingController _name=TextEditingController();
  TextEditingController _description=TextEditingController();
  TextEditingController _numChapter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                width: MediaQuery.of(context).size.width-40,
                height: MediaQuery.of(context).size.height*0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:[
                     BoxShadow(
                         offset: const Offset(0,1),
                         color: Colors.grey.withOpacity(0.2),
                         spreadRadius: 2,
                         blurRadius: 2
                    )
                  ]
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'tên truyện',
                      ),
                    ),
                    TextField(
                      controller: _numChapter,
                      decoration: InputDecoration(
                        hintText: 'Chapter',
                      ) ,
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          minLines: 30,
                          maxLines: 40,
                          controller: _description,
                          decoration: InputDecoration(
                            hintText: 'Mô tả',
                            border: OutlineInputBorder()
                        ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255,49,243,208),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 2, // blur radius
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Center(
                          child: Text('Đăng truyện', style: TextStyle(fontSize: 15,color: Colors.white),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
        ),
      ),
    );
  }

}