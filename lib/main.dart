import 'package:PayFace/register.dart';
import 'package:PayFace/topup.dart';
import 'package:flutter/material.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'login.dart';
import 'home_page.dart';
//import 'dashboard.dart';
import 'dashboard_v2.dart';
import 'profil.dart';
import 'register.dart';
import 'kirim.dart';
//import 'kirim_v2.dart';
import 'topup.dart';
//mport 'history.dart';
import 'history2.dart';
//import 'cognitive_face_flutter.dart';
import 'kamera_profil.dart';
import 'kamera_bayar.dart';
import 'pin.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
=======
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

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
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
<<<<<<< HEAD
    KameraPage.tag: (context) => KameraPage(),
    KameraBayarPage.tag: (context) => KameraBayarPage(),
    PinPage.tag: (context) => PinPage(),
  };

=======


  };
  
  
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayFace',
<<<<<<< HEAD
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
=======
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
      home: LoginPage(),
      routes: routes,
    );
  }
}