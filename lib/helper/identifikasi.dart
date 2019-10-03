import 'package:PayFace/model/profil.dart';
import 'package:http/http.dart' show Client;

Map<String, String> headers = { 
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "<Your token>"
  };


class ApiServiceUser {
  
  
  final String baseUrl = "https://payface.back4app.io";
  Client client = Client();

  Future getProfiles() async {
    final response = await client.get("$baseUrl/classes/User", headers: headers);
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      "$baseUrl/api/profile/${data.id}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}