import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project/Models/CityList.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/Models/Login.dart';
import 'package:project/Models/ProjectList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Models/ProjectType.dart';
import 'package:project/Models/QRCode.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Models/Registration.dart';
import 'package:project/Models/StateList.dart';
import 'package:project/Models/Suggestions.dart';
import 'package:project/Models/UserInfo.dart';
import 'package:project/Views/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

BuildContext myContext;
class Webservice {
  String UserId;
  initContext(BuildContext cont){
    myContext = cont;

  }
  void initUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
    UserId = prefs.getString("UserId");
  }

  Future<SendOTPRespo> SendOTPToUser(String mobileNo) async {
    final url = BaseURL+"Authenticate/UserByMobileNo/"+mobileNo;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      SendOTPRespo data = SendOTPRespo.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

  Future<OTPRespo> MatchOTP(OTPMatch otpMatch) async {

    final url =BaseURL+ "Authenticate/MatchOTP";
    String json = jsonEncode(otpMatch);

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      OTPRespo data = OTPRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){

    }else {
      return null;
    }
  }
  Future<UpdateUserInfoRespo> UpdateUser(UpdateUserInfo updateUserInfo) async {

    final url =BaseURL+ "Authenticate/EditAccounts/"+updateUserInfo.userId;
    String json = jsonEncode(updateUserInfo);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");

    Map<String, String> header= {
      "Content-Type":"application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.put(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      UpdateUserInfoRespo data = UpdateUserInfoRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){

    }else {
      return null;
    }
  }

  Future<RegistrationRespo> RegisterUser(Registration registration) async {

    final url =BaseURL+ "Authenticate/UserRegister";
    String json = jsonEncode(registration);

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      RegistrationRespo data = RegistrationRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){

    }else {
      return null;
    }
  }

  Future<UserInfo> GetUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
      UserId = prefs.getString("UserId");
    final url = BaseURL+"Authenticate/UsersAccountById/"+UserId;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      UserInfo data = UserInfo.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

  Future<ProjectInfo> GetProjectInfo(code) async {

    //try{
      final url = AppURL+"GetProjectByCode/"+code;

      Map<String, String> header= {
        "Content-Type":"application/json",
      };

      final response = await http.get(url, headers: header);
      if(response.statusCode == 200) {
        final body = jsonDecode(response.body);
        ProjectInfo data = ProjectInfo.fromJson(body);
        return data;
      } else {
        return null;
      }
    //}
    //catch(ex){
    //  return null;
    //  print(ex);
   // }
  }

  Future<ProjectList> GetProjectList() async {

    final url = AppURL+"GetProjects/";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      ProjectList data = ProjectList.fromJson(body);

      return data;
    } else {
      return null;
    }
  }

  Future<ProjectList> GetProjectListSearch(String projectName,String ContractorName,String CategoryName,String Location,String status) async {

    final url = AppURL+"SearchProjects"+(projectName.isEmpty?"":"?projectName="+projectName)+(ContractorName.isEmpty?"":"?ContractorName="+ContractorName)
        +(CategoryName.isEmpty?"":"?CategoryName="+CategoryName)+(Location.isEmpty?"":"?Location="+Location)+(status.isEmpty?"":"?status="+status);
    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      ProjectList data = ProjectList.fromJson(body);

      return data;
    } else {
      return null;
    }
  }

  Future<RatingReviewRespo> AddProjectReview(RatingReview ratingReview) async {

    final url = AppURL +"AddProjectRatingReviews";
    String json = jsonEncode(ratingReview);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");

    Map<String, String> header= {
      "Content-Type":"application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      RatingReviewRespo data = RatingReviewRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){

    }else {
      return null;
    }
  }

  Future<MyRatingReviewList> GetMyRatingReviewList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
      UserId = prefs.getString("UserId");
    final url = AppURL+"GetReviewsByUserId/"+UserId;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      MyRatingReviewList data = MyRatingReviewList.fromJson(body);
      return data;
    } else {
      return null;
    }
  }
  Future<ComplainRespo> AddProjectComplain(Complain complain) async {

    final url = AppURL +"AddProjectComplains";
    String json = jsonEncode(complain);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");

    Map<String, String> header= {
      "Content-Type":"application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      ComplainRespo data = ComplainRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){
      return null;
    }else {
      return null;
    }
  }

  Future<MyComplainList> GetMyComplainList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
      UserId = prefs.getString("UserId");
    final url = AppURL+"GetComplainByUserId/"+UserId;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      MyComplainList data = MyComplainList.fromJson(body);

      return data;
    } else {
      return null;
    }
  }


  Future<QueryRespo> AddProjectQury(Query query) async {

    final url = AppURL +"AddProjectQuerys";
    String json = jsonEncode(query);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");

    Map<String, String> header= {
      "Content-Type":"application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      QueryRespo data = QueryRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){
      return null;
    }else {
      return null;
    }
  }
  Future<MyQueryList> GetMyQueryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
      UserId = prefs.getString("UserId");
    final url = AppURL+"GetProjectQueryByUserId/"+UserId;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };
    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      MyQueryList data = MyQueryList.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

  Future<QRCode> GetQRcodeList() async {

    final url = AppURL+"GetProjectCodes";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      QRCode data = QRCode.fromJson(body);

      return data;
    } else {
      return null;
    }
  }

  Future<SuggestionsList> GetMySuggestionsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("UserId")!=null)
      UserId = prefs.getString("UserId");
    final url = AppURL+"GetSuggestionByUserId/"+UserId;

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      SuggestionsList data = SuggestionsList.fromJson(body);
      return data;
    } else {
      return null;
    }
  }
  Future<SuggestionsRespo> AddAppSuggestion(Suggestions data) async {

    final url = AppURL +"AddApplicationSuggestion";
    String json = jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");

    Map<String, String> header= {
      "Content-Type":"application/json",
      "Authorization": "Bearer $token",
    };
    final response = await http.post(url, headers: header, body: json);

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      SuggestionsRespo data = SuggestionsRespo.fromJson(body);
      return data;
    } else if(response.statusCode == 401){

    }else {
      return null;
    }
  }

  Future<ListContractor> GetContractorList() async {

    final url = AppURL+"GetContractors/";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      ListContractor data = ListContractor.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

  Future<ProjectType> GetProjectTypeList() async {

    final url = AppURL+"GetProjectCategoriesList/";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      ProjectType data = ProjectType.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

  Future<StateList> GetStateList() async {

    final url = AppURL+"GetStatesList/1";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      StateList data = StateList.fromJson(body);
      return data;
    } else {
      return null;
    }
  }
  Future<CityList> GetCityList() async {

    final url = AppURL+"GetMetroCityList";

    Map<String, String> header= {
      "Content-Type":"application/json",
    };

    final response = await http.get(url, headers: header);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      CityList data = CityList.fromJson(body);
      return data;
    } else {
      return null;
    }
  }

}
