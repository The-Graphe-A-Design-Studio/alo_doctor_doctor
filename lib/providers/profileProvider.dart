import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/profile.dart';
import '../models/doctor.dart';
import '../utils/MyConstants.dart';

class ProfileProvider with ChangeNotifier {
  ProfileServer serverHandler = ProfileServer();

  Details _userProfileDetails;

  void setProfile() async {
    _userProfileDetails = await serverHandler.getUserProfile();
    notifyListeners();
    print('in Provider---------$_userProfileDetails');
  }

  void postProfileData(user) async {
    await serverHandler.postUserPofileData(user);
    _userProfileDetails = user;
    notifyListeners();
  }

  void postProfilePic(File pic) async {
    try {
      await serverHandler.postProfilepic(pic);
      var user = await serverHandler.getUserProfile();
      _userProfileDetails = user;
      notifyListeners();
    } catch (e) {
      print('in profile provider ${e.toString()}');
      throw e;
    }
  }

  String get getUserName {
    return _userProfileDetails.name;
  }

  Details get currentUser {
    // print(
    //     'current user profile pic path ----- ${_userProfileDetails.profilePicPath}');

    return _userProfileDetails;
  }

  void logOut(context) async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    localstorage.clear();
    _userProfileDetails = null;
    Navigator.pushNamed(context, signIn);
  }
}
