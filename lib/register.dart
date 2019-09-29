<<<<<<< HEAD
import 'package:PayFace/login.dart';
import 'package:flutter/material.dart';
//import 'package:passwordfield/passwordfield.dart';
=======

import 'package:flutter/material.dart';
import 'package:PayFace/validator/email.dart';
import 'package:PayFace/validator/value.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83

class ColorPalete{
  static const primaryColor = Color(0xff5364e8);
  static const primaryDarkColor = Color(0xff607cbf);
  static const underLineTextField = Color(0xff8b97ff);
  static const hintColor = Color(0xffccd1ff);

}

<<<<<<< HEAD
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
    height: 150,
  );
}

Widget _titleDesc() {
  return Column(
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 16)),
      Text('Registrasi Dulu',
=======
class RegisterPage extends StatefulWidget {
static String tag = 'register-page';

@override 
_RegisterPageState createState() => _RegisterPageState(); 
}

class _RegisterPageState extends State<RegisterPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _username, _password;

  @override
  void initState(){
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: ColorPalete.primaryColor,
        child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
          Column(
    
          children: <Widget>[

    Padding(
    padding: EdgeInsets.only(top: 12),
  ),
  ],
            
          ),
    Column(
    children: <Widget>[
      Image.asset('asset/registration.png',
      width: 150,
      height: 150,),

      Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 16),

      ),
      Text(
        'Registrasi Dulu', 
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
        style: TextStyle(
        color: Colors.white, 
        fontSize: 16),
      ),
<<<<<<< HEAD
      Padding(padding: EdgeInsets.only(top: 16)),
      Text('Ini Deskripsi',
        style: TextStyle(
          fontSize: 12, color: Colors.white,
        ),
        textAlign: TextAlign.center,
      )
    ]
  );
}

Widget _textField() {
  return Column(
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 12)),
      TextFormField( //<--EMAIL
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
            borderSide: BorderSide(
                width: 3,
                color: Colors.white
            ),
          ),
          hintText: 'Username',
          hintStyle: TextStyle(color: ColorPalete.hintColor,)
        ),
        style: TextStyle(color: Colors.white),
        autofocus: false,
      ),
      Padding(padding: EdgeInsets.only(top: 12)),
      TextFormField( //<-- Password
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalete.underLineTextField,
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
      Padding(padding: EdgeInsets.only(top: 12)),
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
=======
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
  ),
    Padding(
      padding: EdgeInsets.only(top: 12),
    ),

    TextFormField( //<-- Email
    key: Key('Email'),
    validator: EmailFieldValidator.validate,
    onSaved: (value) => _email = value,
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
    key: Key('Username'),
    validator: ValueFieldValidator.validate,
    onSaved: (value) => _username = value,
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
  key: Key('Password'),
  validator: ValueFieldValidator.validate,
  onSaved: (value) => _password = value,
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
  
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
      Padding(
        padding: EdgeInsets.only(top: 16),
      ),
      FlatButton(
<<<<<<< HEAD
        onPressed: () {},
=======
        onPressed: _handleRegister,
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
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
<<<<<<< HEAD
        onPressed: (){
          Navigator.pushNamed(context, LoginPage.tag);
        },
      )
    ],
  );


}
=======
        onPressed: () => Navigator.pop(context) 
      )
    ],
  )

          ],
        ),
      ),
    )));
    
    
  }
  bool _validateDanSave() {
  final FormState form = _formKey.currentState;
  if (form.validate()) {
    form.save();
    return true;
  }
  return false;
  }

  void _handleRegister() async {
    if (_validateDanSave()) {
      var userreg = ParseUser( _username, 
                               _password, 
                               _email);
      var response = await userreg.signUp();
      if (response!= null) {
        Navigator.pop(context);
      }
    }
  }
  }
    

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
