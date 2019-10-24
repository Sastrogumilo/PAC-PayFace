import 'dart:convert';
import 'package:PayFace/repository/datadiri_repo.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:http/http.dart' show Client;
import 'dart:async' show Future;
import 'package:PayFace/model/rekening.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

Client client = Client();
//Link Endpoint
final String urlTransfer = "https://payface.back4app.io/classes/Transaksi/";

//REST-API Key
Map<String, String> headers = {
    "X-Parse-Application-Id": "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
    "X-Parse-REST-API-Key": "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
};

//Struktur Data Transfer = Data dengan bentuk List Transfer
class ListTransfer{
  final List<Transfer> result; 
  ListTransfer({this.result});

  factory ListTransfer.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    print(list.runtimeType);
    List<Transfer> rekList = list.map((f) => Transfer.fromJson(f)).toList(); 
    print(rekList);
    return ListTransfer (result: rekList);
  }
}

// Struktur Data Transfer
class Transfer{
  String objectRekID;
  String userID;
  String noRek;
  int saldo;
 
  Rekening({this.objectRekID, this.noRek, this.userID, this.saldo});
  factory Rekening.fromJson(Map<String, dynamic> parsedJson){
    return Rekening(
      noRek: parsedJson['no_rekening'],
      objectRekID: parsedJson['objectId'],
      userID: parsedJson['user_id'],
      saldo: parsedJson['saldo'],
    );
  } 
}

class DebugRekening{
  String error;
  DebugRekening({this.error});

  factory DebugRekening.fromJson(Map<String, dynamic> parsedJson) {
    return DebugRekening(error: parsedJson['error']);
  }
}

abstract class TransferRepo {
  /*Future<ParseUser> authenticate({String username, @required String email, @required String password});
  Future<ParseUser> register({@required String username, @required String email, @required String password,});
  Future<ParseUser> currentUser();
  Future<bool> logout();
  Future<ParseObject> dataTambahan({@required String alamat, @required String namalengkap, @required String notlp});
  Future<ParseObject> rekening({@required String norek, @required String pin});*/
}


Future postRekening(String noRek) async {
  String body;
  var pref = await SharedPreferences.getInstance();
  String objectID = pref.getString('objectID');
  print("$noRek");
  Map<String, dynamic> bodyRek = {
    "user_id" : "$objectID",
    "no_rekening" : "$noRek",
    "saldo": 0,
  };
  body = jsonEncode(bodyRek);

  final response = await client.post(
    "$urlTransfer", 
    headers: headers, 
    body: body
  );
  print("POST Rekening = "+response.statusCode.toString());
}

// Mengedit Nomer Rekening dari User
Future updateTransfer(String noRek) async {
  var pref = await SharedPreferences.getInstance();
  String userRekID = pref.getString('userRekID');

  print("PUT = "+"$urlTransfer"+"$userRekID");
  final response = await client.put(
    "$urlTransfer"+"/"+"$userRekID",
    headers: headers, 
    body: {
      "user_id" : "$objectID",
      "no_rekening" : "$noRek",
    }
  );
  print("Update Rekening = "+response.statusCode.toString());
  if (response.statusCode >= 400){
    final data = json.decode(response.body);
    DebugRekening error = new DebugRekening.fromJson(data);
    print(error.error);
  }
}

Future <void> rekUserQuery() async {
  String objectID;

  var pref = await SharedPreferences.getInstance();
  objectID = pref.getString('objectID');

  final QueryBuilder<RekUser> query = QueryBuilder<RekUser>(RekUser())
                ..regEx(userID, "$objectID");
  final response = await query.query();
  print(response.statusCode);
  
  if(response.result == null){
    print("Data Saldo tidak Ditemukan Di Server");
    print(response.error);
  }else{
    print("hasil update Rekening: = "+response.result.toString());
    final data = json.decode(response.result.toString());
    
    ListHasilRek dataList = ListHasilRek.fromJson(data);
    pref.setString('userRekID', dataList.rekening[0].objectIDRek);
    pref.setString('noRekUser', dataList.rekening[0].noRek);
    pref.setInt('saldo', dataList.rekening[0].saldo);

    String userRek = pref.getString('userRekID');
    String noRekUser = pref.getString('noRekUser');
    int saldo = pref.getInt('saldo');
    print('Menyimpan Data Pada Devices....');
    print('UserRekening = '+"$userRek"+", No Rekening = "+"$noRekUser"+", Saldo = "+"$saldo");
  }
}

Future<bool> getSaldoUser() async{
  var pref = await SharedPreferences.getInstance();
  objectID = pref.getString('objectID');

  final QueryBuilder<RekUser> query = QueryBuilder<RekUser>(RekUser())
                ..regEx(userID, "$objectID");
  final response = await query.query();
  print(response.statusCode);
  
  if(response.result == null){
    print("Data Saldo tidak Ditemukan Di Server");
    print(response.error);
    return false;
  }else{
    //print("hasil update Rekening: = "+response.result.toString());
    final data = json.decode(response.result.toString());
    
    ListHasilRek dataList = ListHasilRek.fromJson(data);
    //pref.setString('userRekID', dataList.rekening[0].objectIDRek);
    //pref.setString('noRekUser', dataList.rekening[0].noRek);
    pref.setInt('saldo', dataList.rekening[0].saldo);

   // String userRek = pref.getString('userRekID');
    //String noRekUser = pref.getString('noRekUser');
    int saldo = pref.getInt('saldo');
    //print('Menyimpan Data Pada Devices....');
    //print('UserRekening = '+"$userRek"+", No Rekening = "+"$noRekUser"+", Saldo = "+"$saldo");
    return true;
  }
}

Future<ListHasilRek> getPayOutNotAccUser() async{
  var pref = await SharedPreferences.getInstance();
  objectID = pref.getString('objectID');

  final QueryBuilder<RekUser> query = QueryBuilder<RekUser>(RekUser())
                ..regEx(userID, "$objectID");
  final response = await query.query();
  print(response.statusCode);
  
  if(response.result == null){
    print("Data Saldo tidak Ditemukan Di Server");
    print(response.error);
    return null;
  }else{
    //print("hasil update Rekening: = "+response.result.toString());
    final data = json.decode(response.result.toString());
    
    ListHasilRek dataList = ListHasilRek.fromJson(data);
    //pref.setString('userRekID', dataList.rekening[0].objectIDRek);
    //pref.setString('noRekUser', dataList.rekening[0].noRek);
    //pref.setInt('saldo', dataList.rekening[0].saldo);

   // String userRek = pref.getString('userRekID');
    //String noRekUser = pref.getString('noRekUser');
    //int saldo = pref.getInt('saldo');
    //print('Menyimpan Data Pada Devices....');
    //print('UserRekening = '+"$userRek"+", No Rekening = "+"$noRekUser"+", Saldo = "+"$saldo");
    return dataList;
  }
}
