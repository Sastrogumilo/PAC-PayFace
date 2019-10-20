import 'package:flutter/material.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:PayFace/component/root.dart';
import 'package:PayFace/component/profil_v2.dart';


class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => Root(userRepo: UserRepo()),
        ProfilPage.tag: (context) => ProfilPage(),
      },
    ); 
  }
}