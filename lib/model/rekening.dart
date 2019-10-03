import 'package:parse_server_sdk/parse_server_sdk.dart';

const String _keyTableName = '_User';
const String keyRek= 'rekening';
const String keyPin= 'pin';
const String keySaldo= 'saldo';
const String keyUserId = 'user_id';

class Rekening extends ParseObject implements ParseCloneable{

  Rekening(): super(_keyTableName);
  Rekening.clone(): this();


  @override clone(Map map) => Rekening.clone()..fromJson(map);

  String get rekening => get<String>(keyRek);
  String get pinrek => get<String>(keyPin);
  String get saldo => get<String>(keySaldo);
  
  set rekening(String nama) => set<String>(keyRek, nama); 
  set pinrek(String alamat) => set<String>(keyPin, alamat);
  set saldo(String telp) => set<String>(keySaldo, telp);
  
}
