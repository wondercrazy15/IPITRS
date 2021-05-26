
class ProjectList {
  bool status;
  List<Data> data;
  String message;

  ProjectList({this.status, this.data, this.message});

  ProjectList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != "") {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String code;
  String name;
  String description;
  String budget;
  String startDate;
  String endDate;
  String status;
  int categoryID;
  String projectCategoryName;
  String createdAt;
  String contractorName;
  String location;
  String imagePath;

  Data({this.id,
    this.code,
    this.name,
    this.description,
    this.budget,
    this.startDate,
    this.endDate,
    this.status,
    this.categoryID,
    this.projectCategoryName,
    this.createdAt,
    this.contractorName,
    this.location,
    this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    budget = json['budget'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    categoryID = json['categoryID'];
    projectCategoryName = json['projectCategoryName'];
    createdAt = json['createdAt'];
    contractorName = json['contractorName'];
    location = json['location'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['categoryID'] = this.categoryID;
    data['projectCategoryName'] = this.projectCategoryName;
    data['createdAt'] = this.createdAt;
    data['contractorName'] = this.contractorName;
    data['location'] = this.location;
    data['imagePath'] = this.imagePath;
    return data;
  }
}