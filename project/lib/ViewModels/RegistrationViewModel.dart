import 'package:flutter/cupertino.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Models/Registration.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class RegistrationViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  Future<RegistrationRespo> RegistrationUser(Registration registration) async {
    setBusy(true);
    RegistrationRespo registrationRespo=  await Webservice().RegisterUser(registration);
    notifyListeners();
    setBusy(false);
    return registrationRespo;
  }

}