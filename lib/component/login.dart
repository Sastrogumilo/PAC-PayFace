import 'package:PayFace/bloc/login/login_bloc.dart';
import 'package:PayFace/component/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/login/login_state.dart';
import 'package:PayFace/bloc/login/login_event.dart';
import 'package:PayFace/bloc/register/register_bloc.dart';
import 'package:PayFace/validator/value.dart';
import 'package:PayFace/validator/email.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    
    return BlocListener <LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginGagal) {
          _scaffoldstate.currentState.showSnackBar(SnackBar(content: Text(state.error)));
        }
      },

      child: BlocBuilder <LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
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
              onPressed: () =>_handleLogin(),
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
          onPressed: _loadRegisterScreen, //<-- Ke Page Register 
        );
        return Scaffold(
          key: _scaffoldstate,
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: _formKey,
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
          )
        );
      })
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
  
  void _handleLogin() {
    if (_validateDanSave()) {
      _loginBloc.dispatch(LoginButtonPressed(
        //username: _username,
        username: _email,
        password: _password,
      ));
    }
  }

  void _loadRegisterScreen() {
    Navigator.push(context, 
        MaterialPageRoute(builder: (context){
          return BlocProvider<RegisterBloc>(
            builder: (context) {
              return RegisterBloc(authBloc: BlocProvider.of<AuthBloc>(context),
              userRepo: _loginBloc.userRepo,
              );
            },
            child: RegisterPage(),

          );
        }
        )
    );
  }
}