import 'package:flutter/material.dart';

class IntroductionView extends StatelessWidget{
  final String introduction;
  IntroductionView({this.introduction});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
      child: Text(introduction),
    );
  }

}