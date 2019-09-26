import 'package:PayFace/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ColorPalete {
  static const backgroundColor = Color(0xff0066ff) ;
  static const backgroundColorDark = Color(0xff67b1);
  static const underLineTextInput = Color(0xffabbadb);
  static const hintInput = Color(0xfffff);
}

class PinPage extends StatefulWidget {
  static String tag = 'pin-page';
  @override 
  _PinPageState createState() => _PinPageState();
  
}

class _PinPageState extends State<PinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: new AppBar(
      title: const Text('Otentifikasi Pin'),
    ),
    
    body: SingleChildScrollView(
      child: new Column(
      children: <Widget>[
        
       
        new ListTile( //<--------Nama
          leading: const Icon(Icons.confirmation_number),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Masukan Pin Anda"
            ),
          ),
        ),

        const Divider(height: 400,
  ),
        new RaisedButton(
          onPressed: () {
            Fluttertoast.showToast(
              msg: 'Gambar Disimpan',
              
              toastLength: Toast.LENGTH_SHORT,
	
              gravity: ToastGravity.CENTER,
      
              timeInSecForIos: 1,
      
              backgroundColor: Colors.red,
      
              textColor: Colors.white
      
            );
            Navigator.of(context).pushNamed(DashBoardPage.tag);}, //<- Diisi
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Text('Enter',
            style: TextStyle(color: Colors.white),
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