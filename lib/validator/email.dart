import 'helper.dart';

class EmailFieldValidator {
  static String validate(String value){
    if (!Utils.isEmailValid(value) || value.isEmpty){
      return 'Email Tidak Valid';
    }
    return null;
  }
}