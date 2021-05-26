class UserInfo {
  bool status;
  UserInfoData data;
  String message;

  UserInfo({this.status, this.data, this.message});

  UserInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserInfoData.fromJson(json['data']) : null;
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

class UserInfoData {
  int id;
  String name;
  String udid;
  String birthDate;
  String email;
  String mobileNumber;
  String userID;
  bool isActive;
  bool isDelete;
  String createdDate;
  String modifiedDate;
  String profileImage;

  UserInfoData(
      {this.id,
        this.name,
        this.udid,
        this.birthDate,
        this.email,
        this.mobileNumber,
        this.userID,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.modifiedDate,
        this.profileImage});

  UserInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    udid = (json['udid']==null)?"":json['udid'];
    birthDate = (json['birthDate']==null)?"":json['birthDate'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    userID = json['userID'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    modifiedDate = (json['modifiedDate']==null)?"":json['modifiedDate'];
    profileImage = (json['profileImage']==null)?"":json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['udid'] = this.udid;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['userID'] = this.userID;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class UpdateUserInfo {
  String name;
  String udid;
  String birthDate;
  String email;
  String mobileNumber;
  String userId;
  String profilePicture;

  UpdateUserInfo(
      {this.name,
        this.udid,
        this.birthDate,
        this.email,
        this.mobileNumber,
        this.userId,
        this.profilePicture});

  UpdateUserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    udid = json['udid'];
    birthDate = json['birthDate'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    userId = json['userId'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['udid'] = this.udid;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['userId'] = this.userId;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}

class UpdateUserInfoRespo {
  bool status;
  UpdateUserInfoRespoData data;
  String message;

  UpdateUserInfoRespo({this.status, this.data, this.message});

  UpdateUserInfoRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UpdateUserInfoRespoData.fromJson(json['data']) : null;
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

class UpdateUserInfoRespoData {
  int id;
  String userId;
  String email;
  String mobileNumber;
  String profileImage;

  UpdateUserInfoRespoData(
      {this.id, this.userId, this.email, this.mobileNumber, this.profileImage});

  UpdateUserInfoRespoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['profileImage'] = this.profileImage;
    return data;
  }
}