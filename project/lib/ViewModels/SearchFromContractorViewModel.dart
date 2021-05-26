import 'package:flutter/cupertino.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class SearchFromContractorViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  ListContractor response = ListContractor();
  bool isLoading=true;

  Future<ListContractor> GetContractorList() async {

    final results =  await Webservice().GetContractorList();
    response = results;
    isLoading=false;
    notifyListeners();
    return response;
  }

}