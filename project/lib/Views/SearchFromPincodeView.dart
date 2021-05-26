import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart' as handle;
import 'package:permission_handler/permission_handler.dart';
import 'package:project/Models/CityList.dart';
import 'package:project/Models/StateList.dart';
import 'package:project/ViewModels/LoginViewModel.dart';
import 'package:project/ViewModels/SearchFromPinCodeViewModel.dart';
import 'package:project/Views/OTPView.dart';
import 'package:project/Views/RegistrationView.dart';
import 'package:project/Views/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import 'DefaultButton.dart';
import 'FormError.dart';
import 'ProjectListView.dart';
import 'SizeConfig.dart';

class SearchFromPincode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _searchFromPincode();
  }
}

class _searchFromPincode extends State<SearchFromPincode> {
  String phoneNumber;
  bool isLocationClick = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> errors = [];
  SearchFromPinCodeViewModel vm = SearchFromPinCodeViewModel();
  List<StateListData> stateListData = List();
  List<CityListData> cityListData = List();
  List<CityListData> _tempListOfCities = List();
  List<StateListData> _tempListOfState = List();

  String _selectedState;
  String _selectedCity;
  var _cityList = List<DropdownMenuItem>();
  var _stateList = List<DropdownMenuItem>();

  @override
  void initState() {
    print("init Call");
    GetStateList().then((StateList value) {
      stateListData = value.data;
      _tempListOfState=value.data;
      stateListData.forEach((state) {
        _stateList.add(DropdownMenuItem(
          child: Text(state.stateName),
          value: state.stateName,
        ));
      });
//      //FilterProjecttype= projectList.distinct((d) => d.projectCategoryName).toList();

    });

    GetCityList().then((CityList value) {
      cityListData = value.data;
      _tempListOfCities = cityListData;
      cityListData.forEach((city) {
        _cityList.add(DropdownMenuItem(
          child: Text(city.metroCity),
          value: city.metroCity,
        ));
      });
//      //FilterProjecttype= projectList.distinct((d) => d.projectCategoryName).toList();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<StateList> GetStateList() async {
    // do something here
    return await vm.GetStateList();
  }

  Future<CityList> GetCityList() async {
    // do something here
    isLoading = true;
    return await vm.GetCityList();
  }

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

  void _btnLocation() async {

    var status = await handle.Permission.location.status;
    if (status.isDenied || status.isUndetermined || status.isGranted) {
      if (await handle.Permission.location.request().isGranted) {
        FocusScope.of(context).requestFocus(FocusNode());
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        var results =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var postelcode = results.first.postalCode;
        final split = results.first.addressLine.split(',');
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++) i: split[i]
        };
        print(values.length - 2);
        pincode.text = (postelcode != null) ? postelcode : "";
//        state.text=results.first.adminArea;//values[values.length-2];
//        city.text=results.first.locality;
        pincode.selection = TextSelection.fromPosition(
            TextPosition(offset: pincode.text.length));
        FocusScope.of(context).requestFocus(FocusNode());
        isLocationClick = true;
        setState(() {});
        print(results.first.locality);
      } else {
        Toast.show("Please give permission from settings", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await handle.openAppSettings();
      }
    }

  }

  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController searchCity = TextEditingController();
  TextEditingController SearchState = TextEditingController();

//  TextEditingController city = TextEditingController();
//  TextEditingController state = TextEditingController();
  bool isLoading = true;
  static const List<String> choices = <String>[
    "Referesh"
  ];
  String _selectedChoices;
  void _select(String choice) {
    setState(() {
      _selectedChoices = choice;
      switch (_selectedChoices) {
        case "Referesh":
          _formKey.currentState.reset();
          setState(() {

          });
          break;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchFromPinCodeViewModel>.reactive(
        viewModelBuilder: () => SearchFromPinCodeViewModel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          return KeyboardDismisser(
              gestures: [
                GestureType.onTap,
                GestureType.onPanUpdateDownDirection,
              ],
              child: ModalProgressHUD(
                inAsyncCall: isLoading,
                progressIndicator: getLoader(),
                color: Colors.white,
                child: Scaffold(
                    key: _scaffoldKey,
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                        centerTitle: true,
                        title: Text("Search from Location",
                            style: TextStyle(fontSize: 18)),
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                Color(0xffff8000),
                                Color(0xff008000)
                              ])),
                        ),
//                      actions: <Widget>[
//                        PopupMenuButton(
//                          icon: Icon(Icons.more_vert, color: Colors.white,),
//                          onSelected: _select,
//                          padding: EdgeInsets.zero,
//                          // initialValue: choices[_selection],
//                          itemBuilder: (BuildContext context) {
//                            return choices.map((String choice) {
//                              return  PopupMenuItem<String>(
//                                height: 25,
//                                value: choice,
//                                child: Text(choice),
//                              );}
//                            ).toList();
//
//                          },
//                          offset: Offset(0, 40),
//                        )
//                      ],
                    ),
                    body: Stack(
                      children: <Widget>[
//                    Image(
//                      image: AssetImage("assets/images/LocationBackground.gif"),
//                      width: MediaQuery.of(context).size.width,
//                      height: MediaQuery.of(context).size.height,
//                      fit: BoxFit.cover,
//                    ),

                        Container(
                          color: Colors.white.withOpacity(0.7),
                          height: MediaQuery.of(context).size.height,
                          child: Form(
                            key: _formKey,
                            child: Center(
                                child: ListView(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 40),
                                    physics: new ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Theme(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value != 6) {
                                              isLocationClick = false;
                                              setState(() {});
                                            }
                                          },
                                          cursorColor: Colors.orange,
                                          decoration: InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            labelText: "Pincode",
                                            hintText: "Enter pincode",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                _formKey.currentState.reset();
                                                _btnLocation();
                                                pincode.selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset: pincode
                                                                .text.length));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(20),
                                               child: Icon(
                                                  Icons.location_searching_outlined,
                                                  color: Colors.orange,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.orange,
                                                        blurRadius: 5.0,
                                                        spreadRadius: 2.0,
                                                      ),
                                                    ]
                                                ),
                                              ),

                                            ),
                                          ),
                                          controller: pincode,
//                                          validator: (String value){
//                                            if(value.length!=6){
//                                              return "Please enter valid pincode ";
//                                            }
//                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                        data: Theme.of(context).copyWith(
                                          primaryColor: Colors.orange,
                                        ),
                                      ),
