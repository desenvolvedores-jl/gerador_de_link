import 'package:flutter/material.dart';
import 'package:link_generate/screen/home_page.dart';

void main(){
  runApp(MaterialApp(
    title: "Gerador de link whtasApp",
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
        primaryColor: Colors.green,
    ),
  ));
}