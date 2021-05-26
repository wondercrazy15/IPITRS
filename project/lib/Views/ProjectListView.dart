import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/ProjectList.dart';
import 'package:project/ViewModels/ProjectListFromProjectViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FilterView.dart';
import 'ProjectView.dart';
import 'constants.dart';

class ProjectListView extends StatefulWidget {
  String listBy;
  String fieldName;
  ProjectListView(this.listBy,this.fieldName);

  @override
  State<StatefulWidget> createState() {
    return _projectListView(listBy,fieldName);
  }

}

class _projectListView extends State<ProjectListView>{
  FocusNode myFocusNode= FocusNode();
  Project p;
  List<Data> projectList= List();
  List<Data> filteredProject = List();
  List<Data> filteredAllProject = List();

  String listBy;
  String fieldName;
  _projectListView(this.listBy,this.fieldName);
  bool isFilter =false;
  bool isFilterCity =false;
  ProjectListFromProjectViewModel vm= new ProjectListFromProjectViewModel();
  bool isLoading=true;
  String projectName="";
  String ContractorName="";
  String CategoryName="";
  String Location="";
  String status="";
  String title="";
  @override
  void initState() {
      super.initState();
      print("init Call");
      title=this.listBy;
      if(this.fieldName=="contractorName")
      {
        ContractorName=this.listBy;
      }
      else if(this.fieldName=="status")
      {
        status=this.listBy;
      }
      else if(this.fieldName=="location"){
        Location=this.listBy;
      }
      else if(this.fieldName=="Type")
      {
        CategoryName=this.listBy;
      }
      else{

      }
      GetProjectList(projectName,ContractorName,CategoryName,Location,status).then((ProjectList value) {
        projectList=value.data;
        filteredProject=value.data;
        filteredAllProject=value.data;
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
              hintText: 'Search by project name',
              hintStyle: TextStyle(color: Colors.white)),
          controller: TextEditingController(),
          suggestions: filteredProject,
          itemBuilder: (context, item) {
            return
              Container(
                width: 2000,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(

                      children: <Widget>[
                        Expanded(child: Text(item.name,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,),)

                      ],
                    ),
                  ),
                ),
              );
          },
          itemSorter: (a, b) {
            return a.name.compareTo(b.name);
          },
          itemFilter: (item, query) {
            return item.name
                .toLowerCase()
                .contains(query.toLowerCase());
          },
          textChanged: (string) {
            _debouncer.run(() {
              setState(() {
                currentText=string;
                filteredProject = filteredAllProject
                    .where((u) => (u.name
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
                    text.name;
              });
              _debouncer.run(() {
                print(text);
                setState(() {
                  filteredProject = filteredAllProject
                      .where((u) => (u.name
                      .toLowerCase()
                      .contains(text.name.toLowerCase())))
                      .toList();

                });
              });
            }
          }

          ),

        );
        setState(() {
          isLoading=false;
        });
      });


  }

  Future<ProjectList> GetProjectList(String projectName,String ContractorName,String CategoryName,String Location,String status) async {
    // do something here
    return await vm.GetProjectListInfo(projectName,ContractorName,CategoryName,Location,status);
  }

  var _controller = TextEditingController();
  bool isSearching = false;
  String currentText = "";
  final _debouncer = Debouncer(milliseconds: 500);
  AutoCompleteTextField textField;
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
              appBar:
              AppBar(
               // searcher:HomeBloc(),
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
                    ?SingleChildScrollView(scrollDirection: Axis.horizontal,
                    child: Text((title!="")?title:"Project List",style: TextStyle(fontSize: 18),)
                )
                    : textField,

//                TextField(
//                  controller: _controller,
//                  focusNode: myFocusNode,
//                  autofocus: true,
//                  onChanged: (string) {
//                    _debouncer.run(() {
//                      setState(() {
//                        filteredProject = filteredAllProject
//                            .where((u) => (u.name
//                            .toLowerCase()
//                            .contains(string)))
//                            .toList();
//                      });
//                    });
//                  },
//                  style: TextStyle(color: Colors.white),
//                  decoration: InputDecoration(
//                      focusedBorder: UnderlineInputBorder(
//                        borderSide: BorderSide(color: Colors.white70),
//
//                      ),
//                      icon: Icon(
//                        Icons.search,
//                        color: Colors.white,
//                      ),
//                      hintText: 'Search by project name',
//                      hintStyle: TextStyle(color: Colors.white)),
//                  cursorColor: Colors.white,
//
//                ),
                actions: <Widget>[
                  isSearching
                      ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        currentText="";
                        this.isSearching = false;
                        textField.textField.controller.text ="";
                        filteredProject=filteredAllProject;
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
                child:
                (filteredProject!=null)
                    ?Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: new ClampingScrollPhysics(),
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
                                      (filteredProject[index].imagePath!=null)?
                                      CachedNetworkImage(
                                        imageUrl: filteredProject[index].imagePath,fit: BoxFit.cover,
                                        placeholder: (context, url) => getImageLoader(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        width: MediaQuery.of(context).size.width - 30,
                                        height: MediaQuery.of(context).size.height /4.5,
                                      ):Container(),
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
                                                )
                                            ),
                                          ],
                                        ),

                                      ),
                                      Padding(padding: EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          color: Colors.black26,
                                          height: 1,
                                        ),
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
                                                    Text(filteredProject[index].location,
                                                        style: TextStyle(fontWeight: (this.fieldName=="location")?
                                                        FontWeight.bold:FontWeight.normal))
                                                  ],
                                                )),
                                          ],

                                        ),

                                      ),
                                      Padding(padding: EdgeInsets.only(top: 3,bottom: 3),
                                      child: Container(
                                        color: Colors.black26,
                                        height: 1,
                                      ),),
                                      Padding(padding: EdgeInsets.only(left: 5,right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              //width: MediaQuery.of(context).size.width / 3.3,
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(CupertinoIcons.info,color: Colors.orange,),
                                                  SizedBox(
                                                    width: 3.0,
                                                  ),
                                                  Expanded(
                                                    child:
                                                    SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text((filteredProject[index].projectCategoryName!=null)?filteredProject[index].projectCategoryName:"",
                                                        maxLines: 1,softWrap: false,
                                                        style: TextStyle(fontWeight: (this.fieldName=="Type")?
                                                        FontWeight.bold:FontWeight.normal))
                                                      ,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: (filteredProject[index].contractorName!=null)
                                                  ?Container(
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

                                                      child:SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text((filteredProject[index].contractorName!=null)?filteredProject[index].contractorName:"",overflow: TextOverflow.fade,
                                                        maxLines: 1,softWrap: false,
                                                        style: TextStyle(fontWeight: (this.fieldName=="contractorName")?FontWeight.bold:FontWeight.normal),),
                                                          )
                                                    )
                                                  ],
                                                ),
                                              ):Container(),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                        },
                      ),
                    ),

                  ],
                ):Container(child: Center(child:
                Text(vm.Info),
                ),),
              )

          )
      ),
    );
  }
}
