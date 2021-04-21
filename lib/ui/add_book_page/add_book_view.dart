import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/ui/add_book_page/add_book_view_model.dart';
import 'package:reading_book/ui/my_books_page/my_books_view.dart';
import 'package:reading_book/ui/shared/drawer.dart';

class AddBookView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddBookView();
  }
}
class _AddBookView extends State<AddBookView>{
  TextEditingController _name=TextEditingController();
  TextEditingController _description=TextEditingController();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  var data;
  String author;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStatusLogin();
  }
  initStatusLogin()async{
    data= await firebaseAuth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng truyện'),
      ),
      drawer: DrawerWidget(),
      body: ViewModelProvider<AddBookModel>.withConsumer(
        viewModelBuilder: ()=>AddBookModel(),
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
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              hintText: 'tên truyện',
                            ),
                            validator: (input){
                              if(input.isEmpty)
                                return 'Không được bỏ trống tên truyện';
                              return null;
                            },
                          ),
                          SizedBox(height:10),
                          Expanded(
                            child: Container(
                              child: TextFormField(
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
                                     if(_name.text.isEmpty)
                                       return;
                                     model.book = Book(
                                       name: _name.text,
                                       description: _description.text.isEmpty?'Không có mô tả':_description.text
                                     ) ;
                                      await model.addBook();
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
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
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