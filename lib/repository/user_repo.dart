import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:meta/meta.dart';

abstract class BaseUserRepo {

  Future<ParseUser> authenticate({String username, @required String email, @required String password});
  Future<ParseUser> register({@required String username, @required String email, @required String password,});
  Future<ParseUser> currentUser();
  Future<bool> logout();
  Future<ParseObject> dataTambahan({@required String alamat, @required String namalengkap, @required String notlp});
  Future<ParseObject> rekening({@required String norek, @required String pin});
  
}

class UserRepo extends BaseUserRepo {

  UserRepo();
  
  Future<ParseUser> authenticate({
    String username,
    @required String password,
    @required String email,
    
  }) async {
    var user = ParseUser(username, password, email);
    var response = await user.login();
    if (response.success)
      return response.result;
    return null;
  } //End auth

  Future<ParseUser> register({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    var user = ParseUser(username, password, email);
    var result = await user.save();
    if (result.success) {
      return user;
    }
    return null;
  }// Register

  Future<ParseUser> currentUser() async {
    return await ParseUser.currentUser();
  }

  Future<bool> logout() async {
    ParseUser user = await ParseUser.currentUser();
    var result = await user.logout();
    return result.success;
  }


  Future<ParseObject> rekening({
    @required String norek,
    @required String pin,

  }) async {
    var datarek = ParseObject('Rekening')
        ..set('no_rekening', norek)
        ..set('pin', pin);
        await datarek.save();
    var response = await datarek.save();
        if (response.success) {
          return response.result;
        }
        return null;
      }

    Future<ParseObject> dataTambahan({
    @required String alamat,
    @required String notlp,
    @required String namalengkap

  }) async {
    var datatambahan = ParseObject('User');
    datatambahan.set<String>('alamat', alamat);
    datatambahan.set<String>('notelp', notlp);
    datatambahan.set<String>('nama_lengkap', namalengkap);
    var response = await datatambahan.create();
    if (response.success && response.result != null) {
      response.result.toString();
    }
    return null;
  }
    
  }
 