//                                      (isLocationClick)?SizedBox(height: 10,):Container(),
//                                      (isLocationClick)?Theme(
//                                        child:
//                                        TextFormField(
//                                          enabled: false,
//                                          decoration: InputDecoration(
//                                            enabledBorder: OutlineInputBorder(
//                                              borderRadius: BorderRadius.circular(10.0),
//                                              borderSide: BorderSide(
//                                                color: Colors.black,
//                                                width: 2.0,
//                                              ),
//                                            ),
//                                            hintStyle: TextStyle(color: Colors.black),
//                                            labelStyle:TextStyle(color: Colors.black),
//                                            border: new OutlineInputBorder(
//                                              borderRadius: const BorderRadius.all(
//                                                const Radius.circular(10.0),
//                                              ),
//                                            ),
//                                            labelText: "City",
//                                            hintText: "Enter city",
//                                            floatingLabelBehavior: FloatingLabelBehavior.always,
//
//                                          ),
//                                          controller: city,
//                                          keyboardType:TextInputType.text,
//                                        ),
//                                        data: Theme.of(context).copyWith(
//                                          primaryColor: Colors.orange,
//                                        ),
//                                      ):Container(),
//                                      (isLocationClick)?SizedBox(height: 10,):Container(),
//                                      (isLocationClick)?Theme(
//                                        child:
//                                        TextFormField(
//                                          enabled: false,
//                                          decoration: InputDecoration(
//                                            enabledBorder: OutlineInputBorder(
//                                              borderRadius: BorderRadius.circular(10.0),
//                                              borderSide: BorderSide(
//                                                color: Colors.black,
//                                                width: 2.0,
//                                              ),
//                                            ),
//                                            hintStyle: TextStyle(color: Colors.black),
//                                            labelStyle:TextStyle(color: Colors.black),
//                                            border: OutlineInputBorder(
//                                              borderRadius: const BorderRadius.all(
//                                                Radius.circular(10.0),
//                                              ),
//                                            ),
//                                            labelText: "State",
//                                            hintText: "Enter state",
//                                            floatingLabelBehavior: FloatingLabelBehavior.always,
//
//                                          ),
//                                          controller: state,
//                                          keyboardType:TextInputType.text,
//                                        ),
//                                        data: Theme.of(context).copyWith(
//                                          primaryColor: Colors.orange,
//                                        ),
//                                      ):Container(),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Or",
                                        style: TextStyle(
                                            fontSize: 16,
                                            foreground: Paint()
                                              ..shader = linearGradient,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      (cityListData != null)
                                          ? GestureDetector(
                                              child: Theme(
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black),
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        const Radius.circular(
                                                            10.0),
                                                      ),
                                                    ),
                                                    labelText: "City",
                                                    hintText: "Select city",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    suffixIcon: Icon(
                                                        Icons.arrow_drop_down,color: Colors.orange,),
                                                  ),
                                                  controller: searchCity,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                data:
                                                    Theme.of(context).copyWith(
                                                  primaryColor: Colors.orange,
                                                ),
                                              ),
                                              onTap: () {
                                                _showCityModal(context);
                                              },
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Or",
                                        style: TextStyle(
                                            fontSize: 16,
                                            foreground: Paint()
                                              ..shader = linearGradient,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      (stateListData != null)
                                          ? GestureDetector(
                                        child: Theme(
                                          child: TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border:
                                              new OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                  const Radius.circular(
                                                      10.0),
                                                ),
                                              ),
                                              labelText: "State",
                                              hintText: "Select state",
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior
                                                  .always,
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,color: Colors.orange,),
                                            ),
                                            controller: SearchState,
                                            keyboardType:
                                            TextInputType.text,
                                          ),
                                          data:
                                          Theme.of(context).copyWith(
                                            primaryColor: Colors.orange,
                                          ),
                                        ),
                                        onTap: () {
                                          _showStateModal(context);
                                        },
                                      )
                                          : Container(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DefaultButton(
                                        text: "Browse",
                                        press: () async {
                                          var c = pincode.text;
                                          if (searchCity.text == "" &&
                                              SearchState.text == "" &&
                                              pincode.text == "") {
                                            Toast.show(
                                                "Please select any one from above",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          } else {
                                            var search = "";
                                            if (pincode.text != "")
                                              search = pincode.text;
                                            else if (searchCity.text != null&&searchCity.text!="")
                                              search = searchCity.text;
                                            else if (SearchState.text != null&&SearchState.text!="")
                                              search = SearchState.text;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProjectListView(search,
                                                            "location")));
                                            _formKey.currentState.reset();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ])),
                          ),
                        )
                      ],
                    )),
              ));
        });
  }

  void _showCityModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Theme(
                        child: TextField(
                            cursorColor: Colors.orange,
                            controller: city,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (value) {
                              //4
                              setState(() {
                              _tempListOfCities = _buildSearchCityList(value);

                              });
                            }),
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.orange,
                        ),
                      )),
                      IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.orange,
                          onPressed: () {
                            if(city.text==""){
                              Navigator.of(context).pop();
                            }
                            else
                            setState(() {
                              city.clear();
                              _tempListOfCities = cityListData;
                            });
                          }),
                    ])),
                Expanded(
                  child: ListView.separated(
                      //5
                      itemCount: (_tempListOfCities != null &&
                              _tempListOfCities.length > 0)
                          ? _tempListOfCities.length
                          : cityListData.length,
                      separatorBuilder: (context, int) {
                        return Container();
                      },
                      itemBuilder: (context, index) {
                        return InkWell(

                            //6
                            child: (_tempListOfCities != null &&
                                    _tempListOfCities.length > 0)
                                ? _showCityBottomSheetWithSearch(
                                    index, _tempListOfCities)
                                : _showCityBottomSheetWithSearch(
                                    index, null),
                            onTap: () {
                              //7
//                              _scaffoldKey.currentState.showSnackBar(SnackBar(
//                                  behavior: SnackBarBehavior.floating,
//                                  content: Text((_tempListOfCities != null &&
//                                          _tempListOfCities.length > 0)
//                                      ? _tempListOfCities[index].metroCity
//                                      : cityListData[index].metroCity)));
                              city.text = (_tempListOfCities != null &&
                                      _tempListOfCities.length > 0)
                                  ? _tempListOfCities[index].metroCity
                                  : cityListData[index].metroCity;
                              searchCity.text=city.text;
                              city.clear();
                              _tempListOfCities = cityListData;
                              setState(() {});
                              Navigator.of(context).pop();
                            });
                      }),
                )
              ]),
            );
          });
        }
        //3

        );
  }

  //8
  Widget _showCityBottomSheetWithSearch(
      int index, List<CityListData> listOfCities) {
    return (listOfCities!=null)?
      Card(
        margin: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 5),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(listOfCities[index].metroCity,
              style: TextStyle(color: Colors.black87, fontSize: 16),
              textAlign: TextAlign.center),
        ),
      ):Container();
    }

  //9
  List<CityListData> _buildSearchCityList(String userSearchTerm) {
    List<CityListData> _searchList = List();

    for (int i = 0; i < cityListData.length; i++) {
      String name = cityListData[i].metroCity;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(cityListData[i]);
      }
    }
    if (userSearchTerm == "") {
      _searchList = cityListData;
    }
    return _searchList;
  }


  void _showStateModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Theme(
                                child: TextField(
                                    cursorColor: Colors.orange,
                                    controller: state,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      //4
                                      _tempListOfState = _buildSearchStateList(value);
                                      setState(() {


                                      });
                                    }),
                                data: Theme.of(context).copyWith(
                                  primaryColor: Colors.orange,
                                ),
                              )),
                          IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.orange,
                              onPressed: () {
                                if(state.text==""){
                                  Navigator.of(context).pop();
                                }
                                else
                                  setState(() {
                                    state.clear();
                                    _tempListOfState = stateListData;
                                  });
                              }),
                        ])),
                    Expanded(
                      child: ListView.separated(
                        //5
                          itemCount: (_tempListOfState != null &&
                              _tempListOfState.length > 0)
                              ? _tempListOfState.length
                              : stateListData.length,
                          separatorBuilder: (context, int) {
                            return Container();
                          },
                          itemBuilder: (context, index) {
                            return InkWell(

                              //6
                                child: (_tempListOfState != null &&
                                    _tempListOfState.length > 0)
                                    ? _showStateBottomSheetWithSearch(
                                    index, _tempListOfState)
                                    : _showStateBottomSheetWithSearch(
                                    index, null),
                                onTap: () {
                                  //7
//                              _scaffoldKey.currentState.showSnackBar(SnackBar(
//                                  behavior: SnackBarBehavior.floating,
//                                  content: Text((_tempListOfCities != null &&
//                                          _tempListOfCities.length > 0)
//                                      ? _tempListOfCities[index].metroCity
//                                      : cityListData[index].metroCity)));
                                  state.text = (_tempListOfState != null &&
                                      _tempListOfState.length > 0)
                                      ? _tempListOfState[index].stateName
                                      : stateListData[index].stateName;
                                  SearchState.text=state.text;
                                  state.clear();
                                  _tempListOfState = stateListData;
                                  setState(() {});
                                  Navigator.of(context).pop();

                                });
                          }),
                    )
                  ]),
                );
              });
        }
      //3

    );
  }

  //8
  Widget _showStateBottomSheetWithSearch(
      int index, List<StateListData> listOfState) {
    return (listOfState!=null)?
    Card(
      margin: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(listOfState[index].stateName,
            style: TextStyle(color: Colors.black87, fontSize: 16),
            textAlign: TextAlign.center),
      ),
    ):Container();
  }

  //9
  List<StateListData> _buildSearchStateList(String userSearchTerm) {
    List<StateListData> _searchList = List();

    for (int i = 0; i < stateListData.length; i++) {
      String name = stateListData[i].stateName;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(stateListData[i]);
      }
    }
    if (userSearchTerm == "") {
      _searchList = stateListData;
    }
    return _searchList;
  }


}
