class CityList {
  bool status;
  List<CityListData> data;
  String message;

  CityList({this.status, this.data, this.message});

  CityList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CityListData>();
      json['data'].forEach((v) {
        data.add(new CityListData.fromJson(v));
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

class CityListData {
  int metroCityID;
  String metroCity;
  int countryID;
  String countryName;
  int stateID;
  String stateName;
  bool isActive;
  bool isDelete;
  String createdDate;
  String modifiedDate;

  CityListData(
      {this.metroCityID,
        this.metroCity,
        this.countryID,
        this.countryName,
        this.stateID,
        this.stateName,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.modifiedDate});

  CityListData.fromJson(Map<String, dynamic> json) {
    metroCityID = json['metroCityID'];
    metroCity = json['metroCity'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    stateID = json['stateID'];
    stateName = json['stateName'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metroCityID'] = this.metroCityID;
    data['metroCity'] = this.metroCity;
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['stateID'] = this.stateID;
    data['stateName'] = this.stateName;
    data['isActive'] = this.isActive;
    data['isDelete'] = this.isDelete;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}