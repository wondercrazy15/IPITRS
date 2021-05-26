import 'package:flutter/cupertino.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class ComplainViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  Future<ComplainRespo> AddProjectComplain(Complain ComplainData) async {
    setBusy(true);
    ComplainRespo complainRespo=  await Webservice().AddProjectComplain(ComplainData);
    notifyListeners();
    setBusy(false);
    return complainRespo;
  }

  Future<QueryRespo> AddProjectQuery(Query QueryData) async {
    setBusy(true);
    QueryRespo queryRespo=  await Webservice().AddProjectQury(QueryData);
    notifyListeners();
    setBusy(false);
    return queryRespo;
  }
}