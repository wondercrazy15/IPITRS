import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Login.dart';
import 'package:project/ViewModels/LoginViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';
import 'DefaultButton.dart';
import 'HomeView.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class OTPView extends StatefulWidget{
  String phoneNumber;
  OTPView(this.phoneNumber);
  @override
  State<StatefulWidget> createState() {
    return _OTPView(this.phoneNumber);
  }

}

class _OTPView extends State<OTPView> with SingleTickerProviderStateMixin{
  String phoneNumber;
  _OTPView(this.phoneNumber);
  FocusNode pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 30));
    _controller.forward();
    pin1FocusNode=FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }
  @override
  void dispose() {

    _controller.dispose();
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }
  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }
  final _pin1FocusController = TextEditingController();
  final _pin2FocusController = TextEditingController();
  final _pin3FocusController = TextEditingController();
  final _pin4FocusController = TextEditingController();

  bool _onEditing = true;
  String _code;

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
                body:
                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                            Text(
                              "OTP Verification",
                              style: headingStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("We sent your code to "),
                                Text(phoneNumber),
                              ],
                            ),
                            buildTimer(),
//                  Container(
//                    child: PinEntryTextField(
//                      fieldWidth: (MediaQuery.of(context).size.width /2)/6,
//                      fields: 4,
//                      onSubmit: (String pin){
//
//                      }, // end onSubmit
//                    ),
//                  ),
                            Form(
                              child: Column(
                                children: [
                                  SizedBox(height: SizeConfig.screenHeight * 0.10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: getProportionateScreenWidth(60),
                                        child: TextFormField(
                                          controller: _pin1FocusController,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                          ],
                                          focusNode: pin1FocusNode,
                                          autofocus: true,

                                          style: TextStyle(fontSize: 24),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: otpInputDecoration,
                                          onChanged: (value) {

                                            nextField(value, pin2FocusNode);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(60),
                                        child: TextFormField(
                                            controller: _pin2FocusController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(1),
                                            ],
                                            focusNode: pin2FocusNode,
                                            style: TextStyle(fontSize: 24),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: otpInputDecoration,
                                            onChanged: (value) { nextField(value, pin3FocusNode);
                                            if(value.length<=0){
                                              FocusScope.of(context).requestFocus(pin1FocusNode);
                                            }
                                            }
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(60),
                                        child: TextFormField(
                                            controller: _pin3FocusController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(1),
                                            ],
                                            focusNode: pin3FocusNode,
                                            style: TextStyle(fontSize: 24),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: otpInputDecoration,
                                            onChanged: (value) {
                                              nextField(value, pin4FocusNode);
                                              if(value.length<=0){
                                                FocusScope.of(context).requestFocus(pin2FocusNode);
                                              }
                                            }
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(60),
                                        child: TextFormField(
                                          controller: _pin4FocusController,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                          ],
                                          focusNode: pin4FocusNode,
                                          style: TextStyle(fontSize: 24),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: otpInputDecoration,
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              pin4FocusNode.unfocus();
                                              // Then you need to check is the code is correct or not
                                            }
                                            else if(value.length<=0){

                                              FocusScope.of(context).requestFocus(pin3FocusNode);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight * 0.10),
                                  DefaultButton(
                                    text: "Continue",
                                    press: () async{
                                      _code=_pin1FocusController.text+_pin2FocusController.text+_pin3FocusController.text+_pin4FocusController.text;
                                      print(_code.length);
                                      if(_code.length==4){

                                        final respo = await model.MatchOTP(OTPMatch(
                                          mobileNumber: this.phoneNumber,
                                          otp: _code
                                        ));
                                        if(respo.status){
                                          //Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setBool("IsLogin", true);
                                          prefs.setString("email", respo.data.email);
                                          prefs.setString("UserId", respo.data.userId);
                                          prefs.setString("Profile", respo.data.profileImage);
                                          prefs.setString("MobileNo", respo.data.mobile);
                                          prefs.setString("Token",respo.data.token);
                                          Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => HomeView(),
                                            ),
                                                (Route route) => false,
                                          );
                                        }
                                        else{
                                          Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                        }


                                      }
                                      else{

                                      }

                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                            GestureDetector(
                              onTap: () async{
                                // OTP code resend

                                _controller.reset();
                                _controller.forward();
                                final respo = await model.SendOTPToUser(phoneNumber);
                                if(respo.status){
                                  Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }
                                else{
                                  Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }

                              },
                              child: Text(
                                "Resend OTP Code",
                                style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )

            )
          );
        });

  }
  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
    Countdown(
    animation: StepTween(
    begin: 30 * 60,
    end: 0,
    ).animate(_controller)),
      ],
    );
  }
}
class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 16,
        color: Colors.orange,
      ),
    );
  }
}