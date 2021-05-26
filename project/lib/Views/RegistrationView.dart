import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Registration.dart';
import 'package:project/ViewModels/RegistrationViewModel.dart';
import 'package:project/Views/LoginView.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import 'DefaultButton.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class RegistrationView extends StatefulWidget{
  bool isFromLogin;
  RegistrationView(this.isFromLogin);

  @override
  State<StatefulWidget> createState() {
    return _registrationView(this.isFromLogin);
  }

}

class _registrationView extends State<RegistrationView> {
  String phoneNumber;
  String userName;
  String Email;
  bool isFromLogin;
  final _formKey = GlobalKey<FormState>();

  _registrationView(this.isFromLogin);
  
  @override

  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return ViewModelBuilder<RegistrationViewModel>.reactive(
    viewModelBuilder: () => RegistrationViewModel(),
    onModelReady: (model) async => await model.initModel(context),
    builder: (context, model, child) {
    return
      ModalProgressHUD(
        opacity: 0.5,
        inAsyncCall: model.isBusy,
        progressIndicator: getLoader(),
        color: Colors.white,
        child:
        Scaffold(
            resizeToAvoidBottomInset: false,
            body:
            SafeArea(
              child: InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: Form(
                      key: _formKey,
                      child:
                      Center(

                          child: ListView(
                              physics: new ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                                    Text("Register Account", style: headingStyle),
                                    Text(
                                      "Complete your details",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                                    Theme(
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onSaved: (newValue) =>
                                        userName = newValue,
                                        onEditingComplete: () => node.nextFocus(),

                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                          suffixIcon: Icon(Icons.account_circle_outlined),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          labelText: "Username",
                                          hintText: "Enter Username",

                                        ),
                                        cursorColor: Colors.orange,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Please enter Username";
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                      ),
                                      data: Theme.of(context)
                                          .copyWith(primaryColor: Colors.orange,),

                                    ),
                                    SizedBox(height: getProportionateScreenHeight(20)),
                                    Theme(
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        onSaved: (newValue) =>
                                        Email = newValue,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                          suffixIcon: Icon(Icons.email_outlined),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          labelText: "Email",
                                          hintText: "Enter Email",

                                        ),
                                        cursorColor: Colors.orange,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Please enter Email";
                                          }
                                          else if(!emailValidatorRegExp.hasMatch(value))
                                          {
                                            return "Please enter valid Email";
                                          }

                                        },
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      data: Theme.of(context)
                                          .copyWith(primaryColor: Colors.orange,),

                                    ),
                                    SizedBox(height: getProportionateScreenHeight(20)),
                                    Theme(
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        onEditingComplete: () => node.unfocus(),
                                        onSaved: (newValue) =>phoneNumber = newValue,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                            suffixIcon: Icon(Icons.phone_android),
//                                      focusedBorder: UnderlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.orange),
//                                      ),
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            labelText: "Mobileno",
                                            hintText: "Enter MobileNo",
                                            floatingLabelBehavior: FloatingLabelBehavior.always
                                        ),
                                        cursorColor: Colors.orange,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Please enter mobileno";
                                          }
                                          else if (value.length != 10) {
                                            return "Please enter valid mobile no";
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                      ),
                                      data: Theme.of(context)
                                          .copyWith(primaryColor: Colors.orange,),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10,
                                        bottom: 5)),
                                    DefaultButton(
                                      text: "Registration",
                                      press: () async{
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          print(userName+"  "+Email+"  "+phoneNumber);
                                          final respo = await model.RegistrationUser(Registration(
                                            name:userName,
                                            email: Email,
                                            mobileNumber:phoneNumber,
                                          ));
                                          if(respo.status){
                                            Navigator.pop(context);
                                            Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("You already have an account? "),
                                          GestureDetector(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(color: Colors.orange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {
                                              if(isFromLogin) {
                                                Navigator.pop(context);
                                              }
                                              else{
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context)=>LoginView()
                                                ));
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ])


                      ),
                    ),)
              ),)
        ),
      );
    }
    );
  }
}

