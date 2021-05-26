import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/ViewModels/SearchFromContractorViewModel.dart';
import 'ProjectListView.dart';
import 'ProjectView.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class SearchFromContractorView extends StatefulWidget {
  SearchFromContractorView();

  @override
  State<StatefulWidget> createState() {
    return _searchFromContractorView();
  }
}

class _searchFromContractorView extends State<SearchFromContractorView> {
  FocusNode myFocusNode;
  Project p;
  List<ContractorListData> contractorList = List();
  List<ContractorListData> filteredcontractorList = List();

  bool isLoading = true;
  AutoCompleteTextField textField;
  SearchFromContractorViewModel vm = new SearchFromContractorViewModel();

  @override
  void initState() {
    myFocusNode = FocusNode();

    print("init Call");
    GetContractorList().then((ListContractor value) {
      contractorList = value.data;
      filteredcontractorList = value.data;
      //FilterProjecttype= projectList.distinct((d) => d.projectCategoryName).toList();
      setState(() {
        isLoading = false;
      });

    });

    super.initState();
  }

  Future<ListContractor> GetContractorList() async {
    // do something here
    return await vm.GetContractorList();
  }

  bool isSearching = false;
  final _debouncer = Debouncer(milliseconds: 500);
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<ContractorListData>> key =
      new GlobalKey();
  TextEditingController Search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.orange
    ));
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
                appBar: AppBar(
                    centerTitle: true,
                    title: !isSearching
                        ? Text('Contractor List',style: TextStyle(fontSize: 18),overflow: TextOverflow.fade,maxLines: 1,softWrap: false)
                        :Theme(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: 'Enter contractor name',
                            hintStyle: TextStyle(color: Colors.white)),

                        onChanged: (string) {
                          _debouncer.run(() {
                            setState(() {

                              filteredcontractorList = contractorList
                                  .where((u) => (u.name
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                                  .toList();
                            });
                          });
                        },
                        focusNode: myFocusNode,
                        controller: Search,
                        key: key,


                        cursorColor: Colors.orange,
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.orange,
                      ),
                    ),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xffff8000),Color(0xff008000)
                              ])
                      ),),
                    actions: <Widget>[
                      isSearching
                          ? IconButton(
                        icon: Icon(Icons.cancel,color: Colors.white,),
                        onPressed: () {
                          setState(() {
                            Search.text = "";
                            this.isSearching = false;
                            filteredcontractorList = contractorList;
                          });
                        },
                      )
                          : IconButton(
                        icon: Icon(Icons.search,color: Colors.white),
                        onPressed: () {
                          setState(() {
                            myFocusNode.requestFocus();
//                FocusScope.of(context).requestFocus(myFocusNode);
                            this.isSearching = true;
                          });
                        },
                      ),

    ],
                ),
                body: Container(
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          begin: Alignment.topLeft,
//                          end: Alignment.bottomRight,
//                          colors: <Color>[
//                            Color(0xffFF9955),Color(0xff58A444)
//                          ])
//                  ),
                  child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: (filteredcontractorList != null)
                          ? Column(
                        children: <Widget>[
//                          Padding(padding:EdgeInsets.only(left: 10,right: 10,top: 10),
//                            child: Theme(
//                              child: TextField(
//                                decoration: InputDecoration(
//                                  hintStyle: TextStyle(color: Colors.white),
//                                  labelStyle:TextStyle(color: Colors.white),
//                                  focusedBorder: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(25.0),
//                                    borderSide: BorderSide(
//                                      color: Colors.white70,
//                                    ),
//                                  ),
//                                  enabledBorder: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(25.0),
//                                    borderSide: BorderSide(
//                                      color: Colors.white,
//                                      width: 2.0,
//                                    ),
//                                  ),
//                                  contentPadding:
//                                  EdgeInsets.symmetric(
//                                      vertical: 15,
//                                      horizontal: 15),
//
//                                  suffixIcon:
//                                  isSearching
//                                      ? IconButton(
//                                    icon: Icon(Icons.cancel,color: Colors.white,),
//                                    onPressed: () {
//                                      setState(() {
//                                        Search.text = "";
//                                        this.isSearching = false;
//                                        filteredcontractorList = contractorList;
//                                      });
//                                    },
//                                  )
//                                      : IconButton(
//                                    icon: Icon(Icons.search,color: Colors.white),
//                                    onPressed: () {
//                                      setState(() {
//                                        myFocusNode.requestFocus();
////                FocusScope.of(context).requestFocus(myFocusNode);
//                                        this.isSearching = true;
//                                      });
//                                    },
//                                  ),
//                                  floatingLabelBehavior:
//                                  FloatingLabelBehavior
//                                      .always,
//                                  border: new OutlineInputBorder(
//                                    borderRadius:
//                                    const BorderRadius.all(
//                                      const Radius.circular(5.0),
//                                    ),
//                                  ),
//                                  labelText: "Search",
//                                  hintText: "Enter contractorname",
//                                ),
//                                onChanged: (string) {
//                                  _debouncer.run(() {
//                                    setState(() {
//                                      if(string==""){isSearching=false;}
//                                      else{isSearching=true;}
//                                      filteredcontractorList = contractorList
//                                          .where((u) => (u.name
//                                          .toLowerCase()
//                                          .contains(string.toLowerCase())))
//                                          .toList();
//                                    });
//                                  });
//                                },
//
//                                focusNode: myFocusNode,
//                                controller: Search,
//                                key: key,
//                                style: TextStyle(color: Colors.black),
//
//                                cursorColor: Colors.orange,
//                              ),
//                              data: Theme.of(context).copyWith(
//                                primaryColor: Colors.orange,
//                              ),
//                            ),
//                          ),

                          Expanded(
                            child: ListView.builder(
                              physics: new ClampingScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(5.0),
                              itemCount: filteredcontractorList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 5,
                                    color: Colors.white,
                                    child:
                                    ListTile(
                                      onTap: ()async{
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                                ProjectListView(
                                                    filteredcontractorList[index].name,
                                                    "contractorName")
                                        ));
                                      },
                                      title: Text(filteredcontractorList[index].name,style: TextStyle(foreground: Paint()..shader = linearOrangeGradient),),
                                      trailing: Icon(Icons.arrow_forward_ios,color: iconGreenColor,),
                                    )
                                );
                              },
                            ),
                          ),
                        ],
                      )
                          : Container(),
                    ),
                  )
                )
            ),

      ),
    );
  }
}
