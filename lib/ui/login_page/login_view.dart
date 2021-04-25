import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_book/services/firebase_service.dart';
import 'package:reading_book/services/locator_getit.dart';
import 'package:reading_book/ui/home_page/home_view.dart';
import 'package:reading_book/ui/register_page/register_view.dart';

class LoginView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginView();
  }
}
class _LoginView extends State<LoginView>{

  final FirebaseService fb= locator<FirebaseService>();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController rePassword=TextEditingController();
  String _email;
  String _password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
        backgroundColor: Color.fromARGB(255,49,243,208),
      ),
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
              left:MediaQuery.of(context).size.width*0.25,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.28,
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
                              return 'Enter your email';
                            // ignore: missing_return
                            }
                            return null;
                          },
                          onSaved: (input)=>_email=input,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            suffixIcon: Icon(Icons.visibility,color: Color.fromARGB(255,49,243,208),),
                          ),
                          obscureText: true,
                          validator: (input){
                            if(input.length==0){
                              return 'Enter your password';
                              // ignore: missing_return
                            }
                            return null;
                          },
                          onSaved: (input)=>_password=input,
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*(0.28+0.28)*0.95,
            left: MediaQuery.of(context).size.width*0.35,
            child: Container(
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
                onTap: (){checkLogin();},
                child: Center(
                  child: Text('Đăng nhập', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*(0.28+0.28)*0.95+60,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Hoặc',style: TextStyle(fontSize: 15,color: Colors.black54)),
                ),
              )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*(0.28+0.28)*0.95+80,
            left: MediaQuery.of(context).size.width*0.35,
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/register");
              },
              child: Container(
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
                child: Center(
                  child: Text('Đăng ký', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  checkAuth()async{
    firebaseAuth.authStateChanges().listen((user) {
      if(user!=null){
        Navigator.pushNamed(context, "/home");
      }
    });
  }
  Future<void> checkLogin()async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
    }
    if(email.text.isEmpty||password.text.isEmpty)
    {
      return;
    }
    try{
      var result= await firebaseAuth.signInWithEmailAndPassword(email: _email, password: _password);
      var user;
      if(result!=null)
         user= result.user;
      if(user!=null){
        Navigator.pushNamed(context, "/home");
      }
    }
    catch(err){
      authProblems errorType;
        switch (err.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
          default:
            print('Case ${err.message} is not yet implemented');
        }
      print('The error is $errorType');
        showError(errorType.toString());
      }

    }
  showError(String error){
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text('Error'),
              content: Text(error),
              actions: [
                TextButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('OK'))
              ],
            )
    );
  }
}
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }