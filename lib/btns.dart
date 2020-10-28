import 'package:flutter/material.dart';

class MyBtns extends StatelessWidget{
  var userQuestion;

  final color;
  final textColor;
  final String btnText;
  final btnTapped;

  MyBtns({this.color,this.textColor,this.btnText, this.btnTapped});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: btnTapped,
          child: Padding(
        padding:const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color:color,
            child: Center(
              child: Text(
                btnText,
                style: TextStyle(color:textColor,fontSize:20),
              ),
            ),
          )
        ),
      ),
    );
    //throw UnimplementedError();
  }
  
}