import 'package:flutter/material.dart';

class ColorPalete {
  static const backgroundColor = Color(0xff0066ff) ;
  static const backgroundColorDark = Color(0xff67b1);
  static const underLineTextInput = Color(0xffabbadb);
  static const hintInput = Color(0xfffff);
}

class KirimPage extends StatefulWidget {
  static String tag = 'kirim-page';
  @override 
  _KirimPageState createState() => _KirimPageState();
  
}

class _KirimPageState extends State<KirimPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Transfer'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {}) //<-Di isi
        ],
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new ListTile( //<--------Nama
              leading: const Icon(Icons.email),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "Masukan Email Yang Akan Dikirim"
                ),
              ),
            ),

            new ListTile( //<-------- Email
              leading: const Icon(Icons.attach_money),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: 'Masukan Nomial Yang Akan Ditransfer'
                ),
              ),
            ),
            const Divider(height: 400),
            new RaisedButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: Text('Scan Wajah',
                style: TextStyle(
                    color: Colors.white),
                    textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
                )
              )
            )
          ]
        )
      )
    );
  }
}