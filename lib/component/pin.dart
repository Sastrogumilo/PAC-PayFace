import 'package:PayFace/component/dashboard_v2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:PayFace/bloc/pin/pin_bloc.dart';
import 'package:PayFace/bloc/pin/pin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/home/dashboard_bloc.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  PinBloc pinBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password;

   String _validasiNama(String value)
  {
    if(value.isEmpty)return 'Isian Tidak Boleh Kosong';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if(!nameExp.hasMatch(value))return 'Hanya bisa memasukan huruf dan angka';
    return null;
  }
  

  @override
  Widget build(BuildContext context) {
    
    pinBloc = BlocProvider.of<PinBloc>(context);
    return BlocBuilder<PinBloc, PinState>(
      bloc: pinBloc,
      builder: (context, state){

    return Scaffold(
      appBar: new AppBar(
        title: const Text('Otentifikasi Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
        child: new Column(
          children: <Widget>[
              new ListTile( //<--------Nama
                leading: const Icon(Icons.confirmation_number),
                title: new TextFormField(
                  obscureText: true,  
                    key: Key('Password'),
                    onSaved: (value) => _password = value,
                    validator: _validasiNama,
                  decoration: new InputDecoration(
                    hintText: "Masukan Password Anda"
                    
                  ),
                ),
              ),
              const Divider(height: 320),
              new RaisedButton(
                onPressed: () {
                  //_loadHomePage();
                  authPassword();
                }, //<- Diisi
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
    ));
  });}

  void _loadHomePage() {
  Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<DashBoardBloc>(
          builder: (context) {
            return DashBoardBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo:   pinBloc.userRepo,
            );
          },
          child: DashBoardPage(),

        );
      }
      )
    );
  }

  void authPassword() async {
    String password;
    final FormState form = _formKey.currentState;
    form.save();
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    password = pref.getString('password');

    if (password == _password){
      print("$password");
      Fluttertoast.showToast(
            msg: 'Transaksi Berhasil',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white
          );
      new Future.delayed(const Duration(seconds: 3), () => _loadHomePage());     

    }else{
          Fluttertoast.showToast(
            msg: 'Password Salah',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
          );      
    }


  }
}