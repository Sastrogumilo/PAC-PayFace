import 'package:equatable/equatable.dart';

abstract class DataDiriEvent extends Equatable{
  DataDiriEvent([List props = const[]]):super([props]);
}

class TombolSaveData extends DataDiriEvent{
 
  final String alamat;
  final String notlp;
  final String namalengkap;
  final String email;
  final String password;
  final String username;

  TombolSaveData({
    this.alamat,
    this.namalengkap,
    this.notlp,
    this.email,
    this.password,
    this.username,
    
  }): super([
    alamat,
    namalengkap,
    notlp,
    email,
    password,
    username,
  ]);

  @override
  String toString() => 'TombolSimpanData {alamat: $alamat, namalengkap: $namalengkap, notlp: $notlp, email: $email, password: $password, username: $username}';
}