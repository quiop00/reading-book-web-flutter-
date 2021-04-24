import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/models/comment.dart';

class CommentWidget extends StatefulWidget{
  final String idBook;
  CommentWidget({this.idBook});
  @override
  State<StatefulWidget> createState() {
    return _CommentWidget(idBook: idBook);
  }
}
class _CommentWidget extends State<CommentWidget>{
  final String idBook;
  _CommentWidget({this.idBook});
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController _comment = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Container(
            child: Text('Bình luận',style: TextStyle(fontSize: 25),),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller:  _comment,
              decoration: InputDecoration(
                hintText: 'Nhập bình luận',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    if(user==null){
                      return ;
                    }
                    if(_comment.text!=null){
                      Comment comment = Comment(
                          user: user.email,
                          content: _comment.text,
                          timestamp: DateTime.now().millisecondsSinceEpoch
                      );
                      FirebaseFirestore.instance
                          .collection("books")
                          .doc(idBook)
                          .collection("comments")
                          .add(comment.toJson()
                      );
                      _comment.clear();
                    }

                  },
                )
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("books").doc(idBook).collection("comments").snapshots(),
                 builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        'No Comment...',
                      );
                    } else {
                      List<DocumentSnapshot> items = snapshot.data.docs;
                      if(items!=null){
                         List<Comment> comments = items.map((e) => Comment.fromJson(e.data())).toList();
                         return ListView.builder(
                             itemBuilder:(context,index)=>CommentElement(comment: comments[index],),
                             itemCount: comments.length,
                         );
                      }
                      return Container();
                    }
                }
              )
          )

        ],
      ),
    );
  }
}
class CommentElement extends StatelessWidget{
  final Comment comment;
  CommentElement({this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(comment.user),
                Text("${comment.timestamp}"),
              ],
            ),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(comment.content),
            )
          ],
        ),
      ),
    );
  }

}