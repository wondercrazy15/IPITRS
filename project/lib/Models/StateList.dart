class StateList {
  bool status;
  List<StateListData> data;
  String message;

  StateList({this.status, this.data, this.message});

  StateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<StateListData>();
      json['data'].forEach((v) {
        data.add(new StateListData.fromJson(v));
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

class StateListData {
  int id;
  String stateName;
  int countryID;
  String countryName;
  String description;
  bool isActive;
  bool isDelete;
  String createdDate;
  String modifiedDate;

  StateListData(
      {this.id,
        this.stateName,
        this.countryID,
        this.countryName,
        this.description,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.modifiedDate});

  StateListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['stateName'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    description = json['description'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stateName'] = this.stateName;
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}