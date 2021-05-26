import 'package:flutter/cupertino.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/QRCode.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class QRCodeViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
  }

  Future<QRCode> GetQRcodeList() async {
    setBusy(true);
    QRCode QRcodeRespo=  await Webservice().GetQRcodeList();
    notifyListeners();
    setBusy(false);
    return QRcodeRespo;
  }

}