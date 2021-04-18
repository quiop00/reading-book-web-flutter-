import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/login_page/login_view.dart';

class RegisterView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegisterView();
  }

}
class _RegisterView extends State<RegisterView>{
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController rePassword=TextEditingController();
  String _email;
  String _password;
  String _rePass;
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FirebaseApp app;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height-20,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              )
          ),
          Positioned(
            top:0,
            child: Container(
              height: MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255,49,243,208),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Light Novel',style: TextStyle(fontSize: 35,color: Colors.white),),
                  Text('chia sẻ tri thức - xây dựng tương lai',style: TextStyle(fontSize: 15,color: Colors.white),)
                ],
              ),
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.28,
              left:20,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                width: MediaQuery.of(context).size.width-40,
                height: MediaQuery.of(context).size.height*0.4,
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
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              suffixIcon: Icon(Icons.email_outlined,color: Color.fromARGB(255,49,243,208),)
                          ),
                          validator: (input){
                            if(input.length==0){
                              return 'Nhập email';
                              // ignore: missing_return
                            }
                            return null;
                          },
                          onSaved: (value)=>_email=value,

                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            suffixIcon: Icon(Icons.visibility,color: Color.fromARGB(255,49,243,208),),
                          ),
                          obscureText: true,
                          validator: (input){
                            if(input.isEmpty){
                              return 'Nhập mật khẩu';
                              // ignore: missing_return
                            }
                            return null;
                          },
                          onSaved: (value)=>_password=value,
                        ),
                        TextFormField(
                          controller: rePassword,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            suffixIcon: Icon(Icons.visibility,color: Color.fromARGB(255,49,243,208),),
                          ),
                          obscureText: true,
                          validator: (input) {
                            if (input != password.text) {
                              return 'Mật khẩu không khớp';
                              // ignore: missing_return
                            }
                            return null;
                          },
                          onSaved: (value)=>_rePass=value,
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*(0.28+0.4)*0.95,
            left: MediaQuery.of(context).size.width*0.25,
            child: Container(
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
                onTap: (){register();},
                child: Center(
                  child: Text('Đăng kí', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  Future<void> register()async{
    // try{
      print(email.text +' '+ password.text);
      if(_formKey.currentState.validate()){
        _formKey.currentState.save();
      }
      print('here');
      if(email.text.isEmpty||password.text.isEmpty||rePassword.text.isEmpty)
        {
          return;
        }
      if(password.text!=rePassword.text)
        {
          return;
        }
      var success=true;
      app = await Firebase.initializeApp(
            name: 'Secondary', options: Firebase.app().options);
      try{
        await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: email.text, password: password.text);
      }
      catch(onError){
        var errorType;
        print(onError.code);
        switch (onError.code) {
          case 'app/app-deleted':
            break;
          default:
            print('Case ${onError.message} is not yet implemented');
        }
        print('The error is $errorType');
        if(!success)
        showMessage(onError.message);
      }
      await app.delete();
      if(success)
      showDialog(
          context: context,
          builder: (context)=>
              AlertDialog(
                title: Text('Đăng kí thành công'),
                content: Text('Đăng kí thành công, quay lại trang đăng nhập'),
                actions: [
                  TextButton(
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView())),
                      child: Text('OK'))
                ],
              )
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