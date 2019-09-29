import 'package:PayFace/register.dart';
import 'package:PayFace/topup.dart';
import 'package:flutter/material.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'login.dart';
import 'home_page.dart';
import 'dashboard.dart';
import 'profil.dart';
import 'register.dart';
import 'kirim.dart';
import 'topup.dart';
import 'history2.dart';
import 'app_const.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  initParse();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    DashBoardPage.tag: (context) => DashBoardPage(),
    ProfilPage.tag: (context) => ProfilPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    KirimPage.tag: (context) => KirimPage(),
    TopUpPage.tag: (context) => TopUpPage(),
    //HistoryPage.tag: (context) => HistoryPage(),
    HistoryPage2.tag: (context) => HistoryPage2(),


  };
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayFace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      
      home: LoginPage(),
      routes: routes,
    );
  }
}