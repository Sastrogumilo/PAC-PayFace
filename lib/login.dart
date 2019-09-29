import 'package:PayFace/home_page.dart';
import 'package:PayFace/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PayFace/dashboard.dart';
import 'package:PayFace/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'app_const.dart';
import 'package:PayFace/validator/email.dart';
import 'package:PayFace/validator/value.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('asset/images/logo_1.jpeg'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'coba@email.com', //<- 
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 11.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'ini password', //<-- 
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 11.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(32.0)),
        shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        clipBehavior: Clip.antiAlias, // Add This
        child: MaterialButton(
          minWidth: 200.0,
          height: 46.0,
          onPressed: () {
            Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.blueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = Column(
      children: <Widget>[
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                child: FlatButton(
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {}, //<-- Ke Page Lupa Password
                ),
            ),
        ),
      ],
    );

    final register = FlatButton(
      child: Text( 
        "Don't have an account ? Register",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {Navigator.pushNamed(context, RegisterPage.tag);}, //<-- Ke Page Register 
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 12.0),
            password,
            forgotLabel,
            loginButton,
            SizedBox(height: 21.0),
            register
          ],
        ),
      ),
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
void _handleLogin() async {
  if (_validateDanSave()) {
    var userlogin = ParseUser(_username, 
                              _password, 
                              _email);
    var response = await userlogin.login();
    if (response != null){
        Navigator.pushNamed(context, DashBoardPage.tag);
    }
  }
}
}