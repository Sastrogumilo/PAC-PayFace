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

  final page_kirim = Column(
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
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.all(0),
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          width: double.infinity,
          child: Text('Scan Wajah',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(32)
          ),
        ),
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap:false,
            floating: false,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Transfer'),
              background: Image.asset(
                'asset/images/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverFillRemaining(child: page_kirim)
        ],
      ) 
    );
  }
}