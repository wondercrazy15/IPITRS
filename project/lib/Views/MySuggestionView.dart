import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:project/Models/Suggestions.dart';
import 'package:project/ViewModels/MyRatingReviewViewModel.dart';
import 'package:project/ViewModels/MySuggestionViewModel.dart';
import 'package:project/Views/ProjectView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';
import 'constants.dart';

class MySuggestionView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _mySuggestionView();
  }

}

class _mySuggestionView extends State<MySuggestionView> {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MySuggestionViewModel>.reactive(
        viewModelBuilder: () => MySuggestionViewModel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          return KeyboardDismisser(
            gestures: [
              GestureType.onTap,
              GestureType.onPanUpdateDownDirection,
            ],
            child: ModalProgressHUD(
                opacity: 0.5,
                inAsyncCall: model.isBusy,
                progressIndicator: getLoader(),
                color: Colors.white,
                child:
                Scaffold(
                  appBar: AppBar(
                      centerTitle: true,
                      title: Text("My Suggestions for Application",style: TextStyle(fontSize: 18)),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Color(0xffff8000), Color(0xff008000)
                                ])
                        ),
                      )
                  ),
                  body:
                  (model.mySuggestionsList.data!=null)?SafeArea(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: new ClampingScrollPhysics(),
                      itemCount: model.mySuggestionsList.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Icon(CupertinoIcons.info_circle,color: Colors.orange,),
                                      SizedBox(width: 10,),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text((model.mySuggestionsList.data[index].version!=null)?
                                              model.mySuggestionsList.data[index].version:"",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold
                                                ),),

                                              SizedBox(height: 5,),
                                              Text((model.mySuggestionsList.data[index].description!=null)?
                                              model.mySuggestionsList.data[index].description:"",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),

                                              SizedBox(height: 5,),
                                              Align(
                                                heightFactor: 1,
                                                alignment: Alignment
                                                    .bottomRight,
                                                child: Text(getDate(model.mySuggestionsList.data[index].createdAt,),
                                                  style: TextStyle(
                                                   fontWeight: FontWeight.bold
                                                  ),
                                                  textAlign: TextAlign.end,),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),

                                ],
                              )
                          ),

                        );
                      },
                    ),
                  )
                      :Container(child: Center(child:
                  Text(model.Info),
                  ),),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      _showRatingBar(context,model);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.orange,
                  ),
                )),
          );
        });

  }
  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;

  }
  final _formKey = GlobalKey<FormState>();
  String suggestion;
  String UserId;
  void _showRatingBar(context, MySuggestionViewModel model) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SafeArea(
              child:
              SingleChildScrollView(
                  child:
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text(
                            "Give your Suggestion for this Application",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),

                          Theme(
                            child: TextFormField(
                              autofocus: true,
                              onSaved: (newValue) => suggestion = newValue,
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: "Enter Your Suggestion",
                                  labelText: "Suggestion"

                              ),
                              keyboardType: TextInputType.multiline,
                              maxLength: null,
                              maxLines: 5,
                              cursorColor: Colors.orange,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Please Write Suggestion";
                                }
                                else if(value.length<10){
                                  return "Please enter Suggestion more then 5 character";
                                }

                              },
                            ),
                            data: Theme.of(context)
                                .copyWith(primaryColor: Colors.orange,),

                          ),

                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width-200,
                              child: RaisedButton(
                                onPressed: () async{
                                  if(_formKey.currentState.validate())
                                  {
                                    _formKey.currentState.save();
                                    bool connected = await IsConnected();
                                    if(!connected){
                                      Toast.show(msgNoInternet, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                      return;
                                    }

                                    Navigator.pop(context);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(prefs.getString("UserId")!=null)
                                      UserId = prefs.getString("UserId");

                                    final respo = await model.AddAppSuggestion(Suggestions(
                                      description: suggestion,
                                      version: model.Version,
                                      userID: UserId,
                                    ));
                                    if(respo.status){
                                      model.GetMySuggestionsList();
                                      setState(() {

                                      });
                                      Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    }
                                    else{
                                      Toast.show(msgError, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(

                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [Color(0xffFF9933), Color(0xff58A451)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),

                                  child:
                                  Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Submit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                          ),
                        ],
                      ),
                    ),
                  )
              )

          );
        }
    );
  }
}