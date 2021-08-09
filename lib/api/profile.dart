import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/doctor.dart';

class ProfileServer {
  String authority = 'developers.thegraphe.com';
  String commonUnencodedPath = '/alodoctor/public/api';
  Details currentUserProfileDetails;
  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

// ****************************** post user Profile ********************
  Future<void> postUserPofileData(Details profileDetails) async {
    String token = await getToken();
    try {
      var response = await http
          .post(Uri.https(authority, commonUnencodedPath + "/update_profile"),
              body: jsonEncode({
                "name": profileDetails.name,
                "con_code": profileDetails.conCode,
                "phone": profileDetails.phone,
                "gender": profileDetails.gender,
                "dob":
                    "${profileDetails.dob.year.toString().padLeft(4, '0')}-${profileDetails.dob.month.toString().padLeft(2, '0')}-${profileDetails.dob.day.toString().padLeft(2, '0')}",
                "blood_group": profileDetails.bloodGroup,
                "marital_status": profileDetails.maritalStatus,
                "height": profileDetails.height,
                "weight": profileDetails.weight,
                "city": profileDetails.city,
                "state": profileDetails.state,
                "country": profileDetails.country,
                "lat": profileDetails.lat,
                "lng": profileDetails.lng,
                "cat_id": profileDetails.catId,
              }),
              headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer " + token,
          });
      var decodedBody = json.decode(response.body);
      print('after posting -------------$decodedBody');
    } catch (e) {
      throw e;
    }
  }

// ***************************** Post Profile Pic ************************
  Future<void> postProfilepic(File profilePic) async {
    String token = await getToken();
    String targethost = 'developers.thegraphe.com';
    String authorization = 'Bearer ' + token;
    var gettokenuri = Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/update_profile_pic',
        host: targethost);
    var request = new http.MultipartRequest("POST", gettokenuri);

    var stream = new http.ByteStream(profilePic.openRead());
    stream.cast();
    var length = await profilePic.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(profilePic.path));

    request.files.add(multipartFile);
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    try {
      var responses = await request.send();
      var response = await http.Response.fromStream(responses);
      final json = jsonDecode(response.body);
      print(json);
      if (json["success"] == 0) {
        print('error in profile pic---------------${json["error"]["file"][0]}');
        throw HttpException(json["error"]["file"][0]);
      }
    } catch (e) {
      print('throwed error in profile pic-------------------${e.toString()}');
      throw e;
    }
  }

// ******************************** getUSerProfile *******************
  Future<Details> getUserProfile() async {
    String token = await getToken();
    // SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .get(Uri.https(authority, commonUnencodedPath + "/details"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip, deflate, br',
      "Authorization": "Bearer " + token,
    });
    print('response in get userProfile--------------------${response.body}');
    var decodedData = jsonDecode(response.body);
    currentUserProfileDetails = Details.fromJson(decodedData['details']);
    // localStorage.setString(
    //     'userProfile', jsonEncode(currentUserProfileDetails.toJson()));

    return currentUserProfileDetails;
  }

// ************************************** get current user ************
  Future<Details> getCurrentUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Details userProfile =
        Details.fromJson(jsonDecode(localStorage.getString('userProfile')));
    print(userProfile);
    return userProfile;
  }
}
