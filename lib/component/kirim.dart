import 'package:flutter/material.dart';
import 'package:PayFace/bloc/kirim/kirim_bloc.dart';
import 'package:PayFace/bloc/kirim/kirim_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_bloc.dart';
import 'package:PayFace/component/kamera_bayar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_bloc.dart';
import 'package:PayFace/component/konfirmasi.dart';

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
  /*final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  
  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);*/
  bool _pinned = true;
  bool _snap = false;
  bool _floating =  false;
  String _jumlah;
  
  KirimBloc _kirimBloc;
  String _password;
  int _jumlah_transfer;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  KameraBayarBloc kameraBayarBloc;

  @override
  Widget build(BuildContext context) {
    _kirimBloc = BlocProvider.of<KirimBloc>(context);
    return BlocBuilder<KirimBloc, KirimState>(
      bloc: _kirimBloc,
      builder: (context, state){
        final pageKirim = Column(
          children: <Widget>[
            SizedBox(height: 8,),
            // Jumlah Transfer
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
                onSaved: (value) => _jumlah_transfer = value, 
                key: Key('JumlahTransfer'),
                //onSaved: (String value) => this._jumlah = value,
              ),
              //onSaved: (String value) => this._jumlah = value,
            ),
            SizedBox(height: 8,),
            // Password Akun
            Padding(
              padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Password akun anda',
                  suffixStyle: TextStyle(color: Colors.green),
                  fillColor: Colors.white30,
                  icon:Icon(Icons.keyboard),
                ),
                maxLines: 1,
                maxLength: 8,
                obscureText: true,
                onSaved: (value) => _password = value, 
                key: Key('password'),
                //onSaved: (String value) => this._jumlah = value,
              ),
            ),
            SizedBox(height: 8,),
            // Button Bantuan
            Padding(
              padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: new RaisedButton(
                elevation: 0,
                color: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () => _sendDataTransfer(),
                child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                  width: double.infinity,
                  child: Text('Bantuan',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(32)
                  ),
                ),
              ),
            ),
          ]
        );
        
        final pageFormKirim = Form(
          key: _formKey,
          child: pageKirim,
        );

        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: _loadKameraBayarPage,
              label: Text('Scan Wajah'),
              icon: Icon(Icons.camera),
              backgroundColor: Colors.orange,
          ),  
          appBar: new AppBar(
            title: const Text('Trasfer'),
            actions: <Widget>[
              new IconButton(icon: const Icon(Icons.send),
              onPressed: () {

              }) //<-Di isi
            ],
          ),
          body: SingleChildScrollView(
            child: pageFormKirim,
          ),
        );
      }
    );
  }
  
  bool _validateDanSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  void _sendDataTransfer() async{
    if(_validateDanSave()){
      var pref = await SharedPreferences.getInstance();
      pref.setInt('jumlah_transfer', _jumlah_transfer);  
      pref.setString('password', _password); 
      _loadKonfirmasiPage();
    }  
  }

  void _loadKonfirmasiPage() {
      Navigator.push(context, 
        MaterialPageRoute(
          builder: (context){
            return BlocProvider<KonfirmasiBloc>(
              builder: (context) {
                return KonfirmasiBloc(authBloc: BlocProvider.of<AuthBloc>(context),
                userRepo: kameraBayarBloc.userRepo,
                );
              },
              child: KonfirmasiPage(),
            );
          }
        )
      );
    }
  
  void _loadKameraBayarPage() {
    Navigator.push(context, 
        MaterialPageRoute(builder: (context){
          return BlocProvider<KameraBayarBloc>(
            builder: (context) {
              return KameraBayarBloc(authBloc: BlocProvider.of<AuthBloc>(context),
              userRepo: _kirimBloc.userRepo,
              );
            },
            child: KameraBayarPage(),

          );
        })
    );
  }
} 