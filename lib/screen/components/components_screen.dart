import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buidTextForm(TextEditingController controller,
       String label, String hint, TextInputType textInputType,
       TextInputAction textInputAction){
  return TextFormField(
  controller: controller,
  keyboardType: textInputType,
  style: TextStyle(
    color: Colors.white
  ),
    decoration: InputDecoration( 
     labelText: label, 
     labelStyle: TextStyle(
       color: Colors.white,
     ),
     hintText: hint),
     textInputAction: textInputAction,
    );
}

Widget listVazia(){
  return Column(
    children: <Widget>[
      SizedBox(height: 40),
      SvgPicture.asset("images/link.svg", height: 180, width: 180,),
      SizedBox(height: 20),
      Text("Nenhum link gerado!", style: TextStyle(fontSize: 18, color: Colors.black54),),
    ],
  );
}
