import 'package:PayFace/history2.dart';
import 'package:PayFace/profil.dart';
import 'package:PayFace/topup.dart';
import 'package:PayFace/kirim_v2.dart';
//import 'package:PayFace/kirim.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';


class DashBoardPage extends StatefulWidget 
{
  static String tag = 'dashboard-page';
  @override
  _DashBoardPageState createState() =>_DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> 
{
  PermissionStatus _status; //check status
  Map<String, double> dataMap = new Map();
  List<Color> colorList = [
    Colors.blue,
    Colors.blueAccent,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    dataMap.putIfAbsent("Pay Out", () => 5);
    dataMap.putIfAbsent("Transfer", () => 3);
    dataMap.putIfAbsent("Top Up", () => 2);
  }
  var logoImage = 'asset/images/logo.png';
  List<Color> _backgroundColor = [
    Color.fromRGBO(94, 128, 194, 1),
    Color.fromRGBO(66, 145, 249, 1),
    Color.fromRGBO(243, 249, 255, 1),
    Color.fromRGBO(230, 244, 241, 1),
  ];
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Test_1'),
      accountEmail: Text('coba@email.com'),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
        backgroundColor: Colors.white,
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Data Diri'),
        ),
        ListTile(
          title: Text('Log Out'),
        ),
      ],
    );
    const ucap_d_selamat = EdgeInsets.fromLTRB(12.0, 0, 12.0, 0);
    
    var chart_analysis =Center(
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

    final card_pay_out = Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Bulan September'),
            subtitle: Text('Kegiatan bulan ini'),
          ),
          chart_analysis     
        ],
      )
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
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // TULISAN SELAMAT DATANG
                Column(
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
                          child: Text('Test_1', style: TextStyle(fontSize: 44, color: Colors.black), textAlign: TextAlign.left) // Nama Pengguna,
                        ),
                      )
                    )
                  ],
                ),
                card_pay_out,
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
                                  Text('Rp. 696969', //<--Total Uang
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
                                _actionList('asset/images/rupiah.png', 'Transfer Uang', KirimPage.tag),
                                _actionList('asset/images/wallet.png', 'Pay Out', ProfilPage.tag),
                              ]),
                              TableRow(children: [
                                _actionList('asset/images/transaksi.png', 'Riwayat Transaksi', HistoryPage2.tag),
                                _actionList('asset/images/topup.png', 'Top Up', TopUpPage.tag),
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
  Widget _actionList(var icon, String desc, routeName){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Image.asset(icon, fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
            onPressed: () {Navigator.of(context).pushNamed(routeName); _askPermission();},
            padding: EdgeInsets.all(8),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: TextStyle(color: _iconColor),
          ),
        ],
      ),
    );
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status){
      setState(() {
        _status = status;
      });

    }
  }// END UpdateStatus

  void _askPermission() {
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
}