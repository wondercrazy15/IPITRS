class ProjectType {
  bool status;
  List<ProjectTypeData> data;
  String message;

  ProjectType({this.status, this.data, this.message});

  ProjectType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ProjectTypeData>();
      json['data'].forEach((v) {
        data.add(new ProjectTypeData.fromJson(v));
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

class ProjectTypeData {
  int id;
  String projectCategoryName;
  int parentProjectCategoryID;
  String description;
  String createdAt;
  String updatedAt;
  bool isActive;
  bool isDelete;
  List<SubCategories> subCategories;

  ProjectTypeData(
      {this.id,
        this.projectCategoryName,
        this.parentProjectCategoryID,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.isDelete,
        this.subCategories});

  ProjectTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectCategoryName = json['projectCategoryName'];
    parentProjectCategoryID = json['parentProjectCategoryID'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    if (json['subCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectCategoryName'] = this.projectCategoryName;
    data['parentProjectCategoryID'] = this.parentProjectCategoryID;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  String projectCategoryName;
  int parentProjectCategoryID;
  Null description;
  String createdAt;
  String updatedAt;
  bool isActive;
  bool isDelete;
  String subCategories;

  SubCategories(
      {this.id,
        this.projectCategoryName,
        this.parentProjectCategoryID,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.isDelete,
        this.subCategories});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectCategoryName = json['projectCategoryName'];
    parentProjectCategoryID = json['parentProjectCategoryID'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    subCategories = json['subCategories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectCategoryName'] = this.projectCategoryName;
    data['parentProjectCategoryID'] = this.parentProjectCategoryID;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['subCategories'] = this.subCategories;
    return data;
  }
}