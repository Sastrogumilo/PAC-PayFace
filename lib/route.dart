import 'package:flutter/material.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:PayFace/root.dart';
import 'package:PayFace/profil.dart';


class Routes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(

    ),
    routes: {
      '/' : (context) => Root(userRepo: UserRepo()),
      ProfilPage.tag: (context) => ProfilPage(),
    },
  ); 
  }
}