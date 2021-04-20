import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/models/chapter.dart';
import 'package:reading_book/ui/add_book_page/add_book_view_model.dart';
import 'package:reading_book/ui/add_book_page/add_chapter_view_model.dart';
import 'package:reading_book/ui/my_books_page/my_books_view.dart';
import 'package:reading_book/ui/shared/drawer.dart';

class AddBookView extends StatefulWidget{
  final String idBook;
  AddBookView({this.idBook});
  @override
  State<StatefulWidget> createState() {
    return _AddBookView(idBook: idBook);
  }
}
class _AddBookView extends State<AddBookView>{
  TextEditingController _title=TextEditingController();
  TextEditingController _content=TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TextEditingController _numChapter=TextEditingController();
  final String idBook;
  _AddBookView({this.idBook});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng truyện'),
      ),
      drawer: DrawerWidget(),
      body: ViewModelProvider<AddChapterModel>.withConsumer(
        viewModelBuilder: ()=>AddChapterModel(),
        builder:(context, model, _)=> Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20,top: 20),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _title,
                          decoration: InputDecoration(
                            hintText: 'Tên chapter',
                          ),
                          validator: (input){
                            if(input.isEmpty)
                              return 'Không được bỏ trống tên chapter';
                            return null;
                          },
                        ),
                        SizedBox(height:10),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              minLines: 30,
                              maxLines: 40,
                              controller: _content,
                              decoration: InputDecoration(
                                  hintText: 'Nội dung',
                                  border: OutlineInputBorder()
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            model.isBusy
                                ? CircularProgressIndicator()
                                :Container(
                              width: MediaQuery.of(context).size.width*0.3,
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
                                onTap: ()async{
                                  if(_formKey.currentState.validate()){
                                    _formKey.currentState.save();
                                  }
                                  if(_title.text.isEmpty)
                                    return;
                                  if(_content.text.isEmpty){
                                    showMessage('Không được bỏ trống nội dung');
                                    return;
                                  }
                                  model.chapter = Chapter(
                                      title: _title.text,
                                      content: _content.text
                                  ) ;
                                  await model.addChapter(idBook);
                                  print(model.response);
                                  if(model.response!=1)
                                    showMessage('Đăng truyện thất bại');
                                  else Navigator.push(context, MaterialPageRoute(builder: (context)
                                  =>MyBookView())
                                  );

                                },
                                child: Center(
                                  child: Text('Đăng', style: TextStyle(fontSize: 15,color: Colors.white),),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
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
                                  child: Text('Hủy', style: TextStyle(fontSize: 15,color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showMessage(String error){
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text('Error'),
              content: Text(error+'.'),
              actions: [
                TextButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('OK'))
              ],
            )
    );
  }
}