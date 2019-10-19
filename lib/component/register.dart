
import 'package:flutter/material.dart';
import 'package:PayFace/validator/email.dart';
import 'package:PayFace/validator/value.dart';
import 'package:PayFace/bloc/register/register_bloc.dart';
import 'package:PayFace/bloc/register/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/register/register_state.dart';

class ColorPalete{
  static const primaryColor = Color(0xff5364e8);
  static const primaryDarkColor = Color(0xff607cbf);
  static const underLineTextField = Color(0xff8b97ff);
  static const hintColor = Color(0xffccd1ff);

}
class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  @override 
  _RegisterPageState createState() => _RegisterPageState(); 
}

class _RegisterPageState extends State<RegisterPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _username, _password;
  RegisterBloc _registerBloc;

  @override
  void initState(){
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    
    return BlocListener<RegisterBloc, RegisterState>(
      listener:  (context, state) {
        if (state is RegisterBerhasil) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        builder: (context, state){
          final logo = Hero(
            tag: 'hero',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('asset/images/logo_1.jpeg'),
            ),
          );
          final username = TextFormField(
            autofocus: false,
            key: Key('Username'),
            onSaved: (value) => _username = value,
            decoration: InputDecoration(
              hintText: 'Username',
              prefixIcon: Icon(Icons.supervised_user_circle),
              contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 11.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          );
          final email = TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            key: Key('Email'),
            validator: EmailFieldValidator.validate,
            onSaved: (value) => _email = value, 
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 11.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          );
          final password = TextFormField(
            autofocus: false,
            key: Key('Password'),
            validator: ValueFieldValidator.validate,
            onSaved: (value) => _password = value,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 11.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          );
          final registerButton = Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(32.0)),
              shadowColor: Colors.lightBlueAccent.shade100,
              //elevation: 5.0,
              clipBehavior: Clip.antiAlias, // Add This
              child: MaterialButton(
                minWidth: 200.0,
                height: 46.0,
                onPressed: _handleRegister,
                color: Colors.orange,
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
          return Scaffold(
            body: Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      SizedBox(height: 138.0),
                      logo,
                      SizedBox(height: 48.0),
                      username,
                      SizedBox(height: 8,),
                      email,
                      SizedBox(height: 8,),
                      password,
                      SizedBox(height: 8,),
                      registerButton,
                      
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      ),
                      
                      Center(
                        child: Text('or',style: TextStyle(color: Colors.grey[700], fontSize: 12),),
                      ),
                      
                      FlatButton(
                        child: Text('Login',
                        style: TextStyle(color: Colors.grey[700]),
                        ),
                        onPressed: () => Navigator.pop(context) 
                      )
                         
                    ],
                  )
                ),
              ),
            )
          );
        }
      )
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

  void _handleRegister() {
    if (_validateDanSave()) {
      _registerBloc.dispatch(TombolRegister(
        username: _username,
        email: _email,
        password: _password
      ));
    }
  }

}