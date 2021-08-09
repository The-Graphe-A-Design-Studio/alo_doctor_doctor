// class Doctor {
//   int success;
//   int id;
//   String message;
//   String planType;
//   String verified;
//   String registered;
//   String mobileNumber;
//   String mobileNumberCode;
//   String compName;
//   String email;
//
//   Doctor({
//     this.success,
//     this.id,
//     this.planType,
//     this.email,
//     this.message,
//     this.verified,
//     this.mobileNumber,
//     this.mobileNumberCode,
//     this.registered,
//     this.compName,
//   });
//
//   factory Doctor.fromJson(Map<String, dynamic> parsedJson) {
//     return Doctor(
//         // success: parsedJson['success'] == '1' ? true : false,
//         id: parsedJson['id'],
//         planType: parsedJson['plan type'],
//         message: parsedJson['message'],
//         verified: parsedJson['verified'],
//         mobileNumber: parsedJson['shipper phone'],
//         mobileNumberCode: parsedJson['shipper phone country code'],
//         registered: parsedJson['registered on'],
//         compName: parsedJson['shipper company name']);
//   }
//
//   Map<String, dynamic> toJson() => {
//         'success': "1",
//         'id': this.id,
//         'message': this.message,
//         'verified': this.verified,
//         'shipper phone': this.mobileNumber,
//         'shipper phone country code': this.mobileNumberCode,
//         'registered on': this.registered,
//         'shipper company name': this.compName
//       };
// }


// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.success,
    this.details,
  });

  int success;
  Details details;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    success: json["success"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "details": details.toJson(),
  };
}

class Details {
  Details({
    this.id,
    this.name,
    this.conCode,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.otp,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.maritalStatus,
    this.height,
    this.weight,
    this.city,
    this.state,
    this.country,
    this.lat,
    this.lng,
    this.userType,
    this.catId,
    this.docFees,
    this.profilePic,
    this.profilePicPath,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategories,
    this.documents,
    this.doctorVerified,
  });

  int id;
  String name;
  int conCode;
  int phone;
  String email;
  dynamic emailVerifiedAt;
  dynamic otp;
  String gender;
  DateTime dob;
  dynamic bloodGroup;
  dynamic maritalStatus;
  dynamic height;
  dynamic weight;
  String city;
  String state;
  String country;
  String lat;
  String lng;
  int userType;
  dynamic catId;
  dynamic docFees;
  dynamic profilePic;
  dynamic profilePicPath;
  dynamic deviceToken;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic category;
  List<dynamic> subCategories;
  List<dynamic> documents;
  int doctorVerified;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    conCode: json["con_code"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    otp: json["otp"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    bloodGroup: json["blood_group"],
    maritalStatus: json["marital_status"],
    height: json["height"],
    weight: json["weight"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    lat: json["lat"],
    lng: json["lng"],
    userType: json["user_type"],
    catId: json["cat_id"],
    docFees: json["doc_fees"],
    profilePic: json["profile_pic"],
    profilePicPath: json["profile_pic_path"],
    deviceToken: json["device_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: json["category"],
    subCategories: List<dynamic>.from(json["sub_categories"].map((x) => x)),
    documents: List<dynamic>.from(json["documents"].map((x) => x)),
    doctorVerified: json["doctor_verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "con_code": conCode,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "otp": otp,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "blood_group": bloodGroup,
    "marital_status": maritalStatus,
    "height": height,
    "weight": weight,
    "city": city,
    "state": state,
    "country": country,
    "lat": lat,
    "lng": lng,
    "user_type": userType,
    "cat_id": catId,
    "doc_fees": docFees,
    "profile_pic": profilePic,
    "profile_pic_path": profilePicPath,
    "device_token": deviceToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": category,
    "sub_categories": List<dynamic>.from(subCategories.map((x) => x)),
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "doctor_verified": doctorVerified,
  };
}

