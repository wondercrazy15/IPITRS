import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/ProjectList.dart';
import 'package:project/ViewModels/ProjectListByLocationViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:darq/darq.dart';
import 'FilterView.dart';
import 'ProjectView.dart';
import 'constants.dart';

class ProjectListByLocationView extends StatefulWidget {
  String listBy;
  String fieldName;
  ProjectListByLocationView(this.listBy,this.fieldName);

  @override
  State<StatefulWidget> createState() {
    return _projectListByLocationView(listBy,fieldName);
  }

}

class _projectListByLocationView extends State<ProjectListByLocationView>{
  FocusNode myFocusNode;
  Project p;
  List<Data> projectList= List();
  List<Data> filteredProject = List();
  List<Data> filteredAllProject = List();
  List<Data> FilterProjecttype = List();

  String listBy;
  String fieldName;
  _projectListByLocationView(this.listBy,this.fieldName);
  bool isFilter =false;
  bool isFilterCity =false;
  List<String> suggestions = List();
  bool isLoading=true;
  AutoCompleteTextField textField;
  TextEditingController controller = new TextEditingController();
  ProjectListByLocationViewModel vm= new ProjectListByLocationViewModel();
  @override
  void initState() {
    myFocusNode= FocusNode();

    print("init Call");
    GetProjectList().then((ProjectList value) {

      projectList=value.data;
      filteredProject=value.data;
      FilterProjecttype= projectList.distinct((d) => d.projectCategoryName).toList();

      setState(() {
        isLoading=false;
      });
      if(this.listBy=="Location")
      {
        textField=AutoCompleteTextField<Data>(
          focusNode: myFocusNode,
          key: key,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search by ${listBy}',
              hintStyle: TextStyle(color: Colors.white)),
          controller: TextEditingController(),
          suggestions: projectList,
          itemBuilder: (context, item) {
            return
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(item.location,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,),)

                    ],
                  ),
                ),
              );
          },
          itemSorter: (a, b) {
            return a.location.compareTo(b.location);
          },
          itemFilter: (item, query) {
            return item.location
                .toLowerCase()
                .contains(query.toLowerCase());
          },
          textChanged: (string) {
            _debouncer.run(() {
              setState(() {
                currentText=string;
                filteredProject = projectList
                    .where((u) => (u.location
                    .toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });
            });
          },
          clearOnSubmit: false,
          itemSubmitted: (text) => setState(() {
            if (text != "") {
              setState(() {
                textField.textField.controller.text =
                    text.location;
              });
              _debouncer.run(() {
                print(text);
                setState(() {
                  filteredProject = projectList
                      .where((u) => (u.location
                      .toLowerCase()
                      .contains(text.location.toLowerCase())))
                      .toList();

                });
              });
            }
          }

          ),

        );

      }
      else if(this.listBy=="ContractorName")
      {
        textField=AutoCompleteTextField<Data>(
          focusNode: myFocusNode,
          key: key,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),

              ),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search by ${listBy}',
              hintStyle: TextStyle(color: Colors.white)),
          controller: TextEditingController(),
          suggestions: projectList,
          itemBuilder: (context, item) {
            return
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(

                    children: <Widget>[
                      Expanded(child: Text(item.contractorName,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,),)

                    ],
                  ),
                ),
              );
          },
          itemSorter: (a, b) {
            return a.contractorName.compareTo(b.contractorName);
          },
          itemFilter: (item, query) {
            return item.contractorName
                .toLowerCase()
                .contains(query.toLowerCase());
          },
          textChanged: (string) {
            _debouncer.run(() {
              setState(() {
                currentText=string;
                filteredProject = projectList
                    .where((u) => (u.contractorName
                    .toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });
            });
          },
          clearOnSubmit: false,
          itemSubmitted: (text) => setState(() {
            if (text != "") {
              setState(() {
                textField.textField.controller.text =
                    text.contractorName;
              });
              _debouncer.run(() {
                print(text);
                setState(() {
                  filteredProject = projectList
                      .where((u) => (u.contractorName
                      .toLowerCase()
                      .contains(text.contractorName.toLowerCase())))
                      .toList();

                });
              });
            }
          }

          ),

        );
      }
      else if(this.listBy=="Type"){
        textField=AutoCompleteTextField<Data>(
          focusNode: myFocusNode,
          key: key,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),

              ),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search by ${listBy}',
              hintStyle: TextStyle(color: Colors.white)),
          controller: TextEditingController(),
          suggestions: FilterProjecttype,
          itemBuilder: (context, item) {
            return
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(

                    children: <Widget>[
                      Expanded(child: Text(item.projectCategoryName,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,),)


                    ],
                  ),
                ),
              );
          },
          itemSorter: (a, b) {
            return a.projectCategoryName.compareTo(b.projectCategoryName);
          },

          itemFilter: (item, query) {

            var distinct = filteredProject.distinct((d) => d.projectCategoryName).toList();
              //[const unique = ...new Set(array.map(item => item.projectCategoryName))]
              return
              item.projectCategoryName
                .toLowerCase()
                .contains(query.toLowerCase());
          },

          textChanged: (string) {
            _debouncer.run(() {
              setState(() {
                currentText=string;
                filteredProject = projectList
                    .where((u) => (u.projectCategoryName
                    .toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });
            });
          },
          clearOnSubmit: false,
          itemSubmitted: (text) => setState(() {
            if (text != "") {
              setState(() {
                textField.textField.controller.text =
                    text.projectCategoryName;
              });
              _debouncer.run(() {
                print(text);
                setState(() {
                  filteredProject = projectList
                      .where((u) => (u.projectCategoryName
                      .toLowerCase()
                      .contains(text.projectCategoryName.toLowerCase())))
                      .toList();

                });
              });
            }
          }

          ),

        );
      }
    });

    super.initState();
  }
  Future<ProjectList> GetProjectList() async {
    // do something here

    return await vm.GetProjectListInfo();
  }


  bool isSearching = false;
  final _debouncer = Debouncer(milliseconds: 500);
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<Data>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: getLoader(),
          color: Colors.white,
          child:
          Scaffold(
              appBar: AppBar(
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xffff8000),Color(0xff008000)
                          ])
                  ),),
                title: !isSearching
                    ? Text('Project List ${listBy}',style: TextStyle(fontSize: 18),overflow: TextOverflow.fade,maxLines: 1,softWrap: false)
                    :textField,

                actions: <Widget>[
                  isSearching
                      ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        currentText="";
                        this.isSearching = false;
                        textField.textField.controller.text ="";
                        filteredProject=projectList;
                      });
                    },
                  )
                      : IconButton(
                    icon: Icon(Icons.search),
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
              body:
              InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: (projectList!=null)
                    ?Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(5.0),
                        itemCount: filteredProject.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            GestureDetector( //You need to make my child interactive
                              onTap: ()  {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>ProjectView(filteredProject[index].code)
                                        ));
                              },
                              child:Card(
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: filteredProject[index].imagePath,fit: BoxFit.cover,
                                        placeholder: (context, url) => getImageLoader(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        width: MediaQuery.of(context).size.width - 30,
                                        height: MediaQuery.of(context).size.height /4.5,
                                      ),

                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5,right: 5,top: 5),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(CupertinoIcons.square_stack_3d_up,color: Colors.orange,),
                                            SizedBox(
                                              width: 3.0,
                                            ),
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(filteredProject[index].name,)
                                                  ],
                                                )),
                                          ],
                                        ),

                                      ),
                                      Divider(
                                        thickness: 1.5,
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5,right: 5),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(CupertinoIcons.map_pin_ellipse,color: Colors.orange,),
                                            SizedBox(
                                              width: 3.0,
                                            ),
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(filteredProject[index].location,)
                                                  ],
                                                )),
                                          ],

                                        ),

                                      ),
                                      Divider(
                                        thickness: 1.5,
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5,right: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 3.3,
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(CupertinoIcons.info,color: Colors.orange,),
                                                  SizedBox(
                                                    width: 3.0,
                                                  ),
                                                  Expanded(

                                                    child:Text(filteredProject[index].status,overflow: TextOverflow.fade,maxLines: 1,softWrap: false,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(CupertinoIcons.person_circle,color: Colors.orange,),
                                                    SizedBox(
                                                      width: 3.0,
                                                    ),
                                                    Expanded(

                                                      child:Text(filteredProject[index].contractorName,overflow: TextOverflow.fade,maxLines: 1,softWrap: false,),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),


                                ),

                              ),);
                        },
                      ),
                    ),

                  ],
                ):Container(),
              )

          )
      ),
    );

  }


}
