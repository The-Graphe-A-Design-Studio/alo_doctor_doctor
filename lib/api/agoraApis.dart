import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alo_doctor_doctor/models/ServerSlots.dart';
import 'package:alo_doctor_doctor/models/Slots.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgoraApis {
  String authority = 'developers.thegraphe.com';
  String commonUnencodedPath = '/alodoctor/public/api';

  Future getAgoraToken(String channelName, String pUid, String bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Map tokenData = {
        'channel_name': channelName,
        'p_uid': pUid,
        'booking_id': bookingId
      };
      log(prefs.getString('token'));
      String token = prefs.getString('token');
      String authorization = 'Bearer ' + token;
      var response = await http.post(
          Uri.https(
              authority, commonUnencodedPath + "/doctor/createjoin_channel"),
          headers: {HttpHeaders.authorizationHeader: authorization},
          body: tokenData);
      var body = json.decode(response.body);
      log('Body ' + response.body);
      if (body['success'] == 1 || body['success'] == 2) {
        log('Token ' + body['channel']['access_token']);
        return body;
      } else
        throw HttpException(json.decode(response.body)['error']);
    } on HttpException catch (e) {
      print(e);
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future leaveChannel(String channelId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'developers.thegraphe.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/leave_channel/$channelId',
        host: targethost);
    print(gettokenuri);

    final response = await http.put(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      log('Channel Left');
      return body;
    } else {
      throw Exception('Unable to leave Channel');
    }
  }

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  Future createSlots(var slots) async {
    String token = await getToken();
    print("Slots from API " + slots);
    try {
      var response = await http.post(
          Uri.https(authority, commonUnencodedPath + "/doctor/createslot"),
          body: json.encode({"slots": slots}),
          headers: {
            "Authorization": "Bearer " + token,
            "Content-type": "application/json"
          });
      if (jsonDecode(response.body)["success"] == 1) {
        var decodedBody = json.decode(response.body).toString();
        print(decodedBody);
        return decodedBody;
      } else {
        throw HttpException('Something Went Wrong');
      }
    } catch (e) {
      throw e;
    }
  }

  Future deleteSlot(String id) async {
    String token = await getToken();
    // print("Slots from API " + slots);
    try {
      var response = await http.delete(
          Uri.https(authority, commonUnencodedPath + "/doctor/slot/"+id),
          headers: {
            "Authorization": "Bearer " + token,
            "Content-type": "application/json"
          });
      if (jsonDecode(response.body)["success"] == 1) {
        var decodedBody = json.decode(response.body);
        print(decodedBody);
        return decodedBody;
      } else {
        throw HttpException('Something Went Wrong');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<ServerSlots> getSlots() async {
    String token = await getToken();
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/alodoctor/public/api/doctor/allslots',
        host: authority);
    print(gettokenuri);
    try {
      final response = await http.get(gettokenuri, headers: {
        HttpHeaders.authorizationHeader: authorization,
        "Content-type": "application/json"
      });
      print(response.body);
      print(response.statusCode);
      final json = jsonDecode(response.body);

      if (json['success'] == 1) {
        print('JSON' + json.toString());
        ServerSlots slots = ServerSlots.fromJson(json);
        return slots;
      } else {
        throw HttpException(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      throw e;
    }
  }



}
