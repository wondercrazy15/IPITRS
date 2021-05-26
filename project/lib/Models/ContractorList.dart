class ListContractor {
  bool status;
  List<ContractorListData> data;
  String message;

  ListContractor({this.status, this.data, this.message});

  ListContractor.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ContractorListData>();
      json['data'].forEach((v) {
        data.add(new ContractorListData.fromJson(v));
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

class ContractorListData {
  int id;
  String code;
  String name;
  String email;
  String phoneNumber;
  int addressId;
  String description;
  String createdAt;
  String updatedAt;
  bool isActive;
  String displayOrder;
  List<ContractorAddressList> contractorAddressList;

  ContractorListData(
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

  ContractorListData.fromJson(Map<String, dynamic> json) {
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
  bool isDelete;
  bool isDefault;

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