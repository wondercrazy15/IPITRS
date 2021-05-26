import 'package:flutter/cupertino.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Models/UserInfo.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class MyProfileViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    await GetUserInfo();
  }
  UserInfo userInfo = UserInfo();
  String Info="";

  Future<void> GetUserInfo() async {
    setBusy(true);
    final results =  await Webservice().GetUserInfo();
    userInfo = results;
    notifyListeners();
    setBusy(false);
  }

  Future<UpdateUserInfoRespo> UpdateUser(UpdateUserInfo updateUserInfo) async {
    setBusy(true);
    UpdateUserInfoRespo updateUserInfoRespo=  await Webservice().UpdateUser(updateUserInfo);
    notifyListeners();
    setBusy(false);
    return updateUserInfoRespo;
  }

}