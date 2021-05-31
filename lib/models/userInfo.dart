class Userdata {
  String email;
  String password;
  Userdata(this.email, this.password);

  Userdata.fromJson(Map<String, dynamic> json) {
    email = json['username'];
    password = json['password'];
  }
}
