

import 'package:flutter/cupertino.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class ProjectViewViewModel extends BaseViewModel {

  void initModel(BuildContext context,String code) async{
    Webservice().initContext(context);
    await GetProjectInfo(code);
  }

  ProjectInfo response = ProjectInfo();

  bool isLoader=true;
  Future<void> GetProjectInfo(String code) async {
    setBusy(true);
    final results =  await Webservice().GetProjectInfo(code);
    response = results;
    notifyListeners();
    setBusy(false);
    isLoader=false;

  }
  Future<RatingReviewRespo> AddProjectReview(RatingReview Data) async {
    RatingReviewRespo ratingReviewRespo= await Webservice().AddProjectReview(Data);
    notifyListeners();
    setBusy(false);
    isLoader=false;
    return ratingReviewRespo;
  }


}