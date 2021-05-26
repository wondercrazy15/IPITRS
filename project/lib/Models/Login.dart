
class SendOTPRespo {
  bool status;
  String data;
  String message;

  SendOTPRespo({this.status, this.data, this.message});

  SendOTPRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
class OTPMatch {
  String mobileNumber;
  String otp;

  OTPMatch({this.mobileNumber, this.otp});

  OTPMatch.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['otp'] = this.otp;
    return data;
  }
}

class OTPRespo {
  bool status;
  OTPRespoData data;
  String message;

  OTPRespo({this.status, this.data, this.message});

  OTPRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != "" ? new OTPRespoData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class OTPRespoData {
  String userId;
  String name;
  String mobile;
  String email;
  String profileImage;
  String token;
  String expiration;

  OTPRespoData(
      {this.userId,
        this.name,
        this.mobile,
        this.email,
        this.profileImage,
        this.token,
        this.expiration});

  OTPRespoData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    profileImage = json['profileImage'];
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    return data;
  }
}