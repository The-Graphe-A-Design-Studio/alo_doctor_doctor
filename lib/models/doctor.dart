// import 'dart:convert';

// Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

// String doctorToJson(Doctor data) => json.encode(data.toJson());

// class Doctor {
//   Doctor({
//     this.success,
//     this.details,
//   });

//   int success;
//   Details details;

//   factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
//         success: json["success"],
//         details: Details.fromJson(json["details"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "details": details.toJson(),
//       };
// }

// class Details {
//   Details({
//     this.id,
//     this.name,
//     this.conCode,
//     this.phone,
//     this.email,
//     this.emailVerifiedAt,
//     this.otp,
//     this.gender,
//     this.dob,
//     this.bloodGroup,
//     this.maritalStatus,
//     this.height,
//     this.weight,
//     this.city,
//     this.state,
//     this.country,
//     this.lat,
//     this.lng,
//     this.userType,
//     this.catId,
//     this.docFees,
//     this.profilePic,
//     this.profilePicPath,
//     this.deviceToken,
//     this.createdAt,
//     this.updatedAt,
//     this.category,
//     this.subCategories,
//     this.documents,
//     this.doctorVerified,
//   });

//   int id;
//   String name;
//   int conCode;
//   int phone;
//   String email;
//   dynamic emailVerifiedAt;
//   dynamic otp;
//   String gender;
//   DateTime dob;
//   dynamic bloodGroup;
//   dynamic maritalStatus;
//   dynamic height;
//   dynamic weight;
//   String city;
//   String state;
//   String country;
//   String lat;
//   String lng;
//   int userType;
//   dynamic catId;
//   dynamic docFees;
//   dynamic profilePic;
//   dynamic profilePicPath;
//   dynamic deviceToken;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic category;
//   List<dynamic> subCategories;
//   List<dynamic> documents;
//   int doctorVerified;

//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//         id: json["id"],
//         name: json["name"],
//         conCode: json["con_code"],
//         phone: json["phone"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"],
//         otp: json["otp"],
//         gender: json["gender"],
//         dob: DateTime.parse(json["dob"]),
//         bloodGroup: json["blood_group"],
//         maritalStatus: json["marital_status"],
//         height: json["height"],
//         weight: json["weight"],
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         lat: json["lat"],
//         lng: json["lng"],
//         userType: json["user_type"],
//         catId: json["cat_id"],
//         docFees: json["doc_fees"],
//         profilePic: json["profile_pic"],
//         profilePicPath: json["profile_pic_path"],
//         deviceToken: json["device_token"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         category: json["category"],
//         subCategories: List<dynamic>.from(json["sub_categories"].map((x) => x)),
//         documents: List<dynamic>.from(json["documents"].map((x) => x)),
//         doctorVerified: json["doctor_verified"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "con_code": conCode,
//         "phone": phone,
//         "email": email,
//         "email_verified_at": emailVerifiedAt,
//         "otp": otp,
//         "gender": gender,
//         "dob":
//             "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "blood_group": bloodGroup,
//         "marital_status": maritalStatus,
//         "height": height,
//         "weight": weight,
//         "city": city,
//         "state": state,
//         "country": country,
//         "lat": lat,
//         "lng": lng,
//         "user_type": userType,
//         "cat_id": catId,
//         "doc_fees": docFees,
//         "profile_pic": profilePic,
//         "profile_pic_path": profilePicPath,
//         "device_token": deviceToken,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "category": category,
//         "sub_categories": List<dynamic>.from(subCategories.map((x) => x)),
//         "documents": List<dynamic>.from(documents.map((x) => x)),
//         "doctor_verified": doctorVerified,
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
    this.feesPeriod,
    this.profilePic,
    this.profilePicPath,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategories,
    this.documents,
    this.doctorVerified,
    this.totalSessions,
    this.rating,
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
  String weight;
  String city;
  String state;
  String country;
  String lat;
  String lng;
  int userType;
  int catId;
  String docFees;
  int feesPeriod;
  String profilePic;
  String profilePicPath;
  dynamic deviceToken;
  DateTime createdAt;
  DateTime updatedAt;
  String category;
  List<SubCategory> subCategories;
  List<Document> documents;
  int doctorVerified;
  int totalSessions;
  double rating;

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
        feesPeriod: json["fees_period"],
        profilePic: json["profile_pic"],
        profilePicPath: json["profile_pic_path"],
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: json["category"],
        subCategories: List<SubCategory>.from(
            json["sub_categories"].map((x) => SubCategory.fromJson(x))),
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        doctorVerified: json["doctor_verified"],
        totalSessions: json["total_sessions"],
        rating: json["rating"].toDouble(),
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
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
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
        "fees_period": feesPeriod,
        "profile_pic": profilePic,
        "profile_pic_path": profilePicPath,
        "device_token": deviceToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category,
        "sub_categories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "doctor_verified": doctorVerified,
        "total_sessions": totalSessions,
        "rating": rating,
      };
}

class Document {
  Document({
    this.id,
    this.userId,
    this.fileType,
    this.file,
    this.filePath,
    this.verified,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int fileType;
  String file;
  String filePath;
  int verified;
  DateTime createdAt;
  DateTime updatedAt;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        userId: json["user_id"],
        fileType: json["file_type"],
        file: json["file"],
        filePath: json["file_path"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file_type": fileType,
        "file": file,
        "file_path": filePath,
        "verified": verified,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SubCategory {
  SubCategory({
    this.id,
    this.subCatId,
    this.subCatName,
  });

  int id;
  int subCatId;
  String subCatName;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        subCatId: json["sub_cat_id"],
        subCatName: json["sub_cat_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_cat_id": subCatId,
        "sub_cat_name": subCatName,
      };
}
