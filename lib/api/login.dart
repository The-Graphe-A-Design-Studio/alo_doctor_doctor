import 'dart:convert';
import 'dart:io';

import 'package:alo_doctor_doctor/models/userInfo.dart';
import 'package:http/http.dart' as http;

class LoginCheck {
  Future<bool> UserLogin(String email, String password) async {
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
      print(response.body);
      return json["success"];
    }
    return false;
  }

  Future<List<Userdata>> UserInfo() async {
    var url = new Uri(
        scheme: 'http',
        host: '13.81.60.251',
        port: 5013,
        path: '/api/user/GetUsers');
    String authorization = 'Bearer ';
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: authorization});
    List<Userdata> userinfo = [];
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(response.body);
      for (var userjson in json['result']) {
        userinfo.add(Userdata.fromJson(userjson));
      }
    }
    return userinfo;
  }
}
