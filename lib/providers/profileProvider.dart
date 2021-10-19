import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/profile.dart';
import '../models/doctor.dart';
import '../utils/MyConstants.dart';
import '../api/login.dart';

class ProfileProvider with ChangeNotifier {
  ProfileServer serverHandler = ProfileServer();

  Details userProfileDetails = Details();

  void setProfile() async {
    userProfileDetails = await serverHandler.getUserProfile();
    notifyListeners();
    print('in Provider---------$userProfileDetails');
  }

  Future<void> postProfileData(user) async {
    try {
      var response = await serverHandler.postUserPofileData(user);
      if (response["success"] == 1) {
        userProfileDetails = user;
        notifyListeners();
      } else {
        throw HttpException(
            'Something went wrong, Please make sure all the fields are filled.');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> postProfilePic(File pic) async {
    try {
      imageCache.clear();
      String picPath = await serverHandler.postProfilepic(pic);

      var nowParam = DateFormat('yyyyddMMHHmmss').format(DateTime.now());
      userProfileDetails.profilePicPath = picPath + "#" + nowParam;

      notifyListeners();
    } catch (e) {
      print('in profile provider ${e.toString()}');
      throw e;
    }
  }

  String get getUserName {
    return userProfileDetails.name;
  }

  void upadateFee(String fee) {
    userProfileDetails.docFees = fee;
    notifyListeners();
  }

  void upadateFeePeriod(int period) {
    userProfileDetails.feesPeriod = period;
    notifyListeners();
  }

  Details get currentUser {
    // print(
    //     'current user profile pic path ----- ${_userProfileDetails.profilePicPath}');

    return userProfileDetails;
  }

  void logOut(context) async {
    try {
      var success = await LoginCheck().logOut();
      if (success == 1) {
        print('Successfully logged out');
      }
    } catch (e) {
      print(e);
    }

    SharedPreferences localstorage = await SharedPreferences.getInstance();
    localstorage.clear();
    userProfileDetails = null;
    Navigator.pushReplacementNamed(context, signIn);
  }
}
