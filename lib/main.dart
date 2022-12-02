import 'package:f1/ConectarDataBase.dart';
import 'package:f1/Home.dart';
import 'package:f1/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //home: Login(),
    //home: Home(),
    home: ConectarDataBase(),
    debugShowCheckedModeBanner: false,
  ));
}
