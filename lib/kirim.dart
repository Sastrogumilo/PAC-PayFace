import 'package:flutter/material.dart';
import 'package:PayFace/kamera_profil.dart';

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
  @override
  Widget build(BuildContext context) {
      final page_kirim = Column(
        children: <Widget>[
          SizedBox(height: 8,),
          Padding(
            padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                prefixText: '\Rp ',
                suffixText: 'RPH',
                labelText: 'Jumlah Uang',
                suffixStyle: TextStyle(color: Colors.green),
                fillColor: Colors.white30,
                icon:Icon(Icons.attach_money),
              ),
              maxLines: 1,
              keyboardType: TextInputType.number,
              //onSaved: (String value) => this._jumlah = value,
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'PIN anda',
                suffixStyle: TextStyle(color: Colors.green),
                fillColor: Colors.white30,
                icon:Icon(Icons.keyboard),
              ),
              maxLines: 1,
              keyboardType: TextInputType.number,
              //onSaved: (String value) => this._jumlah = value,
            ),
          ),
          /*new RaisedButton(
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
          ),*/
        ]
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, KameraPage.tag),
          label: Text('Scan Wajah'),
          icon: Icon(Icons.camera),
          backgroundColor: Colors.orange,
      ),  
      appBar: new AppBar(
        title: const Text('Trasfer'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.send),
          onPressed: () {}) //<-Di isi
        ],
      ),
      body: SingleChildScrollView(
        child: page_kirim,
      ),
    );
  }
} 