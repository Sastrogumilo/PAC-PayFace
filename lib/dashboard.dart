
import 'package:PayFace/history2.dart';
import 'package:PayFace/profil.dart';
import 'package:PayFace/topup.dart';
import 'package:PayFace/kirim.dart';
<<<<<<< HEAD


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
=======
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_const.dart';
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83


class DashBoardPage extends StatefulWidget {
  static String tag = 'dashboard-page';
  @override 
  _DashBoardPageState createState() =>_DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
<<<<<<< HEAD
  PermissionStatus _status; //check status

  @override
  void initState() {
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
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
    return Scaffold(
      body: SafeArea(
         child: GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.2, 0.3, 0.5, 0.8],
                  colors: _backgroundColor
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    logoImage,
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                  Column(
                    children: <Widget>[
                      Text('Hello', style: TextStyle(fontSize: 18, color: Colors.black54),),
                      Text('(Nama Pengguna)', style: TextStyle(fontSize: 24, color: Colors.black54,),) //diberi font
                    ],
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: _borderContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),

                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.2, 0.4, 0.6, 0.8],
                            colors: _actionContainerColor)),
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
=======

PermissionStatus _status; //check status

  initUser() async {
    var user = await ParseUser.getCurrentUserFromServer();
    var respon = await user.result;
    print(respon);
  }
  @override
  void initState() {

    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    initParse();
    initUser();
  }

var logoImage = 'asset/logo.png';

List<Color> _backgroundColor = [
    Color.fromRGBO(0, 214, 252, 1),
    Color.fromRGBO(8, 207, 251, 1),
    Color.fromRGBO(6, 197, 250, 1),
    Color.fromRGBO(25, 161, 249, 1),
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
    
    return Scaffold(
      body: SafeArea(
       child: GestureDetector(
          child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.2, 0.3, 0.5, 0.8],
              colors: _backgroundColor)),

          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset(  
                logoImage,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
              Column(
                children: <Widget>[
                  Text('Halo', 
                  style: TextStyle(fontSize: 18, color: Colors.black54),),
                  Text('aaaa', 
                  style: TextStyle(fontSize: 24, color: Colors.black45,),) //diberi font
                ],
              ),
              Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: _borderContainer, 
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
                
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.2, 0.4, 0.6, 0.8],
                        colors: _actionContainerColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: Center(child: ListView(
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
                              _actionList('asset/rupiah.png', 'Transfer Uang', KirimPage.tag),
                              _actionList('asset/user.png', 'Data Diri', ProfilPage.tag),
                            ]),
                            TableRow(children: [
                              _actionList('asset/transaksi.png', 'Riwayat Transaksi', HistoryPage2.tag),
                              _actionList('asset/topup.png', 'Top Up', TopUpPage.tag),
                            ]),
                            TableRow(children: [
                              _actionList('asset/about.png', 'About', null),
                              _actionList('asset/logout.png', 'Log Out', null)
                            ])

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
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
    );
  }
  Widget _actionList(var icon, String desc, routeName){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
<<<<<<< HEAD
          FlatButton(
            child: Image.asset(icon, fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
            onPressed: () {Navigator.of(context).pushNamed(routeName); _askPermission();}, 
            padding: EdgeInsets.all(8),
=======
          
          
          FlatButton(
            child: Image.asset(icon, fit: BoxFit.contain, color: _iconColor, width: 45, height: 45,),
            onPressed: () {Navigator.of(context).pushNamed(routeName); _askPermission();}, 
            padding: EdgeInsets.all(8),                    
            
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
          ),
          SizedBox(
            height: 8,
          ),
<<<<<<< HEAD
          Text(
            desc, 
            style: TextStyle(color: _iconColor),
          ),
=======

          Text(
            desc, 
            style: TextStyle(color: _iconColor),
              ),
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
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

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final statusStorage = statuses[PermissionGroup.storage];
    final statusCamera = statuses[PermissionGroup.camera];

    if (statusStorage != PermissionStatus.granted){
      PermissionHandler().openAppSettings();

    }else {
        _updateStatus(statusStorage);
  }
   if (statusCamera != PermissionStatus.granted){
      PermissionHandler().openAppSettings();

    }else {
        _updateStatus(statusCamera);
  }
    }//END onStatusUpdate
<<<<<<< HEAD
=======
    
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
}