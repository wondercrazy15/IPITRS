class ProjectListModel {
  bool status;
  Data data;
  String message;

  ProjectListModel({this.status, this.data, this.message});

  ProjectListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int id;
  String code;
  String name;
  String description;
  double budget;
  String startDate;
  String endDate;
  String status;
  int categoryID;
  String projectCategoryName;
  String createdAt;
  String updatedAt;
  bool isActive;
  bool isDelete;
  List<ProjectImageList> projectImageList;
  List<ProjectDocumentList> projectDocumentList;
  List<ContractorList> contractorList;
  List<AddressList> addressList;
  List<ProjectReviewList> projectReviewList;
  double averageRating;

  Data(
      {this.id,
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
        this.updatedAt,
        this.isActive,
        this.isDelete,
        this.projectImageList,
        this.projectDocumentList,
        this.contractorList,
        this.addressList,
        this.projectReviewList,
        this.averageRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    budget = json['budget']== null ? 0.0 : json['budget'].toDouble();
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    categoryID = json['categoryID'];
    projectCategoryName = json['projectCategoryName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    if (json['projectImageList'] != null) {
      projectImageList = new List<ProjectImageList>();
      json['projectImageList'].forEach((v) {
        projectImageList.add(new ProjectImageList.fromJson(v));
      });
    }
    if (json['projectDocumentList'] != null) {
      projectDocumentList = new List<ProjectDocumentList>();
      json['projectDocumentList'].forEach((v) {
        projectDocumentList.add(new ProjectDocumentList.fromJson(v));
      });
    }
    if (json['contractorList'] != null) {
      contractorList = new List<ContractorList>();
      json['contractorList'].forEach((v) {
        contractorList.add(new ContractorList.fromJson(v));
      });
    }
    if (json['addressList'] != null) {
      addressList = new List<AddressList>();
      json['addressList'].forEach((v) {
        addressList.add(new AddressList.fromJson(v));
      });
    }
    if (json['projectReviewList'] != null) {
      projectReviewList = new List<ProjectReviewList>();
      json['projectReviewList'].forEach((v) {
        projectReviewList.add(new ProjectReviewList.fromJson(v));
      });
    }
    averageRating = json['averageRating']== null ? 0.0 : json['averageRating'].toDouble();
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
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    if (this.projectImageList != null) {
      data['projectImageList'] =
          this.projectImageList.map((v) => v.toJson()).toList();
    }
    if (this.projectDocumentList != null) {
      data['projectDocumentList'] =
          this.projectDocumentList.map((v) => v.toJson()).toList();
    }
    if (this.contractorList != null) {
      data['contractorList'] =
          this.contractorList.map((v) => v.toJson()).toList();
    }
    if (this.addressList != null) {
      data['addressList'] = this.addressList.map((v) => v.toJson()).toList();
    }
    if (this.projectReviewList != null) {
      data['projectReviewList'] =
          this.projectReviewList.map((v) => v.toJson()).toList();
    }
    data['averageRating'] = this.averageRating;
    return data;
  }
}

class ProjectImageList {
  String name;
  String type;
  String filePath;
  int displayOrder;

  ProjectImageList({this.name, this.type, this.filePath, this.displayOrder});

  ProjectImageList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    filePath = json['filePath'];
    displayOrder = json['displayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['filePath'] = this.filePath;
    data['displayOrder'] = this.displayOrder;
    return data;
  }
}

class ContractorList {
  int id;
  String code;
  String name;
  String email;
  String phoneNumber;
  int addressId;
  String description;
  String createdAt;
  Null updatedAt;
  bool isActive;
  int displayOrder;
  List<ContractorAddressList> contractorAddressList;

  ContractorList(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.phoneNumber,
        this.addressId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.displayOrder,
        this.contractorAddressList});

  ContractorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    addressId = json['addressId'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    displayOrder = json['displayOrder'];
    if (json['contractorAddressList'] != null) {
      contractorAddressList = new List<ContractorAddressList>();
      json['contractorAddressList'].forEach((v) {
        contractorAddressList.add(new ContractorAddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['addressId'] = this.addressId;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    data['displayOrder'] = this.displayOrder;
    if (this.contractorAddressList != null) {
      data['contractorAddressList'] =
          this.contractorAddressList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContractorAddressList {
  int id;
  String addressName;
  int cityID;
  String cityName;
  String area;
  int countryID;
  String countryName;
  int stateID;
  String stateName;
  String pinCode;
  String description;
  bool isActive;
  Null isDelete;
  Null isDefault;

  ContractorAddressList(
      {this.id,
        this.addressName,
        this.cityID,
        this.cityName,
        this.area,
        this.countryID,
        this.countryName,
        this.stateID,
        this.stateName,
        this.pinCode,
        this.description,
        this.isActive,
        this.isDelete,
        this.isDefault});

  ContractorAddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_Name'];
    cityID = json['cityID'];
    cityName = json['cityName'];
    area = json['area'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    stateID = json['stateID'];
    stateName = json['stateName'];
    pinCode = json['pinCode'];
    description = json['description'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_Name'] = this.addressName;
    data['cityID'] = this.cityID;
    data['cityName'] = this.cityName;
    data['area'] = this.area;
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['stateID'] = this.stateID;
    data['stateName'] = this.stateName;
    data['pinCode'] = this.pinCode;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

class AddressList {
  int id;
  String addressName;
  int cityID;
  String cityName;
  String area;
  int countryID;
  String countryName;
  int stateID;
  String stateName;
  String pinCode;
  String description;
  bool isActive;
  Null isDelete;
  bool isDefault;

  AddressList(
      {this.id,
        this.addressName,
        this.cityID,
        this.cityName,
        this.area,
        this.countryID,
        this.countryName,
        this.stateID,
        this.stateName,
        this.pinCode,
        this.description,
        this.isActive,
        this.isDelete,
        this.isDefault});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_Name'];
    cityID = json['cityID'];
    cityName = json['cityName'];
    area = json['area'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    stateID = json['stateID'];
    stateName = json['stateName'];
    pinCode = json['pinCode'];
    description = json['description'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_Name'] = this.addressName;
    data['cityID'] = this.cityID;
    data['cityName'] = this.cityName;
    data['area'] = this.area;
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['stateID'] = this.stateID;
    data['stateName'] = this.stateName;
    data['pinCode'] = this.pinCode;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

class ProjectReviewList {
  int id;
  int projectID;
  String projectName;
  String userID;
  String userName;
  int rating;
  String review;
  String description;
  String createdDate;

  ProjectReviewList(
      {this.id,
        this.projectID,
        this.projectName,
        this.userID,
        this.userName,
        this.rating,
        this.review,
        this.description,
        this.createdDate});

  ProjectReviewList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectID = json['projectID'];
    projectName = json['projectName'];
    userID = json['userID'];
    userName = json['userName'];
    rating = json['rating'].toInt();
    review = json['review'];
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
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    return data;
  }
}

class ProjectDocumentList {
  String name;
  String type;
  String filePath;
  int displayOrder;

  ProjectDocumentList({this.name, this.type, this.filePath, this.displayOrder});

  ProjectDocumentList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    filePath = json['filePath'];
    displayOrder = json['displayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['filePath'] = this.filePath;
    data['displayOrder'] = this.displayOrder;
    return data;
  }
}


class ProjectInfo {
  bool status;
  Data data;
  String message;

  ProjectInfo({this.status, this.data, this.message});

  ProjectInfo.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  message = json['message'];
  }
}