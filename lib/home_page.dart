<<<<<<< HEAD
//import 'package:PayFace/dashboard.dart';
import 'package:PayFace/dashboard_v2.dart';
=======
import 'package:PayFace/dashboard.dart';
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
import 'package:flutter/material.dart';
//import 'package:PayFace/dashboard.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final gambar = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
<<<<<<< HEAD
          backgroundImage: AssetImage('asset/images/welcome.png'),
=======
          backgroundImage: AssetImage('asset/welcome.png'),
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
<<<<<<< HEAD
        'Welcome',
=======
        'Welcome (Nama User)',
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Ini halaman Welcome.',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final tombolNext = Padding(
<<<<<<< HEAD
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Material(
            child: MaterialButton(
              minWidth: 20,
              height: 48,
              onPressed: () {Navigator.of(context).pushNamed(DashBoardPage.tag);},
              color: Colors.lightGreen,
              child: Text('Selanjutnya', style: TextStyle(color: Colors.white),),
            ),
         ),
=======
          padding: EdgeInsets.symmetric(vertical: 20),
           child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightBlueAccent.shade100,
            elevation: 5.0,
              child: MaterialButton(
                minWidth: 20,
                onPressed: () {Navigator.of(context).pushNamed(DashBoardPage.tag);},
                color: Colors.lightGreen,
                child: Text('Selanjutnya', style: TextStyle(color: Colors.white),),
              ),
           ),
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
    );
//Body 
    final body = Stack( 
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width,
<<<<<<< HEAD
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent]
            ),
          ),
          child: Column(
            children: <Widget>[gambar, welcome, lorem],
          ),
=======
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent]
            ),
        ),
      child: Column(
        children: <Widget>[gambar, welcome, lorem],
      ),
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: tombolNext,
        )
      ],
    );

<<<<<<< HEAD
    return Scaffold(body: body);
=======

    return Scaffold(
     
      body: body,
    );
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
  }
}