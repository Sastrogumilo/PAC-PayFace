import 'dart:convert';


class Profile {
  String id;
  String name;
  String alamat;
  String notelp;
 

  Profile({this.id, this.name, this.alamat, this.notelp});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["objectId"], name: map["nama_lengkap"], alamat: map["alamat"], notelp: map["notelp"]);
  }

  Map<String, dynamic> toJson() {
    return {"objectId": id, "username": name, "alamat": alamat, };
  }

  @override
  String toString() {
    return 'Profile{id: $id, username: $name, email: $alamat,}';
  }

}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}