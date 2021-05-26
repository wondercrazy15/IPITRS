import 'package:flutter/cupertino.dart';
import 'package:project/Models/CityList.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Models/ProjectType.dart';
import 'package:project/Models/StateList.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class SearchFromPinCodeViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  StateList response = StateList();
  bool isLoading=true;

  Future<StateList> GetStateList() async {
    setBusy(true);
    final results =  await Webservice().GetStateList();
    response = results;
    isLoading=false;
    setBusy(false);
    notifyListeners();
    return response;
  }
  Future<CityList> GetCityList() async {
    setBusy(true);
    final results =  await Webservice().GetCityList();
    isLoading=false;
    setBusy(false);
    notifyListeners();
    return results;
  }
}