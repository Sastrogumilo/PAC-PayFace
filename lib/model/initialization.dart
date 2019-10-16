import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

//{"className":"_User",
//"objectId":"xsTU4wK2Cw",
//"createdAt":"2019-09-29T05:02:44.588Z",
//"updatedAt":"2019-09-29T18:50:16.295Z",
//"username":"aaaaa","password":"12345",
//"email":"a5@email.com",
//"emailVerified":false,
//"alamat":"",
//"ACL":{"*":{"read":true},"xsTU4wK2Cw":{"read":true,"write":true}},
//"sessionToken":"r:2fe804ba442803a55da648e9e4f768e5"} => current user

class UserSaatIni{
  String objectID;
  String username;
  String email;

  UserSaatIni({this.objectID, this.username, this.email});

  factory UserSaatIni.fromJson(Map<String, dynamic> parsedJson){
    return UserSaatIni(objectID: parsedJson['objectId'],
                        username: parsedJson['username'],
                        email: parsedJson['email'],
                      );
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

  //String objectID = pref.getString('objectID');
  //String username = pref.getString('username');
  //String email = pref.getString('email');
  print(data);
  //print(objectID);
}
