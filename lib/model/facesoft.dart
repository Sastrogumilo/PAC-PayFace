import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

final String baseUrl = "https://api.facesoft.io/v1/";
final String createTag = "face/tags";
final String uploadImage = "face/tags/image";
final String faceRecog = "face/tags/find";

//"apikey":"rc5ayz8azvp-i6q470w73i" => lama
Map<String, String> headers = {"apikey":"2qcrg70r3so-r2h4lp1vf1", "Content-Type" : "application/json"};
Client client = Client();

class Tags{
  String tagID;
  Tags({this.tagID});
  
  factory Tags.fromJson(Map<String, dynamic> parsedJson) {
    return Tags(tagID: parsedJson['tagID']);
  }
}
class GagalUpload{
  String error;
  GagalUpload({this.error});

  factory GagalUpload.fromJson(Map<String, dynamic> parsedJson) {
    return GagalUpload(error: parsedJson['error']);
  }
}

class GagalRecognise{
  String error;
  GagalRecognise({this.error});

  factory GagalRecognise.fromJson(Map<String, dynamic> parsedJson) {  
    return GagalRecognise(error: parsedJson['error']);
  }
}

class ListHasilRecog{
  final List<Hasil> recog; 
  ListHasilRecog({this.recog});

  factory ListHasilRecog.fromJson(List<dynamic> parsedJson) {
    List<Hasil> recog = new List<Hasil>();
    recog = parsedJson.map((f)=>Hasil.fromJson(f)).toList();
    return new ListHasilRecog(recog: recog);
  }
  
}

class Hasil{
  double confidence;
  String tagID;
  Hasil({this.confidence, this.tagID});
  
  factory Hasil.fromJson(Map<String, dynamic> json){
    return new Hasil (confidence: json['confidence'],
                      tagID: json['tagID']);
  }
  
}

//tagData(String jsonData) async {
//  var pref = await SharedPreferences.getInstance();
//  final data = json.decode(jsonData);
//  Tags tags = new Tags.fromJson(data);
//  pref.setString('tagID', tags.tagID);
//  print(tags.tagID);
//}


Future getTags() async {
  var pref = await SharedPreferences.getInstance();
  final response = await client.post("$baseUrl"+"$createTag", headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Tags tags = new Tags.fromJson(data);
      pref.setString('tagID', tags.tagID);
      print(tags.tagID);
    } else {
      return null;
    }
}

Future uploadGambar() async {
  String image1;
  String tagID;
  var pref = await SharedPreferences.getInstance();
  tagID = pref.getString('tagID');
  image1 = pref.getString('image1');
  Map<String, String> bodyUpload = {"tagID" :"$tagID", "image1" : "$image1"};
  String body = jsonEncode(bodyUpload);

  final response = await client.post("$baseUrl" + "$uploadImage", headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode >= 400){
      print(bodyUpload);
      final data = json.decode(response.body);
      GagalUpload error = new GagalUpload.fromJson(data);
      print(error.error);
    }

}

Future faceRecognition() async {
  String imageRecog;
  String tagAwal;
  String tagHasil;
  var pref = await  SharedPreferences.getInstance();
  imageRecog = pref.getString('imageRecog');
  Map<String, String> bodyUpload = {"image1" : "$imageRecog"};
  String body = jsonEncode(bodyUpload);

  final response = await client.post("$baseUrl" + "$faceRecog", headers: headers, body: body);
  print(response.statusCode);
  if(response.statusCode >= 400) {
    print(bodyUpload);
    final dataGagal = json.decode(response.body);
    GagalRecognise error = new GagalRecognise.fromJson(dataGagal);
    print(error.error); //No Face Found
  } else {
    final dataSukses = json.decode(response.body);
    print('respon = '+response.body); // => [{}]
    ListHasilRecog dataList = ListHasilRecog.fromJson(dataSukses);
    pref.setDouble('confidence', dataList.recog[0].confidence);
    pref.setString('tagHasil', dataList.recog[0].tagID);
    print('tagID: '+dataList.recog[0].tagID+', confidence: '+dataList.recog[0].confidence.toString());
    
    tagHasil = pref.getString('tagHasil'); // Get Data tagHasil
    tagAwal = pref.getString('tagID'); // Get Data tagAwal

    if (tagAwal == tagHasil) {
      print("Ini Wajah Anda");
    } else {
      print("Ini Bukan Wajah Anda atau Wajah Tidak Dikenal");
    }
  }
}


