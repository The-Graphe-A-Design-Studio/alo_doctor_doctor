import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck {
  Future UserLogin(String email, String password) async {
    String dtoken = await FirebaseMessaging.instance.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    print(email);
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = '2';
    map['device_token'] = dtoken ?? "";

    var queryParameters = {
      'username': email,
      'password': password,
      'user_type': '2',
      'device_token': '',
    };
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/login',
        host: targethost);
    print(gettokenuri);

    final response = await http.post(gettokenuri, body: map);
    print(response.statusCode);

    // ---------
    Map<String, dynamic> result = {
      'success': 0,
      "update": prefs.getInt('update'),
      'error': "",
    };
    final json = jsonDecode(response.body);

    if (json["success"] == 1) {
      final json = jsonDecode(response.body);
      prefs.setString('token', json['details']['token']);

      // -----------
      result['success'] = 1;

      var currentUserProfileDetails = await UserInfo();
      // print('name---${currentUserProfileDetails.details.name}');

      if (currentUserProfileDetails["name"] != null) {
        result['update'] = 1;
        print("user name null");
        prefs.setInt('update', 1);
      }
      print('update details-------${prefs.getInt('update')}');

      return result;
      // return json["success"];
    }
    result["error"] = "Unautorised";
    return result;
  }

  Future UserSignUp(String email, String password) async {
    String dtoken = await FirebaseMessaging.instance.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    print(email);
    print(password);
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = '2';
    map['c_password'] = password;
    map['device_token'] = dtoken ?? "";

    var queryParameters = {
      'username': email,
      'password': password,
      'user_type': '2',
      'device_token': '',
    };
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/register',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri, body: map);
    print(response.body);
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
    print("subcategory----------------------");
    print(cat);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String pass = "";
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    for (int i = 0; i < cat.length; i++) {
      if (i == 0) {
        pass = cat[i];
        print(cat[i]);
      } else {
        pass = pass + '* ' + cat[i];
      }
      print(pass);
    }
    var map = new Map<String, dynamic>();
    map['sub_cat_ids'] = pass;

    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/doctors_subcategory',
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

  Future<int> Register(
      String gender,
      String dob,
      String name,
      String qualification,
      String exp,
      String phone,
      String category,
      String concode) async {
    String dtoken = await FirebaseMessaging.instance.getToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    String catid = await LoginCheck().getCatID(category);
    print('cat id-------------$catid');
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
    map['doc_qualification'] = qualification;
    map['doc_experience'] = exp;
    map['state'] = "wb";
    map['country'] = "india";
    map['lat'] = "22.2";
    map["lng"] = "22.2";
    map["cat_id"] = catid;
    map['device_token'] = dtoken ?? "";

    print('inside');
    print(map);
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/update_profile',
        host: targethost);
    print(gettokenuri);
    final response = await http.post(gettokenuri,
        body: map, headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // prefs.setString('name', name);
      prefs.setInt('update', 1);

      final json = jsonDecode(response.body);
      return json["success"];
    }
    return 0;
  }

  // *********************************** Forget password **************
  Future<dynamic> forgetPassword(String email) async {
    try {
      String targethost = 'www.alodoctor-care.com';
      var map = new Map<String, dynamic>();
      map['email'] = email;
      map['user_type'] = "2";
      print('inside');
      print(map);
      var gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/forgot_password',
          host: targethost);
      print(gettokenuri);
      final response = await http.post(gettokenuri, body: map);
      print(response.body);
      print(response.statusCode);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return json;
      } else {
        throw json["error"];
      }
    } catch (e) {
      print('error in forget password ------$e');
      throw e.toString() ==
              "This email account that you tried to reach does not exist."
          ? e.toString()
          : "Something went wrong, try again.";
    }
  }

  // *********************************** Verify OTP **************
  Future<dynamic> verifyOtp(int otp, int userId) async {
    try {
      String targethost = 'www.alodoctor-care.com';

      print('inside');
      var gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/verify_code/$userId/$otp',
          host: targethost);
      print(gettokenuri);
      final response = await http.put(gettokenuri);
      print(response.body);
      print(response.statusCode);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return json;
      } else {
        throw json["error"];
      }
    } catch (e) {
      print('error in forget password ------$e');
      throw e.toString() == "Wrong verification code."
          ? e.toString()
          : "Something went wrong, try again.";
    }
  }

  // *********************************** Change password **************
  Future<dynamic> changePassword(
      int userId, int password, int cpassword) async {
    try {
      String targethost = 'www.alodoctor-care.com';
      var map = new Map<String, dynamic>();
      map['user_id'] = '$userId';
      map["password"] = '$password';
      map["c_password"] = '$cpassword';
      map['user_type'] = "2";
      print('inside');
      print(map);
      var gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/change_password',
          host: targethost);
      print(gettokenuri);
      final response = await http.post(gettokenuri, body: map);
      print(response.body);
      print(response.statusCode);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return json;
      } else {
        throw json["error"];
      }
    } catch (e) {
      print('error in forget password ------$e');
      throw e.toString();
    }
  }

  Future SetFee(String fee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    var map = new Map<String, dynamic>();
    map['fee'] = fee;

    print('inside');
    print(map);
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/consultation_fee',
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

  Future setFeesPeriod(String period) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    var map = new Map<String, dynamic>();
    map['period'] = period;

    print('inside');
    print(map);
    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/fees_period',
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
    String targethost = 'www.alodoctor-care.com';
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
        path: '/app-backend/public/api/doctor/createslot',
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
    String targethost = 'www.alodoctor-care.com';
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
          path: '/app-backend/public/api/doctor/national_id_front/1',
          host: targethost);
      print(gettokenuri);
    } else if (index == 1) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/doctor/national_id_back/2',
          host: targethost);
      print(gettokenuri);
    } else if (index == 2) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/doctor/passport_front/3',
          host: targethost);
      print(gettokenuri);
    } else if (index == 3) {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/doctor/passport_back/4',
          host: targethost);
      print(gettokenuri);
    } else {
      gettokenuri = new Uri(
          scheme: 'https',
          path: '/app-backend/public/api/doctor/degree/5',
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
    String targethost = 'www.alodoctor-care.com';
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
        path: '/app-backend/public/api/update_profile_pic',
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

  // Future PrescriptionUpload(List imageFile, String Id) async {
  //   int succ;
  //   // print('yo');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String targethost = 'www.alodoctor-care.com';
  //   // var map = new Map<String, dynamic>();
  //   //
  //   // map['file'] = img != null
  //   //     ? 'data:image/png;base64,' + base64Encode(img.readAsBytesSync())
  //   //     : '';
  //   // print(prefs.getString('token'));
  //   String token = prefs.getString('token');
  //   String authorization = 'Bearer ' + token;
  //   // print(authorization);
  //   print('inside');
  //   var gettokenuri;
  //   gettokenuri = new Uri(
  //       scheme: 'https',
  //       path: '/app-backend/public/api/doctor/prescription/' + Id,
  //       host: targethost);
  //   print(gettokenuri);

  //   var request = new http.MultipartRequest("POST", gettokenuri);
  //   List<MultipartFile> newList = [];
  //   for (int i = 0; i < imageFile.length; i++) {
  //     var stream = new http.ByteStream(imageFile[i].openRead());
  //     stream.cast();
  //     var length = await imageFile[i].length();
  //     var multipartFile = new http.MultipartFile("file[]", stream, length,
  //         filename: basename(imageFile[i].path));
  //     newList.add(multipartFile);
  //   }
  //   request.files.addAll(newList);
  //   request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  //   request.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
  //   var responses = await request.send();
  //   var response = await http.Response.fromStream(responses);
  //   // final response = await http.post(gettokenuri,
  //   //     body: map, headers: {HttpHeaders.authorizationHeader: authorization});
  //   // print(response.statusCode);
  //   final json = jsonDecode(response.body);
  //   print(json);
  //   print(response.statusCode);
  //   succ = json['success'];
  //   print(json['message']);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     succ = json['success'];
  //     print(json['message']);
  //     return succ;
  //   }
  //   return 0;
  // }

  Future PrescriptionUpload(List selectedFiles, String Id) async {
    int succ;
    // print('yo');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String targethost = 'www.alodoctor-care.com';
    // var map = new Map<String, dynamic>();
    //
    // map['file'] = img != null
    //     ? 'data:image/png;base64,' + base64Encode(img.readAsBytesSync())
    //     : '';
    // print(prefs.getString('token'));
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    // print(authorization);
    print('inside');
    var gettokenuri;
    gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/prescription/' + Id,
        host: targethost);
    print(gettokenuri);

    var request = new http.MultipartRequest("POST", gettokenuri);
    List<MultipartFile> newList = [];
    for (int i = 0; i < selectedFiles.length; i++) {
      var stream = new http.ByteStream(selectedFiles[i].openRead());
      stream.cast();
      var length = await selectedFiles[i].length();
      var multipartFile = new http.MultipartFile("file[]", stream, length,
          filename: basename(selectedFiles[i].path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    try {
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
    } catch (e) {
      throw "Something went wrong";
    }
  }

  // ****************************** Delete files from prescription
  Future<dynamic> deletePrescription(int bookingId, String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';

    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path:
            '/app-backend/public/api/doctor/prescription/$bookingId/$fileName',
        host: targethost);
    print(gettokenuri);

    final response = await http.delete(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    var decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return decodedData["success"];
    } else {
      throw HttpException("Error Deleting files, try again later");
    }
  }

  Future<dynamic> UserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    var map = new Map<String, dynamic>();
    map['user_type'] = '2';
    map['device_token'] = '';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/details',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body + "userinfo");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print("inside userinfo");
      // if (json["details"]["name"] == null) {
      //   return json["details"];
      // }
      return json["details"];
      // return Doctor.fromJson(json).details;
    } else {
      throw Exception('Failed to get Doctor Info');
    }
  }

  Future<List<String>> getCategories() async {
    int index;
    List<String> categories = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';

    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/categories',
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
    String targethost = 'www.alodoctor-care.com';
    String subCat;
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/categories',
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
    String targethost = 'www.alodoctor-care.com';
    List<String> subCat = [];
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/categories',
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
      print("subcat successful $subCat");
    }
    return subCat;
  }

  Future<List<int>> getSubId(String category) async {
    int index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    List<int> subCat = [];
    String token = prefs.getString('token');
    print('hey');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/categories',
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

  Future<dynamic> getMyBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/mybookings',
        host: targethost);

    try {
      final response = await http.get(gettokenuri,
          headers: {HttpHeaders.authorizationHeader: authorization});
      var decodedData = jsonDecode(response.body);
      // print(response.body);

      if (decodedData['success'] == 1) {
        return decodedData['bookings'];
      } else {
        throw HttpException(decodedData["message"]);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getBookingsById(int bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';
    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/doctor/bookingbyid/$bookingId',
        host: targethost);

    try {
      final response = await http.get(gettokenuri,
          headers: {HttpHeaders.authorizationHeader: authorization});
      var decodedData = jsonDecode(response.body);
      print(response.body);

      if (decodedData['success'] == 1) {
        return decodedData['booking'];
      } else {
        throw HttpException(decodedData["message"]);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // ****************************** LogOut
  Future<dynamic> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targethost = 'www.alodoctor-care.com';

    String token = prefs.getString('token');
    String authorization = 'Bearer ' + token;
    print('inside');

    var gettokenuri = new Uri(
        scheme: 'https',
        path: '/app-backend/public/api/logout',
        host: targethost);
    print(gettokenuri);

    final response = await http.get(gettokenuri,
        headers: {HttpHeaders.authorizationHeader: authorization});
    print(response.body);
    print(response.statusCode);
    var decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return decodedData["success"];
    } else {
      throw HttpException("Error Logging out.");
    }
  }
}
