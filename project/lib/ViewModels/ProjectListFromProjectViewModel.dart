import 'package:flutter/cupertino.dart';
import 'package:project/Models/ProjectList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class ProjectListFromProjectViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    //GetProjectList();
  }

  ProjectList response = ProjectList();
  bool isLoading=true;
  String Info="";
  Future<void> GetProjectList() async {
    setBusy(true);
    final results =  await Webservice().GetProjectList();
    response = results;
    if(response.data==null){
      Info="No data found";
    }
    notifyListeners();
    setBusy(false);

  }

  Future<ProjectList> GetProjectListInfo(String projectName,String ContractorName,String CategoryName,String Location,String status) async {

    final results =  await Webservice().GetProjectListSearch(projectName,ContractorName,CategoryName,Location,status);
    response = results;
    if(response.data==null){
      Info="No project found";
    }
    isLoading=false;
    notifyListeners();
    return response;
  }


}