class RatingReview {
  int projectID;
  String userID;
  double rating;
  String review;
  String description;

  RatingReview(
      {this.projectID,
        this.userID,
        this.rating,
        this.review,
        this.description});

  RatingReview.fromJson(Map<String, dynamic> json) {
    projectID = json['projectID'];
    userID = json['userID'];
    rating = json['rating'];
    review = json['review'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectID'] = this.projectID;
    data['userID'] = this.userID;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['description'] = this.description;
    return data;
  }
}

class RatingReviewRespo {
  bool status;
  RatingReviewRespoData data;
  String message;

  RatingReviewRespo({this.status, this.data, this.message});

  RatingReviewRespo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new RatingReviewRespoData.fromJson(json['data']) : null;
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

class RatingReviewRespoData {
  int id;

  RatingReviewRespoData({this.id});

  RatingReviewRespoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class MyRatingReviewList {
  bool status;
  List<MyRatingReviewListData> data;
  String message;

  MyRatingReviewList({this.status, this.data, this.message});

  MyRatingReviewList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null&&json['data']!="") {
      data = new List<MyRatingReviewListData>();
      json['data'].forEach((v) {
        data.add(new MyRatingReviewListData.fromJson(v));
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

class MyRatingReviewListData {
  int id;
  int projectID;
  String projectName;
  String userID;
  String userName;
  double rating;
  String review;
  String description;
  String createdDate;

  MyRatingReviewListData(
      {this.id,
        this.projectID,
        this.projectName,
        this.userID,
        this.userName,
        this.rating,
        this.review,
        this.description,
        this.createdDate});

  MyRatingReviewListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectID = json['projectID'];
    projectName = json['projectName'];
    userID = json['userID'];
    userName = json['userName'];
    rating = json['rating'].toDouble();
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