import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck {
  Future UserLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    print(email);
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = '2';
    map['device_token'] = '';

    var queryParameters = {
      'username': email,
      'password': password,
      'user_type': '2',
      'device_token': '',
    };
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https', path: '/alodoctor/public/api/login', host: targethost);
    print(gettokenuri);

    final response = await http.post(gettokenuri, body: map);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(response.body);
      prefs.setString('token', json['details']['token']);
      log('User token from Login ' + json['details']['token']);
      return json["success"];
    }
    return 0;
  }

  Future UserSignUp(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    print(email);
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = '2';
    map['c_password'] = password;
    map['device_token'] = '';

    var queryParameters = {
      'username': email,
      'password': password,
      'user_type': '2',
      'device_token': '',
    };
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/register',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri, body: map);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(response.body);
      prefs.setString('token', json['details']['token']);
      print(json['details']['token']);
      print('hey');
      print(json['details']['id']);
      return json["success"];
    }
    return 0;
  }

  Future setsub(List cat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String pass = "";
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    for (int i = 0; i < cat.length; i++) {
      if (i == 0) {
        pass = cat[i];
      } else {
        pass = pass + '* ' + cat[i];
      }
    }
    var map = new Map<String, dynamic>();
    map['sub_cat_ids'] = pass;

    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/doctor/doctors_subcategory',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri,
        body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["success"];
    }
    return 0;
  }

  Future Register(String gender, String dob, String name, String phone,
      String category, String concode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    String catid = await LoginCheck().getCatID(category);
    print(catid);
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['gender'] = gender;
    map['dob'] = dob;
    map['blood_group'] = "";
    map['marital_status'] = "";
    map['con_code'] = concode == '' ? "91" : concode;
    map['phone'] = phone;
    map['height'] = "";
    map['weight'] = "1";
    map['city'] = "kolkata";
    map['state'] = "wb";
    map['country'] = "india";
    map['lat'] = "22.2";
    map["lng"] = "22.2";
    map["cat_id"] = catid;
    map['device_token'] = '';

    print('inside');
    print(map);
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/update_profile',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri,
        body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.setString('name', name);
      final json = jsonDecode(response.body);
      return json["success"];
    }
    return 0;
  }

  Future SetFee(String fee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    var map = new Map<String, dynamic>();
    map['fee'] = fee;

    print('inside');
    print(map);
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/doctor/consultation_fee',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri,
        body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["success"];
    }
    return 0;
  }

  Future CreateSlot(List days, List Timings, int duration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    Map data = {
      'slots': [
        for (int i = 0; i < days.length; i++)
          {'date': days[i], 'time': Timings.join(',')}
      ]
    };
    // print(body);
    var map = new Map<String, dynamic>();
    map['slots'] = data;
    var maps = json.encode(map);
    print(maps);
    print('inside');
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/doctor/createslot',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri, body: maps, headers: {
      HttpHeaders.authorizationHeader: authorization,
      HttpHeaders.contentTypeHeader: "application/json"
    });
    print(response.body);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return json["success"];
    // }
    return 0;
  }

  Future DocUpload(File imageFile, int index) async {
    int succ;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    String targethost = 'developers.thegraphe.com';
    // var map = new Map<String, dynamic>();
    //
    // map['file'] = img != null
    //     ? 'data:image/png;base64,' + base64Encode(img.readAsBytesSync())
    //     : '';
    print(prefs.getString('token'));
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print(authorization);
    print('inside');
    var gettokenuri;
    if (index == 0) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/alodoctor/public/api/doctor/national_id_front/1',
          host: targethost);
      print(gettokenuri);
    } else if (index == 1) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/alodoctor/public/api/doctor/national_id_back/2',
          host: targethost);
      print(gettokenuri);
    } else if (index == 2) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/alodoctor/public/api/doctor/passport_front/3',
          host: targethost);
      print(gettokenuri);
    } else if (index == 3) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/alodoctor/public/api/doctor/passport_back/4',
          host: targethost);
      print(gettokenuri);
    } else {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/alodoctor/public/api/doctor/degree/5',
          host: targethost);
      print(gettokenuri);
    }

    var request = new http.MultipartRequest("POST", gettokenuri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    var responses = await request.send();
    var response = await http.Response.fromStream(responses);
    // final response = await http.post(gettokenuri,
    //     body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    // print(response.statusCode);
    final json = jsonDecode(response.body);
    print(json);
    print(response.statusCode);
    succ = json['success'];
    print(json['message']);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      succ = json['success'];
      print(json['message']);
      return succ;
    }
    return 0;
  }

  Future ProfilePicUpload(File imageFile) async {
    int succ;
    print('yo');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    String targethost = 'developers.thegraphe.com';
    // var map = new Map<String, dynamic>();
    //
    // map['file'] = img != null
    //     ? 'data:image/png;base64,' + base64Encode(img.readAsBytesSync())
    //     : '';
    print(prefs.getString('token'));
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print(authorization);
    print('inside');
    var gettokenuri;
    gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/update_profile_pic',
        host: targethost);
    print(gettokenuri);

    var request = new http.MultipartRequest("POST", gettokenuri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    var responses = await request.send();
    var response = await http.Response.fromStream(responses);
    // final response = await http.post(gettokenuri,
    //     body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    // print(response.statusCode);
    final json = jsonDecode(response.body);
    print(json);
    print(response.statusCode);
    succ = json['success'];
    print(json['message']);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      succ = json['success'];
      print(json['message']);
      return succ;
    }
    return 0;
  }

  Future<Doctor> UserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    var map = new Map<String, dynamic>();
    map['user_type'] = '2';
    map['device_token'] = '';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/details',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(response.body);
      return Doctor.fromJson(json);
    } else {
      throw Exception('Failed to get Doctor Info');
    }
  }

  Future<List<String>> getCategories() async {
    int index;
    List<String> categories = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';

    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/categories',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['categories'].length; i++) {
        categories.add(json['categories'][i]['name']);
      }
    }
    return categories;
  }

  Future<String> getCatID(String category) async {
    int index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String subCat;
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/categories',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['categories'].length; i++) {
        if (json['categories'][i]['name'] == category) {
          index = i;
        }
      }

      subCat = json['categories'][index]["id"].toString();
      print(subCat);
    }
    return subCat;
  }

  Future<List<String>> getSub(String category) async {
    int index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    List<String> subCat = [];
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/categories',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['categories'].length; i++) {
        if (json['categories'][i]['name'] == category) {
          index = i;
        }
      }
      for (int i = 0;
          i < json['categories'][index]["subcategories"].length;
          i++) {
        subCat.add(json['categories'][index]["subcategories"][i]['name']);
      }
      print(subCat);
    }
    return subCat;
  }

  Future<List<int>> getSubId(String category) async {
    int index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    List<int> subCat = [];
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/categories',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['categories'].length; i++) {
        if (json['categories'][i]['name'] == category) {
          index = i;
        }
      }
      for (int i = 0;
          i < json['categories'][index]["subcategories"].length;
          i++) {
        subCat.add(json['categories'][index]["subcategories"][i]['id']);
      }
      print(subCat);
    }
    return subCat;
  }
}
