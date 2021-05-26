class Registration {
  String name;
  String email;
  String mobileNumber;

  Registration({this.name, this.email, this.mobileNumber});

  Registration.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}

class RegistrationRespo {
  bool status;
  RegistrationRespoData data;
  String message;

  RegistrationRespo({this.status, this.data, this.message});

  RegistrationRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != '' ? new RegistrationRespoData.fromJson(json['data']) : null;
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

class RegistrationRespoData {
  String name;
  String udid;
  String birthDate;
  String email;
  String mobileNumber;
  String addressID1;
  String addressID2;
  String userId;
  String address1;
  String address2;

  RegistrationRespoData(
      {this.name,
        this.udid,
        this.birthDate,
        this.email,
        this.mobileNumber,
        this.addressID1,
        this.addressID2,
        this.userId,
        this.address1,
        this.address2});

  RegistrationRespoData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    udid = json['udid'];
    birthDate = json['birthDate'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    addressID1 = json['addressID1'];
    addressID2 = json['addressID2'];
    userId = json['userId'];
    address1 = json['address1'];
    address2 = json['address2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['udid'] = this.udid;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['addressID1'] = this.addressID1;
    data['addressID2'] = this.addressID2;
    data['userId'] = this.userId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    return data;
  }
}