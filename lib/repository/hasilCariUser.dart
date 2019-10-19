import 'package:PayFace/model/rekening.dart';
import 'package:PayFace/model/rekening.dart' as rekening;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:PayFace/model/cariUser.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:PayFace/repository/rekening_repo.dart';

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
  String alamatPenerima;
  String emailPenerima;
  String usernamePenerima;
  String namaLengkapPenerima;
  String objectIdPenerima;
  String noTelpPenerima;
  
  UserQuery({
    this.alamatPenerima, 
    this.emailPenerima, 
    this.namaLengkapPenerima, 
    this.usernamePenerima,
    this.objectIdPenerima,
    this.noTelpPenerima,        
  });

  factory UserQuery.fromJson(Map<String, dynamic> json){
    return new UserQuery (
      objectIdPenerima: json['objectId'],
      alamatPenerima: json['alamat'],
      emailPenerima: json['email'],
      namaLengkapPenerima: json['nama_lengkap'],
      usernamePenerima: json['username'],
      noTelpPenerima: json['notelp'],
    );
  }
}

Future <void> hasilCariQuery() async {
  String tagIDHasil;

  final pref = await SharedPreferences.getInstance();
  pref.reload();
  tagIDHasil = pref.getString('tagHasil');
  print("Tag Hasil = "+"$tagIDHasil");

  final QueryBuilder<CariUser> query = QueryBuilder<CariUser>(CariUser())
                  ..regEx(tagID, "$tagIDHasil");
  final response = await query.query();
  print(response.result);
  
  //print(dataList.listUser[0].objectIdPenerima);
  if(response.result == null || response.result == "null"){
    print("Data Tidak Ditemukan Di Server");
    pref.setInt('valueRecog', 0);
    print("hasil = "+pref.getInt('valueRecog').toString());

  }else{
    final data = json.decode(response.result.toString());
    ListCariUser dataList = ListCariUser.fromJson(data);

    pref.setString('objectIdPenerima', dataList.listUser[0].objectIdPenerima);
    pref.setString('alamatPenerima', dataList.listUser[0].alamatPenerima);
    pref.setString('namaLengkapPenerima', dataList.listUser[0].namaLengkapPenerima);
    pref.setString('emailPenerima', dataList.listUser[0].emailPenerima);
    pref.setString('usernamePenerima', dataList.listUser[0].usernamePenerima);
    pref.setString('notelpPenerima', dataList.listUser[0].noTelpPenerima);

    String objectIdPenerima = pref.getString('objectIdPenerima');
    String usernamePenerima = pref.getString('usernamePenerima');
    
    print('ID = '+"$objectIdPenerima"+", Username = "+"$usernamePenerima");
    pref.setInt('valueRecog', 1);

    hasilCariRek();

  }
}

Future <void> hasilCariRek() async {
  String objectIdPenerima;

  var pref = await SharedPreferences.getInstance();
  objectIdPenerima = pref.getString('objectIdPenerima');

  final QueryBuilder<RekUser> query = QueryBuilder<RekUser>(RekUser())
                ..regEx(rekening.userID, "$objectIdPenerima");
  final response = await query.query();
  print(response.result);

  final data = json.decode(response.result.toString());
  if(response.result == null){
    print("Data Tidak Ditemukan Di Server");
    print(response.error);
    print(objectIdPenerima);
  }else{
    ListHasilRek dataList = ListHasilRek.fromJson(data);
    
    pref.setString('userRekIdPenerima', dataList.rekening[0].objectIDRek);
    pref.setString('noRekUserPenerima', dataList.rekening[0].noRek);
    pref.setInt('saldoPenerima', dataList.rekening[0].saldo);

    String userRekPenerima = pref.getString('userRekIdPenerima');
    String noRekUserPenerima = pref.getString('noRekUserPenerima');
    int saldo = pref.getInt('saldoPenerima');

    print('Menyimpan Data Pada Devices....');
    print('UserRekening = '+"$userRekPenerima"+", No Rekening = "+"$noRekUserPenerima"+", Saldo = "+"$saldo");
  }
}