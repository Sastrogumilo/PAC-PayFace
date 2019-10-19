import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/home/dashboard_bloc.dart';
import 'package:PayFace/bloc/home/dashboard_event.dart';
import 'package:PayFace/bloc/login/login_bloc.dart';
import 'package:PayFace/component/dashboard_v2.dart';
import 'package:PayFace/component/login.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/auth/auth_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class Root extends StatefulWidget{
  final UserRepo userRepo;
  Root({Key key, this.userRepo}): super(key:key);

  @override 
  _RootState createState() => _RootState();
}

class _RootState extends State<Root>{
  @override 
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthDikenal) {
          return BlocProvider(
            builder: (context) {
              return DashBoardBloc()..dispatch(DashBoardStart());
            },
            child: DashBoardPage(),
            
              
          );
          }
          if (state is AuthUnauth) {
            return BlocProvider(
              builder: (context) {
                return LoginBloc(
                  authBloc: BlocProvider.of<AuthBloc>(context),
                  userRepo: widget.userRepo,
                );
              },
              child: LoginPage(),
            );
          }
          
          return Center(child: CircularProgressIndicator(),
          );
        
        },
        );
      
      }
    
   
  }
  
