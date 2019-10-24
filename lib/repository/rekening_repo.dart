import 'dart:convert';
import 'package:PayFace/repository/datadiri_repo.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:http/http.dart' show Client;
import 'dart:async' show Future;
import 'package:PayFace/model/rekening.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FORMAT DATA JSON
//{
  //"results":
  //[
    //{
      //"objectId":"pFn9sRRINE",
      //"user_id":"wd0i9W8piG",
      //"no_rekening":"2132135413",
      //"createdAt":"2019-10-17T12:59:38.417Z",
      //"updatedAt":"2019-10-17T12:59:38.417Z"
    //}
  //]
//}


//hasil: Current User Rek
//[
  //{
    //"className":"Rekening",
    //"objectId":"pFn9sRRINE",
    //"createdAt":"2019-10-17T12:59:38.417Z",
    //"updatedAt":"2019-10-17T12:59:38.417Z",
    //"user_id":"wd0i9W8piG",
    //"no_rekening":"2132135413"
  //}
//]

Client client = Client();

//Link Endpoint
final String urlRekening = "https://payface.back4app.io/classes/Rekening/";

//REST-API Key
Map<String, String> headers = {
    "X-Parse-Application-Id": "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
    "X-Parse-REST-API-Key": "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
};

class ListRekening{
  final List<Rekening> result; 
  ListRekening({this.result});

  factory ListRekening.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    print(list.runtimeType);
    List<Rekening> rekList = list.map((f) => Rekening.fromJson(f)).toList(); 
    print(rekList);
    return ListRekening (result: rekList);
  }
}

class Rekening{
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

class ListHasilRek{
  final List<HasilRek> rekening; 
  ListHasilRek({this.rekening});

  factory ListHasilRek.fromJson(List<dynamic> parsedJson) {
    List<HasilRek> rekening = new List<HasilRek>();
    rekening = parsedJson.map((f)=>HasilRek.fromJson(f)).toList();
    return new ListHasilRek(rekening: rekening);
  }
}

class HasilRek{
  String noRek;
  String objectIDRek;
  int saldo;
  
  HasilRek({this.noRek, this.objectIDRek, this.saldo});

  factory HasilRek.fromJson(Map<String, dynamic> json){
    return new HasilRek (
      noRek: json['no_rekening'],
      objectIDRek: json['objectId'],
      saldo: json['saldo'],
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

Future postRekening(
  String noRek,
) async {
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

  final response = await client.post("$urlRekening", 
                                    headers: headers, 
                                    body: body
                                          
  );
  print("POST Rekening = "+response.statusCode.toString());
}

// Mengedit Nomer Rekening dari User
Future updateRekening(String noRek) async {
  var pref = await SharedPreferences.getInstance();
  String userRekID = pref.getString('userRekID');

  print("PUT = "+"$urlRekening"+"$userRekID");
  final response = await client.put(
    "$urlRekening"+"/"+"$userRekID",
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
    //print("hasil update Rekening: = "+response.result.toString());
    final data = json.decode(response.result.toString());
    
    ListHasilRek dataList = ListHasilRek.fromJson(data);
    pref.setString('userRekID', dataList.rekening[0].objectIDRek);
    pref.setString('noRekUser', dataList.rekening[0].noRek);
    pref.setInt('saldo', dataList.rekening[0].saldo);

    /*String userRek = pref.getString('userRekID');
    String noRekUser = pref.getString('noRekUser');
    int saldo = pref.getInt('saldo');
    //print('Menyimpan Data Pada Devices....');
    //print('UserRekening = '+"$userRek"+", No Rekening = "+"$noRekUser"+", Saldo = "+"$saldo");*/
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
    //int saldo = pref.getInt('saldo');
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
