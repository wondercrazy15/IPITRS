import 'package:flutter/cupertino.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Models/ProjectType.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class SearchFromTypeViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  ProjectType response = ProjectType();
  bool isLoading=true;

  Future<ProjectType> GetProjectTypeList() async {

    final results =  await Webservice().GetProjectTypeList();
    response = results;
    isLoading=false;
    notifyListeners();
    return response;
  }

}