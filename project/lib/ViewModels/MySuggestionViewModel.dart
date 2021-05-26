import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Models/Suggestions.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class MySuggestionViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    await GetMySuggestionsList();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version = "Version: "+packageInfo.version;//+(Platform.isIOS ? "-iOS" : "-Android");

  }
  SuggestionsList mySuggestionsList = SuggestionsList();
  String Info="";
  String Version="";
  Future<void> GetMySuggestionsList() async {
    setBusy(true);
    final results =  await Webservice().GetMySuggestionsList();
    mySuggestionsList = results;
    if(mySuggestionsList.data==null){
      Info="No data found";
    }
    notifyListeners();
    setBusy(false);
  }

  Future<SuggestionsRespo> AddAppSuggestion(Suggestions Data) async {
    SuggestionsRespo Respo= await Webservice().AddAppSuggestion(Data);
    notifyListeners();
    setBusy(false);
    return Respo;
  }

}