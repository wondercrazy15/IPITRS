import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/ViewModels/LoginViewModel.dart';
import 'package:project/Views/OTPView.dart';
import 'package:project/Views/RegistrationView.dart';
import 'package:project/Views/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import 'DefaultButton.dart';
import 'FormError.dart';
import 'SizeConfig.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginView();
  }
}

class _loginView extends State<LoginView> {
  String phoneNumber;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  final _formKey = GlobalKey<FormState>();

  void _btnLogin() async{

  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          return ModalProgressHUD(
              inAsyncCall: model.isBusy,
              progressIndicator: getLoader(),
          color: Colors.white,
          child:
          Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: _formKey,
                        child: Center(
                            child: ListView(
                                physics: new ClampingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/DigitalIndia.png"),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.02),
//                      Text(
//                        "Welcome Back",
//                        style: TextStyle(
//                          color: Colors.black,
//                          fontSize: getProportionateScreenWidth(28),
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      Text(
//                        "Sign in with your mobile number",
//                        textAlign: TextAlign.center,
//                      ),
                                  Theme(
                                    child: TextFormField(
                                      onSaved: (newValue) =>
                                          phoneNumber = newValue,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          suffixIcon: Icon(Icons.phone_android),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          hintText: "Enter MobileNo",
                                          labelText: "MobileNo"),
                                      cursorColor: Colors.orange,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Please enter mobileno";
                                        } else if (value.length != 10) {
                                          return "Please enter valid mobile no";
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                    data: Theme.of(context).copyWith(
                                      primaryColor: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5)),
                                  DefaultButton(
                                    text: "Send OTP",
                                    press: () async{
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        var info = phoneNumber;
                                        final respo = await model.SendOTPToUser(phoneNumber);
                                        if(respo.status){
                                          Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) => new OTPView(phoneNumber)));
                                        }
                                        else{
                                          Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                        }
                                      }

                                    },
                                  ),

                                  Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Don't Have An Account? "),
                                        GestureDetector(
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistrationView(
                                                            true)));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
//                      Container(
//                        height: 50,
//                        child: GestureDetector(
//                          child: Text(
//                            "Forgot Password?",
//                            style: TextStyle(
//                                color: Colors.orange,fontWeight: FontWeight.bold
//                            ),
//                          ),
//                          onTap: (){
//
//                          },
//                        ),
//                      )
                                ],
                              ),
                            ])),
                      ),
                    )),
              )),
          );
        });
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: iPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: iPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_android),
      ),
    );
  }
}
