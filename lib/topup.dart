import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';


class TopUpPage extends StatefulWidget {
  static String tag = 'topup-page';
  @override 
  _TopUpPageState createState() => _TopUpPageState();

}


class _TopUpPageState extends State<TopUpPage> {

  //final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;
  List<String> bank = [
    'BRI', 
    'BNI',
    'BCA',
    'BTN',
    'DLL'
  ];
  List<String> nominal = [
    '20.000',
    '50.000',
    '100.000',
    '500.000',
    '1.000.000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Top Up'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.send),
          onPressed: () {}) //<-Di isi
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              new DropDownField(
                value: 'Bank *',
                icon: Icon(Icons.credit_card),
                required: true,
                strict: false,
                hintText: 'Pilih Bank',
                items: bank,
                setter: (dynamic newValueBank) {
                  formData['Bank'] = newValueBank;
                },
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8),),
              new DropDownField(
                value: null,
                icon: Icon(Icons.attach_money),
                required: true,
                hintText: 'Jumlah Nominal',
                items : nominal,
                setter: (dynamic newValue) {
                  formData['Nominal'] = newValue;
                },
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8),),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 3),),
              new RaisedButton(
                elevation: 0,
                color: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: double.infinity,
                  child: Text('Bukti Upload',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(32)
                  ),
                ),
              ),
            ]
          )
        )
      ),
    );
  }

}