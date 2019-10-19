// Library 3rd party
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class component program
import 'package:PayFace/bloc/auth/auth_event.dart';
import 'package:PayFace/component/history2.dart';
import 'package:PayFace/component/topup.dart';
import 'package:PayFace/component/kirim.dart';
import 'package:PayFace/component/payout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/home/dashboard_bloc.dart';
import 'package:PayFace/bloc/home/dashboard_state.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/datadiri/datadiri_bloc.dart';
import 'profil_v2.dart';
import 'package:PayFace/bloc/kirim/kirim_bloc.dart';
import 'package:PayFace/bloc/payout/payOut_bloc.dart';
import 'package:PayFace/bloc/history/history_bloc.dart';
import 'package:PayFace/bloc/topup/topUp_bloc.dart';
import 'package:PayFace/model/initialization.dart';


class DashBoardPage extends StatefulWidget 
{
  static String tag = 'dashboard-page';
  @override
  _DashBoardPageState createState() =>_DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> 
{
  DashBoardBloc _dashBoardBloc;
  AuthBloc _authBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PermissionStatus _status; //check status

  //DataUser
  String displayNama;
  String displayEmail;
  int displaySaldo;

  // Data dari piechart
  Map<String, double> dataMap = new Map();
  
  // Warna dari piechart
  List<Color> colorList = [
    Colors.blue,
    Colors.blueAccent,
    Colors.orange,
  ];

  loadDataUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      //pref.reload();
      
      new Future.delayed(Duration.zero, () => setState(() {
        displayNama = (pref.getString('namaLengkap') ?? "Loading Data ...");
        displayEmail = (pref.getString('email') ?? "Email Anda");
        displaySaldo = (pref.getString('saldo') ?? 0);
      }));
    } catch (Exception) {

    }
  } 
  // Inisialisasi awal
  @override
  void initState(){
    checkObject();
    Timer(const Duration(seconds: 8), loadDataUser);
    super.initState();
    //super.initState();
    _askPermission();
    PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    dataMap.putIfAbsent("Pay Out", () => 5);
    dataMap.putIfAbsent("Transfer", () => 3);
    dataMap.putIfAbsent("Top Up", () => 2);
    
    
  }
  
  // Link darigambar logo
  var logoImage = 'asset/images/logo.png';
  
  // Background dari menu
  //List<Color> _backgroundColor = [
  //  Color.fromRGBO(94, 128, 194, 1),
  //  Color.fromRGBO(66, 145, 249, 1),
  //  Color.fromRGBO(243, 249, 255, 1),
  //  Color.fromRGBO(230, 244, 241, 1),
  //];
  Color _iconColor = Colors.white;
  Color _textColor = Color.fromRGBO(253, 211, 4, 1);
  Color _borderContainer = Color.fromRGBO(34, 58, 90, 0.2);
  List<Color>_actionContainerColor = [
    Color.fromRGBO(47, 75, 110, 1),
    Color.fromRGBO(43, 71, 105, 1),
    Color.fromRGBO(39, 64, 97, 1),
    Color.fromRGBO(34, 58, 90, 1),
  ];

  @override
  Widget build(BuildContext context) {
    _dashBoardBloc = BlocProvider.of<DashBoardBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      bloc: _dashBoardBloc,
      builder: (context, state){
        
        final drawerHeader = UserAccountsDrawerHeader(
          accountName: Text("$displayNama"),
          accountEmail: Text("$displayEmail"),
          currentAccountPicture: CircleAvatar(
            child: FlutterLogo(size: 42.0),
            backgroundColor: Colors.white,
          ),
        );
        
        final drawerItems = ListView(
          children: <Widget>[
            drawerHeader,
            ListTile(
              leading: Badge(
                badgeContent: Text('!', style: TextStyle(color: Colors.white)),
                child: Icon(Icons.account_circle),
              ),
              title: Text('Edit Profil'),
              onTap: (){
                _loadProfilPage();
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Log Out'),
              onTap: () =>_authBloc.dispatch(LoggedOut()),
            ),
          ],
        );

        const ucap_d_selamat = EdgeInsets.fromLTRB(12.0, 0, 12.0, 0);
        
        var chartAnalysis =Center(
          child: PieChart(
            dataMap: dataMap,
            legendFontColor: Colors.blueGrey[900],
            legendFontSize: 14.0,
            legendFontWeight: FontWeight.w500,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 2.0,
            showChartValuesInPercentage: false,
            showChartValues: false,
            showChartValuesOutside: false,
            chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
            colorList: colorList,
            showLegends: true,
            decimalPlaces: 1,
          ),
        );
        
        final cardPayOut = Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Bulan September'),
                subtitle: Text('Kegiatan bulan ini'),
              ),
              chartAnalysis     
            ],
          )
        );
        
        final head_title = Column(
          children: <Widget>[
            Padding(
              padding: ucap_d_selamat,
              child: Align(
                alignment: Alignment.topLeft,
                child:Container(
                  child: Text('Welcome,', style: TextStyle(fontSize: 18, color: Colors.black),textAlign: TextAlign.left),
                )
              ),
            ),
            Padding(
              padding: ucap_d_selamat,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text('$displayNama', style: TextStyle(fontSize: 44, color: Colors.black), textAlign: TextAlign.left) // Nama Pengguna,
                ),
              )
            )
          ],
        );

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.dehaze),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title: Text('',style: TextStyle(color: Colors.black)), backgroundColor: Colors.transparent, elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height-80,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TULISAN SELAMAT DATANG
                    head_title,
                    cardPayOut,
                    // Menu BUTTON
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: _borderContainer,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.2, 0.4, 0.6, 0.8],
                                  colors: _actionContainerColor)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 70,
                                child: Center(
                                  child: ListView(
                                    children: <Widget>[
                                      Text("Rp. "+"$displaySaldo", //<--Total Uang
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: _textColor,
                                            fontWeight: FontWeight.bold, fontSize: 30),
                                      ),
                                      Text('Uang Tersedia',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0.5,
                                color: Colors.grey,
                              ),
                              Table(
                                border: TableBorder.symmetric(
                                  inside: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 0.5),
                                ),
                                children: [
                                  TableRow(children: [
                                    Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Image.asset('asset/images/rupiah.png', fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
                                                onPressed: _loadKirimPage,
                                                padding: EdgeInsets.all(8),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Transfer Uang',
                                                style: TextStyle(color: _iconColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                    Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Image.asset('asset/images/wallet.png', fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
                                                onPressed: _loadPayoutPage,
                                                padding: EdgeInsets.all(8),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Pay Out',
                                                style: TextStyle(color: _iconColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Image.asset('asset/images/transaksi.png', fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
                                                onPressed: _loadRiwayatPage,
                                                padding: EdgeInsets.all(8),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Riwayat Transaksi',
                                                style: TextStyle(color: _iconColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                    Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Image.asset('asset/images/topup.png', fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
                                                onPressed: _loadTopupPage,
                                                padding: EdgeInsets.all(8),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Top Up',
                                                style: TextStyle(color: _iconColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: Drawer(
            child: drawerItems,
          ),
        );
      }
    );
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status){
      setState(() {
        _status = status;
      });

    }
  }// END UpdateStatus

  void _askPermission() 
  {
    PermissionHandler().requestPermissions([PermissionGroup.storage, PermissionGroup.camera])
        .then(_onStatusRequested);
  }//END askPermission

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) 
  {
    final statusStorage = statuses[PermissionGroup.storage];
    final statusCamera = statuses[PermissionGroup.camera];

    if (statusStorage != PermissionStatus.granted)
    {
      PermissionHandler().openAppSettings();
    }else 
    {
      _updateStatus(statusStorage);
    }
    if (statusCamera != PermissionStatus.granted)
    {
      PermissionHandler().openAppSettings();
    }else 
    {
      _updateStatus(statusCamera);
    }
  }//END onStatusUpdate

  //LOAD Profile Page 
  void _loadProfilPage() 
  {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<DataDiriBloc>(
            builder: (context) {
              return DataDiriBloc(authBloc: BlocProvider.of<AuthBloc>(context),
                userRepo: _dashBoardBloc.userRepo,
              );
            },
            child: ProfilPage(),
        );
      })
    );
  }

  void _loadKirimPage() 
  {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<KirimBloc>(
          builder: (context) {
            return KirimBloc(authBloc: BlocProvider.of<AuthBloc>(context),
              userRepo:   _dashBoardBloc.userRepo,
            );
          },
          child: KirimPage(),
        );
      })
    );
  }

  void _loadPayoutPage() 
  {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<PayOutBloc>(
          builder: (context) {
            return PayOutBloc(authBloc: BlocProvider.of<AuthBloc>(context),
              userRepo:   _dashBoardBloc.userRepo,
            );
          },
          child: PayoutPage(),
        );
      })
    );
  }

  void _loadRiwayatPage() 
  {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<HistoryBloc>(
          builder: (context) {
            return HistoryBloc(authBloc: BlocProvider.of<AuthBloc>(context),
              userRepo:   _dashBoardBloc.userRepo,
            );
          },
          child: HistoryPage2(),
        );
      })
    );
  }

  void _loadTopupPage() 
  {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<TopUpBloc>(
          builder: (context) {
            return TopUpBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo:   _dashBoardBloc.userRepo,
            );
          },
          child: TopUpPage(),
        );
      })
    );
  }
}