import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:core';


const String keyClassUser = '_User';
const String tagID = 'id_foto_dataset';
const String userID = 'objectID';

class CariUser extends ParseObject implements ParseCloneable {
  
  CariUser() : super(keyClassUser);
  CariUser.clone() : this(); 

  @override 
  CariUser clone(Map<String, dynamic> map) => CariUser.clone()..fromJson(map);

  String get tagID => get<String>(tagID);
  set tagID(String tagID) => set<String>(tagID, tagID);

  String get userID => get<String>(userID);
  set userID(String userID) => set<String>(userID, userID);
  
}
