class Suggestions {
  String userID;
  String version;
  String description;

  Suggestions({this.userID, this.version, this.description});

  Suggestions.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    version = json['version'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['version'] = this.version;
    data['description'] = this.description;
    return data;
  }
}

class SuggestionsRespo {
  bool status;
  SuggestionsRespoData data;
  String message;

  SuggestionsRespo({this.status, this.data, this.message});

  SuggestionsRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SuggestionsRespoData.fromJson(json['data']) : null;
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

class SuggestionsRespoData {
  int id;
  String version;
  String description;
  String createdAt;

  SuggestionsRespoData({this.id, this.version, this.description, this.createdAt});

  SuggestionsRespoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['version'] = this.version;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class SuggestionsList {
  bool status;
  List<SuggestionsRespoData> data;
  String message;

  SuggestionsList({this.status, this.data, this.message});

  SuggestionsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != "") {
      data = new List<SuggestionsRespoData>();
      json['data'].forEach((v) {
        data.add(new SuggestionsRespoData.fromJson(v));
      });
    }
    message = json['message'];
  }
}