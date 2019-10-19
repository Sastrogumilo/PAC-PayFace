import 'package:shared_preferences/shared_preferences.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:PayFace/model/cariUser.dart';
import 'dart:convert';
import 'dart:async' show Future;

class ListCariUser{
  final List<UserQuery> listUser; 

  ListCariUser({this.listUser});

  factory ListCariUser.fromJson(List<dynamic> parsedJson) {

    List<UserQuery> listUser = new List<UserQuery>();
    listUser = parsedJson.map((f)=>UserQuery.fromJson(f)).toList();

    return new ListCariUser(listUser: listUser);
  }
  
}

class UserQuery{
  String noRek;
  String objectIDRek;
  int saldo;
  
  UserQuery({this.noRek, this.objectIDRek, this.saldo});

  factory UserQuery.fromJson(Map<String, dynamic> json){
    return new UserQuery (
                          noRek: json['no_rekening'],
                          objectIDRek: json['objectId'],
                          saldo: json['saldo'],
                        );
  }
  
}

Future <void> hasilCariQuery() async {
String tagIDHasil;

var pref = await SharedPreferences.getInstance();
tagIDHasil = pref.getString('tagHasil');

final QueryBuilder<CariUser> query = QueryBuilder<CariUser>(CariUser())
                ..regEx(tagID, "$tagIDHasil");
  final response = await query.query();
  print(response.result);

  final data = json.decode(response.result.toString());
  
  ListCariUser dataList = ListCariUser.fromJson(data);

  print(dataList.listUser[0].objectIDRek);
  //pref.setString('userRekID', dataList.rekening[0].objectIDRek);
  //pref.setString('noRekUser', dataList.rekening[0].noRek);
  //pref.setInt('saldo', dataList.rekening[0].saldo);

  //String userRek = pref.getString('userRekID');
  //String noRekUser = pref.getString('noRekUser');
  //int saldo = pref.getInt('saldo');

  //print('UserRekening = '+"$userRek"+", No Rekening = "+"$noRekUser"+", Saldo = "+"$saldo");


}