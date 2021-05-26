class Query {
  int projectID;
  String userID;
  String query;
  String email;
  String phoneNumber;
  String description;

  Query(
      {this.projectID,
        this.userID,
        this.query,
        this.email,
        this.phoneNumber,
        this.description});

  Query.fromJson(Map<String, dynamic> json) {
    projectID = json['projectID'];
    userID = json['userID'];
    query = json['query'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectID'] = this.projectID;
    data['userID'] = this.userID;
    data['query'] = this.query;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    return data;
  }
}

class QueryRespo {
  bool status;
  QueryRespoData data;
  String message;

  QueryRespo({this.status, this.data, this.message});

  QueryRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new QueryRespoData.fromJson(json['data']) : null;
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

class QueryRespoData {
  int id;

  QueryRespoData({this.id});

  QueryRespoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}


class MyQueryList {
  bool status;
  List<MyQueryListData> data;
  String message;

  MyQueryList({this.status, this.data, this.message});

  MyQueryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null&&json['data'] != "") {
      data = new List<MyQueryListData>();
      json['data'].forEach((v) {
        data.add(new MyQueryListData.fromJson(v));
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

class MyQueryListData {
  int id;
  int projectID;
  String projectName;
  String userID;
  String query;
  String email;
  String phoneNumber;
  String description;
  String createdDate;

  MyQueryListData(
      {this.id,
        this.projectID,
        this.projectName,
        this.userID,
        this.query,
        this.email,
        this.phoneNumber,
        this.description,
        this.createdDate});

  MyQueryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectID = json['projectID'];
    projectName = json['projectName'];
    userID = json['userID'];
    query = json['query'];
    email = json['email'];
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
    data['query'] = this.query;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    return data;
  }
}