import 'package:PayFace/component/kamera_profil.dart';
import 'package:flutter/material.dart';
//import 'package:passwordfield/passwordfield.dart';
import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/datadiri/datadiri_bloc.dart';
import 'package:PayFace/bloc/datadiri/datadiri_state.dart';
import 'package:PayFace/bloc/kamera_profil/KameraProfil_bloc.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';


class ProfilPage extends StatefulWidget{
  static String tag = 'profil-tag';
  @override 
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwdFieldKey = new GlobalKey<FormFieldState<String>>();
  DataDiriBloc _dataDiriBloc;

  final format = DateFormat("yyyy-MM-dd");
  //DropDown Value
  Map<String, dynamic> formData;
  List<String> bank = [
    'BRI', 
    'BNI',
    'BCA',
    'BTN',
    'DLL'
  ];
  String _nama;
  String _email;
  String _notelp;
  String _passwd;
  String _username;
  String _norek;

  String _validasiNama(String value)
  {
    if(value.isEmpty)return 'Belum mengisi nama';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if(!nameExp.hasMatch(value))return 'Hanya bisa memasukan huruf dan angka';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _dataDiriBloc = BlocProvider.of<DataDiriBloc>(context);

    return BlocListener<DataDiriBloc, DataDiriState>(
      listener: (context, state) {
        if (state is DataDiriBerhasil) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<DataDiriBloc, DataDiriState>(
        bloc: _dataDiriBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: const Text('Edit Profil'),
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () => Navigator.pop(context)
                ) //<-Di isi
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: new Column(
                children: <Widget>[
                  // NAMA LENGKAP
                  SizedBox(height: 12,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.person),
                      hintText: "Siapa nama lengkap anda?",
                      labelText: "Nama Lengkap"
                    ),
                    onSaved: (String value) => this._nama = value,
                    validator: _validasiNama,
                  ),

                  // E-MAIL
                  SizedBox(height: 12,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.email),
                      hintText: "Email yang digunakan",
                      labelText: "E-mail"
                    ),
                    onSaved: (String value) => this._email = value,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // No Telp
                  SizedBox(height: 12,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.phone),
                      hintText: "No telepon yang digunakan",
                      labelText: "No Telepon: 08965454627"
                    ),
                    onSaved: (String value) => this._notelp = value,
                    keyboardType: TextInputType.phone,
                  ),
                  
                  // ALAMAT
                  SizedBox(height: 12,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.home),
                      hintText: "Alamat rumah anda",
                      labelText: "Alamat"
                    ),
                    maxLines: 3,
                  ),

                  // No Rekening
                  SizedBox(height: 12,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.supervised_user_circle),
                      hintText: "Nomer Rekening Bank Anda",
                      labelText: "No. Rekening"
                    ),
                    onSaved: (String value) => this._norek = value,
                    validator: _validasiNama,
                  ),

                  // USERNAME
                  SizedBox(height: 12,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.supervised_user_circle),
                      hintText: "Username yang diinginkan",
                      labelText: "Username"
                    ),
                    onSaved: (String value) => this._username = value,
                    validator: _validasiNama,
                  ),

                  // PASSWORD
                  SizedBox(height: 12,),
                  PasswordField(
                    fieldKey: _passwdFieldKey,
                    helperText: 'tidak lebih dari 8 karakter',
                    labelText: 'Password',
                    onFieldSubmitted: (String value){
                      setState(() {
                      this._passwd = value; 
                      });
                    },
                  ),

                  // RE-TYPE PASSWORD
                  SizedBox(height: 12,),
                  TextFormField(
                    enabled: this._passwd != null && this._passwd.isNotEmpty,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Re-type Password'
                    ),
                    maxLength: 8,
                    obscureText: true,
                  ),
                  SizedBox(height: 8,),
                  new RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    onPressed: _loadKameraProfilPage,
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
                ],
              ),
            )
          );
        }
      )
    );
  }

  void _loadKameraProfilPage() {
  Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<KameraProfilBloc>(
          builder: (context) {
            return KameraProfilBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo:   _dataDiriBloc.userRepo,
            );
          },
          child: KameraPage(),

        );
      }
      )
  );
  }
}

class PasswordField extends StatefulWidget
{
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField>
{
  bool _obscureText = true;

  @override
  Widget build(BuildContext context)
  {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        fillColor: Colors.white30,
        border: const OutlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        icon:Icon(Icons.lock),
        suffix: new GestureDetector(
          onTap: (){
            setState(() {
             _obscureText = !_obscureText; 
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        )
      ),
    );
  }
}