import 'package:equatable/equatable.dart';

abstract class DataDiriEvent extends Equatable{
  DataDiriEvent([List props = const[]]):super([props]);
}

class TombolSaveData extends DataDiriEvent{
 
  final String alamat;
  final String notlp;
  final String namalengkap;

  TombolSaveData({
    this.alamat,
    this.namalengkap,
    this.notlp,
  }): super([
    alamat,
    namalengkap,
    notlp,
  ]);

  @override
  String toString() => 'TombolSimpanData {alamat: $alamat, namalengkap: $namalengkap, notlp: $notlp}';
}