import 'package:PayFace/model/datadiri.dart';

class DataRepo {

    DataRepo();

  Future<bool> dataTambahan({
     String alamat,
     String notlp,
     String namalengkap

  }) async {
    var datatambahan = Profil()
    ..set('alamat', alamat)
    ..set('notelp', notlp)
    ..set('nama_lengkap', namalengkap);
    var response = await datatambahan.create();
    return response.success;
  }

}