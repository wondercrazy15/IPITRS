import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FilterView();
  }

}

class _FilterView extends State<FilterView>{

  List<City> CityList = <City>[
    City(1, 'All', true),
    City(2, 'Udhna,Surat', false),
    City(3, 'Mumbai', false),
    City(4, 'Ahemdabad', false),
    City(5, 'Bangalore', false),
    City(6, 'Hyderabad', false),
    City(7, 'Chennai', false),
    City(8, 'Kolkata', false),
    City(9, 'Pune', false),
    City(5, 'Jaipur', false),
    City(6, 'Lucknow', false),
    City(7, 'Kanpur', false),
    City(8, 'Nagpur', false),
    City(9, 'Indore', false)

  ];
  List<City> SelectedCityList=List();
  String SelectedCity;
  List<String> _texts = [
    "Suart",
    "Mumbai",
    "Ahemdabad",
    "Delhi",
    "Bangalore",
    "Hyderabad",
    "Chennai",
    "Kolkata",
    "Pune",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Agra",
    "Rajkot",
    "Aurangabad",
  ];

  List<bool> _isChecked;

  @override
  void initState()  {
    super.initState();
    initData();
   // _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: _onBackPressed,
        child:  Scaffold(
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
              title: Text('Filter'),
            ),
            body:
            ListView(

              children: List.generate(CityList.length, (index) {
                return Card(
                  child: ListTile(
                    selectedTileColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        for(int i=0; i<CityList.length; i++)
                        {
                          CityList[i].selected = false;
                        }
                        CityList[index].selected = true;
//                      if (CityList[index].selected) {
//                        SelectedCityList.add(CityList[index]);
//                      } else {
//                        SelectedCityList.remove(CityList[index]);
//
//                      }
                        // log(CityList[index].selected.toString());
                      });
                    },
                    selected: CityList[index].selected,
                    title: Text(CityList[index].title,style: TextStyle(color: Colors.black87),),
                    trailing: (CityList[index].selected)
                        ? Icon(Icons.check_box,color: Colors.orange,)
                        : Icon(Icons.check_box_outline_blank),
                  ),
                );
              }),
            ),

            bottomNavigationBar:
            SafeArea(

                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: RaisedButton(
                              onPressed : ()async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.remove("FilterCity");
                                prefs.setBool("IsApplyFilter", true);
                                //SelectedCity=List();
                                for(var i = 0; i< CityList.length; i++) {
                                  if(CityList[i].selected){
                                    prefs.setString("FilterCity", CityList[i].title);
                                    var d=prefs.getString("FilterCity");
                                    print("Sp${d}");
                                  }

                                  //SelectedCity.add(SelectedCityList[i].title);
                                  //print(SelectedCity);
                                }
                                Navigator.pop(context,true);


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
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Apply',style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),),

                                    ],
                                  ),
                                ),
                              ),
                            ),),

                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: RaisedButton(
                              onPressed: ()async{
                                setState(() {
                                  for(var i = 0; i< CityList.length; i++) {
                                    if(CityList[i].title=="All"){
                                      CityList[i].selected=true;
                                      //SelectedCity.remove(CityList[i]);
                                    }
                                    else{
                                      CityList[i].selected=false;
                                    }
                                  }
                                });
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.remove("FilterCity");
                                prefs.setBool("IsApplyFilter", false);
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
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      Text('Reset',style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),),

                                    ],
                                  ),
                                ),
                              ),
                            ),),

                          ],
                        ),
                      ),
                    ],
                  ),
                )
            )

        ),
      );

  }


  Future<bool> _onBackPressed() {
    Navigator.pop(context,false);
  }

  void initData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data=prefs.getString("FilterCity");
   setState(() {
     if(data.isNotEmpty){
       for(var i = 0; i< CityList.length; i++) {
         if(data==CityList[i].title){
           CityList[i].selected=true;
           //SelectedCity.remove(CityList[i]);
         }
         else{
           CityList[i].selected=false;
         }
       }
     }
   });

  }
}

class City {
  final int id;
  final String title;
  bool selected = false;

  City(this.id, this.title,this.selected);
}