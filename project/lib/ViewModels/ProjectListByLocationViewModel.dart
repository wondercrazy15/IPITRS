import 'package:flutter/cupertino.dart';
import 'package:project/Models/ProjectList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class ProjectListByLocationViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    //GetProjectList();
  }

  ProjectList response = ProjectList();
  bool isLoading=true;
  Future<void> GetProjectList() async {
    setBusy(true);
    final results =  await Webservice().GetProjectList();
    response = results;
    notifyListeners();
    setBusy(false);

  }

  Future<ProjectList> GetProjectListInfo() async {

    final results =  await Webservice().GetProjectList();
    response = results;
    isLoading=false;
    notifyListeners();
    return response;
  }

}