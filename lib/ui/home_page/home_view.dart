import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:reading_book/components/book_list.dart';
import 'package:reading_book/components/slide_bar.dart';
import 'package:reading_book/models/book.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:reading_book/ui/home_page/home_view_model.dart';
import 'package:reading_book/ui/shared/drawer.dart';
import 'package:reading_book/utils/helper.dart';
class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeView();
  }
}
class _HomeView extends State<HomeView>{
  List<Book> books;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks();
  }
  getBooks()async{
    books= await locator<FirebaseService>().getBooks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
          title: Text('Thư viện của tôi'),
      ),
      body: Container(
        color:Color.fromRGBO(246, 246, 246,0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                      height: 6+MediaQuery.of(context).size.height*0.06,
                  )
                ),
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.04,
                    color: Color.fromARGB(255,49,243,208),
                  ),
                ),
                Positioned(
                  top:5,
                  left: MediaQuery.of(context).size.width*0.15,
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchView()));
                       },
                      child: Container(
                          padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width*0.7,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(
                            color:Colors.white,
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
                          child: Row(
                            children: [
                              Icon(Icons.search,size: 18,),
                              SizedBox(width: 5,),
                              Text("Tìm truyện",style: TextStyle(fontSize: 18),)
                            ],
                            )
                       ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              child: Text("Truyện hay")
                          ),
                          Flexible(
                            child: ViewModelProvider<HomeViewModel>.withConsumer(
                                builder:(context,model,child)=>books==null?Container():BookList(books: books,),
                                viewModelBuilder: ()=>HomeViewModel(),
                                onModelReady: (model)=>
                                  model.getBooks(onLoading:(){
                                    Helpers.onLoading(context);
                                  },onSuccess:(){
                                    Navigator.of(context).pop();
                                    books = model.books;
                                  }
                            )
                          ),
                          )
                        ],
                      ),
                  ),
                  // Expanded(
                  //     child: SlideBar()
                  // )
                ],
              ),
            ),
            
          ]
        ),
      )
    );
  }
}
