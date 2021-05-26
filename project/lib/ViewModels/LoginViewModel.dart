import 'package:flutter/cupertino.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/Login.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Models/Registration.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  Future<SendOTPRespo> SendOTPToUser(String mobileNo) async {
    setBusy(true);
    SendOTPRespo sendOTPRespo=  await Webservice().SendOTPToUser(mobileNo);
    notifyListeners();
    setBusy(false);
    return sendOTPRespo;
  }
  Future<OTPRespo> MatchOTP(OTPMatch otpMatch) async {
    setBusy(true);
    OTPRespo sendOTPRespo=  await Webservice().MatchOTP(otpMatch);
    notifyListeners();
    setBusy(false);
    return sendOTPRespo;
  }
}