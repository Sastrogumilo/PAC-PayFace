import 'package:PayFace/login.dart';
import 'package:flutter/material.dart';
//import 'package:passwordfield/passwordfield.dart';

class ColorPalete{
  static const primaryColor = Color(0xff5364e8);
  static const primaryDarkColor = Color(0xff607cbf);
  static const underLineTextField = Color(0xff8b97ff);
  static const hintColor = Color(0xffccd1ff);

}

class RegisterPage extends StatelessWidget {
  static String tag = 'register-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalete.primaryColor,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            _iconLogin(),
            _titleDesc(),
            _textField(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }
}

Widget _iconLogin() {
  return Image.asset('asset/registration.png',
  width: 150,
  height: 150,);

}

Widget _titleDesc() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),

      ),
      Text(
        'Registrasi Dulu', 
        style: TextStyle(
        color: Colors.white, 
        fontSize: 16),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
      ),
      Text(
        'Ini Deskripsi',
        style: TextStyle(
          fontSize: 12, color: Colors.white, 
          ),
          textAlign: TextAlign.center,
      )
    ],
  );


}

Widget _textField() {
return Column(
  children: <Widget>[
    Padding(
      padding: EdgeInsets.only(top: 12),
    ),

    TextFormField( //<-- Email
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: ColorPalete.underLineTextField,
        width: 15)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 3,
          color: Colors.white),
        ),
        hintText: 'Email',
        hintStyle: TextStyle(color: ColorPalete.hintColor),
        
    ),
    style: TextStyle(color: Colors.white),
    autofocus: false,
    ),

    TextFormField( //<-- Username
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorPalete.underLineTextField,
            width: 15,
            ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 3, 
        color: Colors.white
        ),
      ),
      hintText: 'Username',
      hintStyle: TextStyle(color: ColorPalete.hintColor,)
      ),
      style: TextStyle(color: Colors.white),
      autofocus: false,
  ),
  Padding(
    padding: EdgeInsets.only(top: 12),
  ),

  TextFormField( //<-- Password
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorPalete.underLineTextField,
        width: 15,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.white)
    ),
    hintText: 'Password',
    hintStyle: TextStyle(color: ColorPalete.hintColor)
    ),
    style: TextStyle(color: Colors.white),
    obscureText: true,
    autofocus: false,
  ),
  Padding(
    padding: EdgeInsets.only(top: 12),
  ),

  TextFormField( //<-- Confirm Password
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorPalete.underLineTextField,
        width: 1.5
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.white)
      ),
      hintText: 'Ulang Password',
      hintStyle: TextStyle(color: ColorPalete.hintColor)

    ),
    style: TextStyle(color: Colors.white),
    obscureText: true,
    autofocus: false,

  )
  
  ],
);

}

Widget _buildButton(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),
      ),
      FlatButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          child: Text('Register',
          style: TextStyle(color: ColorPalete.primaryColor),
          textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
      ),
      Text('or',
      style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      FlatButton(
        child: Text('Login',
        style: TextStyle(color: Colors.white),
        ),
        onPressed: (){
          Navigator.pushNamed(context, LoginPage.tag);
        },
      )
    ],
  );


}
