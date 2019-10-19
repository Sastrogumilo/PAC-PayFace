import 'dart:async';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
import 'package:http/http.dart' show Client;
import 'package:PayFace/model/facesoft.dart';

//{
//"className":"_User",
//"objectId":"xsTU4wK2Cw",
//"createdAt":"2019-09-29T05:02:44.588Z",
//"updatedAt":"2019-09-29T18:50:16.295Z",
//"username":"aaaaa",
//"password":"12345",
//"email":"a5@email.com",
//"emailVerified":false,
//"alamat":"",
//"ACL":{"*":{"read":true},"xsTU4wK2Cw":{"read":true,"write":true}},
//"sessionToken":"r:2fe804ba442803a55da648e9e4f768e5"
//} => current user

final String baseUrlUser = "https://payface.back4app.io/users/";// + objectID

Map<String, String> headers = {"X-Parse-Application-Id" : "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
                              "X-Parse-REST-API-Key" : "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
                              
                              //"Content-Type" : "application/json"
                              };
Client client = Client();

class DebugInisialisasi{
String error;
  DebugInisialisasi({this.error});

  factory DebugInisialisasi.fromJson(Map<String, dynamic> parsedJson) {
    return DebugInisialisasi(error: parsedJson['error']);
  }
}


class UserSaatIni{
  String objectID;
  String username;
  String email;
  String alamat;
  String notelp;
  String namaLengkap;
  String tagID;
  String sessionToken;
  String password;


  UserSaatIni({this.objectID, 
              this.username, 
              this.email, 
              this.password,
              this.tagID,
              this.alamat,
              this.namaLengkap,
              this.notelp,
              this.sessionToken,
              });

  factory UserSaatIni.fromJson(Map<String, dynamic> parsedJson){
    return UserSaatIni(objectID: parsedJson['objectId'],
                        username: parsedJson['username'],
                        password: parsedJson['password'],
                        email: parsedJson['email'],
                        alamat: parsedJson['alamat'],
                        namaLengkap: parsedJson['nama_lengkap'],
                        notelp: parsedJson['notelp'],
                        tagID: parsedJson['id_foto_dataset'],
                        sessionToken: parsedJson['sessionToken']

                      );
  }
}

Future checkObject() async {
  String objectID;
  String tagID;
  var pref = await SharedPreferences.getInstance();
  objectID = pref.getString('objectID');
  tagID = pref.getString('tagID');

  if (objectID == null) {
    print("Tidak ada di data lokal objectID, proses pembuatan data lokal ...");
    getCurrentObject();
    print("get User Data dari DB ...");
    Future.delayed(Duration(seconds: 3), () => getUsersData());
    //getUsersData();
    print("check object ...");
    Timer(const Duration(seconds: 20), checkObject);

  }else{
    print("objectID ada = "+"$objectID");

    if(tagID == "" || tagID == null) { //true
        print("tagID tidak ada proses pembuatan tagID dari database ...");
        updateTagID();
    }else{
        print("tagID ada = "+"$tagID");

    }
  }
}

Future getCurrentObject() async {

  var pref = await SharedPreferences.getInstance();
  var user = await ParseUser.currentUser();
  user = user.toString();
  //print(user);
  final data = jsonDecode(user);
  UserSaatIni userIni = new UserSaatIni.fromJson(data);
  pref.setString('objectID', userIni.objectID);
  pref.setString('username', userIni.username);
  pref.setString('email', userIni.email);
  pref.setString('sessionToken', userIni.sessionToken);
  pref.setString('password', userIni.password);
  

  String objectID = pref.getString('objectID');
  //String username = pref.getString('username');
  //String email = pref.getString('email');
  //print(data);
  print("ObjekID telah diterima = "+"$objectID");
}

Future getUsersData() async {
  var pref = await SharedPreferences.getInstance();
  String objectID = pref.getString('objectID');
  print("Proses Get Data Dari "+"$baseUrlUser"+"$objectID");

  final response = await client.get("$baseUrlUser"+"$objectID", headers: headers);
  print("getUserData = "+response.statusCode.toString());

  final data = jsonDecode(response.body);
  UserSaatIni userSaatIni = new UserSaatIni.fromJson(data);
  pref.setString('tagID', userSaatIni.tagID ?? "");
  pref.setString('namaLengkap', userSaatIni.namaLengkap);
  pref.setString('notelp', userSaatIni.notelp);
  pref.setString('alamat', userSaatIni.alamat);
  
  String namaLengkap = pref.getString('namaLengkap');
  String tagID = pref.getString('tagID');
  print("tagID = "+"$tagID");
  print("Nama = "+"$namaLengkap");
  
}
Future updateTagID() async {
  var pref = await SharedPreferences.getInstance();
  String objectID = pref.getString('objectID');
  String tagID = pref.getString('tagID');
  String sessionToken = pref.getString('sessionToken');

  print("ObjectID = "+"$objectID"+", tagID = "+"$tagID"+", Session  = "+"$sessionToken");

  Map<String, String> headersUpdate = {
                              "X-Parse-Application-Id" : "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
                              "X-Parse-REST-API-Key" : "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
                              "X-Parse-Session-Token": "$sessionToken",
                              //"Content-Type" : "application/json"
                              };
  if (tagID == "null" || tagID == "") {
    getTags();
    print("Delay 5 Detik");
    Timer(const Duration(seconds: 10), updateTagID);
  
  }else{

    Map<String, String> bodyTagUpdate = {"id_foto_dataset":"$tagID"};
    String body = jsonEncode(bodyTagUpdate);
    
    final response = await client.put("$baseUrlUser"+"$objectID", headers: headersUpdate, body: body);
    print(response.statusCode);
    if(response.statusCode >= 400){
      final data = jsonDecode(response.body);
      DebugInisialisasi error = DebugInisialisasi.fromJson(data);
      print(error.error);
    }
    print("TagID telah ditambahkan ke DataBase = "+response.statusCode.toString());

    checkObject();
  }

}

