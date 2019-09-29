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
          new IconButton(icon: const Icon(Icons.save),
          onPressed: () {}) //<-Di isi
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              new DropDownField(
                value: null,
                icon: Icon(Icons.credit_card),
                required: true,
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
              new ListTile(
                leading: const Icon(Icons.credit_card),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Masukan Nomor Rekening Anda'
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 150)),
              new RaisedButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: Text('Top Up',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)

                ),
              ),
            ),
              new RaisedButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: Text('Konfirmasi Top Up',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)

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