import 'package:parse_server_sdk/parse_server_sdk.dart';

const String _keyTableName = '_User';
const String keyNama= 'nama_lengkap';
const String keyAlamat= 'alamat';
const String keyTelp= 'notelp';
const String keyUser = 'username';
const String keyID = 'objectId';

class Profil extends ParseObject implements ParseCloneable{

  Profil(): super(_keyTableName);

  Profil.clone(): this();


  @override clone(Map map) => Profil.clone()..fromJson(map);


  String get nama => get<String>(keyNama);
  String get alamat => get<String>(keyAlamat);
  String get telp => get<String>(keyTelp);
  String get objId => get<String>(keyID);
  
  set nama(String nama) => set<String>(keyNama, nama); 
  set alamat(String alamat) => set<String>(keyAlamat, alamat);
  set telp(String telp) => set<String>(keyTelp, telp);
  set objId(String objId) => set<String>(keyID, objId);

  ParseUser get user => get<ParseUser>(keyUser);
  set user(ParseUser user) => set<ParseUser>(keyUser, user);   
}
