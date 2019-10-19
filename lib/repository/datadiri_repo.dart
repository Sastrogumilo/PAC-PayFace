import 'package:PayFace/model/initialization.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
import 'dart:convert';

Client client = Client();
final String urlDataRepo = "https://payface.back4app.io/users/";


String objectID;
String sessionToken;

class DataRepo {
  String alamat;
  String notlp;
  String namalengkap;
  String email;
  //String password;
  String username;

  loadObjectID() async {
    var pref = await SharedPreferences.getInstance();
    objectID = pref.getString('objectID');
    print(objectID);    
  }

  DataRepo({this.alamat,
    this.namalengkap,
    this.notlp,
    this.email,
    //this.password,
    this.username,});

  Future dataTambahan({
     String alamat,
     String notlp,
     String namalengkap,
     String email,
     String password,
     String username,
  }) async {}
}

class DebugDataUpload{
  String error;
  DebugDataUpload({this.error});

  factory DebugDataUpload.fromJson(Map<String, dynamic> parsedJson) {
    return DebugDataUpload(error: parsedJson['error']);
  }
}


Future uploadDataTambahan({
  String alamat,
  String notelp,
  String namalengkap,
  String email,
  //String password,
  String username,
}) async {
  var pref = await SharedPreferences.getInstance();
  sessionToken = pref.getString('sessionToken');
  print(sessionToken);
  objectID = pref.getString('objectID');

  Map<String, String> headers = {
    "X-Parse-Application-Id" : "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
    "X-Parse-REST-API-Key" : "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
    "X-Parse-Session-Token": "$sessionToken"
    //"Content-Type" : "application/json"
  };

  Map<String, String> bodyUserUpdate = {
    "alamat":"$alamat",
    "notelp":"$notelp",
    "nama_lengkap" :"$namalengkap",
    "email" : "$email",
    //"password" : "$password",
    "username" : "$username",
  };
  String body = jsonEncode(bodyUserUpdate);

  print("$urlDataRepo"+"$objectID");
  var response = await client.put("$urlDataRepo"+"$objectID", headers: headers, body: body);
  print("Update Data Diri = "+response.statusCode.toString());
  if (response.statusCode >= 400) {
    final data = json.decode(response.body);
    DebugDataUpload error = new DebugDataUpload.fromJson(data);
    print(error.error);
    checkObject();
  }
}