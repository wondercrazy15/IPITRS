import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/ContractorList.dart';
import 'package:project/Models/ProjectType.dart';
import 'package:project/ViewModels/SearchFromContractorViewModel.dart';
import 'package:project/ViewModels/SearchFromTypeViewModel.dart';
import 'ProjectListView.dart';
import 'ProjectView.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class SearchFromTypeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _searchFromTypeView();
  }
}

class _searchFromTypeView extends State<SearchFromTypeView> {
  FocusNode myFocusNode;
  Project p;
  List<ProjectTypeData> projectTypeList = List();
  List<ProjectTypeData> filteredprojectTypeList = List();

  bool isLoading = true;
  AutoCompleteTextField textField;
  SearchFromTypeViewModel vm = new SearchFromTypeViewModel();

  @override
  void initState() {
    myFocusNode = FocusNode();

    print("init Call");
    GetProjectTypeList().then((ProjectType value) {
      projectTypeList = value.data;
      filteredprojectTypeList = value.data;
      //FilterProjecttype= projectList.distinct((d) => d.projectCategoryName).toList();
      setState(() {
        isLoading = false;
      });

    });

    super.initState();
  }

  Future<ProjectType> GetProjectTypeList() async {
    // do something here
    return await vm.GetProjectTypeList();
  }

  bool isSearching = false;
  final _debouncer = Debouncer(milliseconds: 500);
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<ProjectTypeData>> key =
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
                  ? Text('Project type List',style: TextStyle(fontSize: 18),overflow: TextOverflow.fade,maxLines: 1,softWrap: false)
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
                      hintText: 'Enter project type',
                      hintStyle: TextStyle(color: Colors.white)),

                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {

                        filteredprojectTypeList = projectTypeList
                            .where((u) => (u.projectCategoryName
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
                      filteredprojectTypeList = projectTypeList;
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
                    child: (filteredprojectTypeList != null)
                        ? Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            physics: new ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(5.0),
                            itemCount: filteredprojectTypeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  child:
                                  ListTile(
                                    onTap: ()async{
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) =>
                                              ProjectListView(
                                                  filteredprojectTypeList[index].projectCategoryName,
                                                  "Type",)
                                      ));
                                    },
                                    title: Text(filteredprojectTypeList[index].projectCategoryName,style: TextStyle(foreground: Paint()..shader = linearOrangeGradient),),
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
