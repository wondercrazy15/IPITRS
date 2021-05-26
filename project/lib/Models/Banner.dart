class Banners {
  String title;
  String imageUrl;

  Banners({this.title, this.imageUrl});
}
class Review {
  String title;
  double rating;
  String userName;

  Review({this.title, this.rating,this.userName});
}

class Project {
  String name;
  String category;
  String imageUrl;
  String location;
  String area;
  String city;
  String budget;
  String startDate;
  String endDate;
  String status;
  String contractorName;
  String contractorMono;
  String contractorEmail;
  Project({this.name,this.category, this.imageUrl,this.location,this.area,this.city,this.budget,this.startDate,this.endDate, this.status,this.contractorName,this.contractorMono,this.contractorEmail});
}