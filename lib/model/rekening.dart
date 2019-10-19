import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:core';


const String keyRekening = 'Rekening';
const String noRek = 'no_rekening';
const String userID = 'user_id';

class RekUser extends ParseObject implements ParseCloneable {
  
  RekUser() : super(keyRekening);
  RekUser.clone() : this(); 

  @override 
  RekUser clone(Map<String, dynamic> map) => RekUser.clone()..fromJson(map);

  String get noRek => get<String>(noRek);
  set noRek(String noRek) => set<String>(noRek, noRek);

  String get userID => get<String>(userID);
  set userID(String userID) => set<String>(userID, userID);
  
}