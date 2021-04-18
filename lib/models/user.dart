class User{
  String username;
  String password;
  User({this.username,this.password});
  factory User.fromJson(Map<String,dynamic> json){
    return User(
      username: json['username'],
      password: json['password']
    );
  }
  Map<String,dynamic> toJson()=>
      <String,dynamic>{
        'username':this.username,
        'password':this.password
      };
}