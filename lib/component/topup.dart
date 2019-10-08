import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:PayFace/component/kamera_profil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/topup/topUp_bloc.dart';
import 'package:PayFace/bloc/topup/topUp_state.dart';


class TopUpPage extends StatefulWidget {
  static String tag = 'topup-page';
  @override 
  _TopUpPageState createState() => _TopUpPageState();

}

class _TopUpPageState extends State<TopUpPage> {
  // variabel bloc topup
  TopUpBloc topUpBloc;

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
    topUpBloc = BlocProvider.of<TopUpBloc>(context);
    return BlocBuilder<TopUpBloc, TopUpState>(
      bloc: topUpBloc,
      builder: (context, state){


    return Scaffold(
      appBar: new AppBar(
        title: const Text('Top Up'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.send),
          onPressed: () {}) //<-Di isi
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, KameraPage.tag),
        label: Text('Scan Wajah'),
        icon: Icon(Icons.camera),
        backgroundColor: Colors.orange,
      ),  
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            children: <Widget>[
              /*Padding(padding: EdgeInsets.symmetric(vertical: 12)),
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
              ),*/
              Padding(padding: EdgeInsets.symmetric(vertical: 12),),
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
              /*new RaisedButton(
                elevation: 0,
                color: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pushNamed(context, KameraPage.tag),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 3),),*/
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
  });
  }
}