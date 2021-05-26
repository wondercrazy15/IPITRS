class Complain {
  int projectID;
  String userID;
  String query;
  String senderEmail;
  String receiverEmail;
  String phoneNumber;
  String description;

  Complain(
      {this.projectID,
        this.userID,
        this.query,
        this.senderEmail,
        this.receiverEmail,
        this.phoneNumber,
        this.description});

  Complain.fromJson(Map<String, dynamic> json) {
    projectID = json['projectID'];
    userID = json['userID'];
    query = json['query'];
    senderEmail = json['senderEmail'];
    receiverEmail = json['receiverEmail'];
    phoneNumber = json['phoneNumber'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectID'] = this.projectID;
    data['userID'] = this.userID;
    data['query'] = this.query;
    data['senderEmail'] = this.senderEmail;
    data['receiverEmail'] = this.receiverEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    return data;
  }
}

class ComplainRespo {
  bool status;
  ComplainRespoData data;
  String message;

  ComplainRespo({this.status, this.data, this.message});

  ComplainRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ComplainRespoData.fromJson(json['data']) : null;
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

class ComplainRespoData {
  int id;

  ComplainRespoData({this.id});

  ComplainRespoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}


class MyComplainList {
  bool status;
  List<MyComplainListData> data;
  String message;

  MyComplainList({this.status, this.data, this.message});

  MyComplainList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null&&json['data'] != "") {
      data = new List<MyComplainListData>();
      json['data'].forEach((v) {
        data.add(new MyComplainListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null&&this.data!="") {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class MyComplainListData {
  int id;
  int projectID;
  String projectName;
  String userID;
  String userName;
  String query;
  String senderEmail;
  String receiverEmail;
  String phoneNumber;
  String description;
  String createdDate;

  MyComplainListData(
      {this.id,
        this.projectID,
        this.projectName,
        this.userID,
        this.userName,
        this.query,
        this.senderEmail,
        this.receiverEmail,
        this.phoneNumber,
        this.description,
        this.createdDate});

  MyComplainListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectID = json['projectID'];
    projectName = json['projectName'];
    userID = json['userID'];
    userName = json['userName'];
    query = json['query'];
    senderEmail = json['senderEmail'];
    receiverEmail = json['receiverEmail'];
    phoneNumber = json['phoneNumber'];
    description = json['description'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectID'] = this.projectID;
    data['projectName'] = this.projectName;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['query'] = this.query;
    data['senderEmail'] = this.senderEmail;
    data['receiverEmail'] = this.receiverEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    return data;
  }
}