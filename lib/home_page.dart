import 'package:PayFace/dashboard.dart';
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
          backgroundImage: AssetImage('asset/welcome.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome (Nama User)',
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
    );
//Body 
    final body = Stack( 
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent]
            ),
        ),
      child: Column(
        children: <Widget>[gambar, welcome, lorem],
      ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: tombolNext,
        )
      ],
    );


    return Scaffold(
     
      body: body,
    );
  }
}