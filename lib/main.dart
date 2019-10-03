import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/auth/auth_event.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:PayFace/route.dart';



const String PARSE_APP_ID = 'wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v';
const String PARSE_APP_URL = 'https://parseapi.back4app.com';
const String MASTER_KEY = 'YO2PuRhza2DIV3cxvVkY1319L01x4f8V5lxST20o';
const String LIVE_QUERY_URL = 'wss://payface.back4app.io';

class SimpleBlocDelegate extends BlocDelegate {
  @override 
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override 
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async{
  SystemChrome.setEnabledSystemUIOverlays([]);
  //runApp(MyApp());
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await Parse().initialize(
    PARSE_APP_ID, 
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    liveQueryUrl: LIVE_QUERY_URL,
    autoSendSessionId: true,
    debug: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance());

    runApp(BlocProvider<AuthBloc>(
        builder: (context) {
          return AuthBloc(userRepo: UserRepo())
            ..dispatch(AppStart());
        },
        child: Routes(),
      )
    );

  
}

//class MyApp extends StatelessWidget {
//  void main() {
//  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//  runApp(MyApp());/
//}


//  final routes = <String, WidgetBuilder>{
//    LoginPage.tag: (context) => LoginPage(),
//    HomePage.tag: (context) => HomePage(),
//    DashBoardPage.tag: (context) => DashBoardPage(),
//    ProfilPage.tag: (context) => ProfilPage(),
//    RegisterPage.tag: (context) => RegisterPage(),
//    KirimPage.tag: (context) => KirimPage(),
//    TopUpPage.tag: (context) => TopUpPage(),
    //HistoryPage.tag: (context) => HistoryPage(),
//    HistoryPage2.tag: (context) => HistoryPage2(),
//    KameraPage.tag: (context) => KameraPage(),
//    KameraBayarPage.tag: (context) => KameraBayarPage(),
//    PinPage.tag: (context) => PinPage(),


  //};
  
  
 /// @override
  //Widget build(BuildContext context) {
    //return MaterialApp(
      //title: 'PayFace',
      //debugShowCheckedModeBanner: false,
      //theme: ThemeData(
       // primarySwatch: Colors.lightBlue,
        //fontFamily: 'Nunito',
      //),
      //home: LoginPage(),
      //routes: routes,
    //)
  ///}
//}