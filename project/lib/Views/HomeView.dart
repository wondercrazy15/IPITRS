import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Models/QRCode.dart';
import 'package:project/ViewModels/QRCodeViewModel.dart';
import 'package:project/Views/ProjecListByLocationView.dart';
import 'package:project/Views/ProjectListView.dart';
import 'package:project/Views/SearchFromTypeView.dart';
import 'package:toast/toast.dart';
import 'DrawerPage.dart';
import 'MyComplainView.dart';
import 'ProjectView.dart';
import 'SearchFromContractorView.dart';
import 'SearchFromPincodeView.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _homeView();
  }

}

class _homeView extends State<HomeView> {
  QRCodeViewModel vm= QRCodeViewModel();
  List<QRCodeData> QRCodeList;
  bool isScanned=false;
  void initState() {
    // TODO: implement initState
    GetQRcodeList().then((QRCode value) {
      QRCodeList=value.data;
    });
    super.initState();
  }

  Future<QRCode> GetQRcodeList() async {
    // do something here
    return await vm.GetQRcodeList();
  }
  Future<void> _scan() async {
    try{
      String codeSanner = await BarcodeScanner.scan();
      if(codeSanner.isNotEmpty)
        if(QRCodeList!=null&&QRCodeList.length>0){
          for(var i=0;i<QRCodeList.length;i++){
            if(QRCodeList[i].code==codeSanner){
              isScanned=true;
            }
          }
        }
        else{
          Toast.show("Seems like this code is not Scanned. Try again", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }
      if(isScanned){
        isScanned=false;
        Toast.show("Code Scanned", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new ProjectView(codeSanner)));
      }
      else {
        Toast.show("Seems like this code is invalid. Try another one", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      //      Navigator.push(context,
      //          new MaterialPageRoute(builder: (context) => new ProjectView(null)));


      print(codeSanner);
    }
    on PlatformException catch(ex)
    {
      if(ex.code==BarcodeScanner.CameraAccessDenied){
        print(ex.code);
        Toast.show(ex.code, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("IPITRS",style: TextStyle(fontSize: 18),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xffff8000),Color(0xff008000)
                    ])
            ),)
      ),
      body:Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/Background.gif"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white.withOpacity(0.7),


            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: SizeConfig.screenWidth /2,
                      child: RaisedButton(
                        onPressed: () {
                          _scan();
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
                              "New Scan",
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
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      width: SizeConfig.screenWidth /2,
                      child: RaisedButton(
                        onPressed: () {
                          _showPicker(context);
//                                         Navigator.push(context, MaterialPageRoute(
//                                             builder: (context)=>ProjectListView("","")
//                                         ));
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
                              "Browse Project",
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
                  ],
                ),
              ),
            ),
          )

        ],
      ),


      drawer: DrawerPage(),
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child:
               Wrap(
                children: <Widget>[
//                  GestureDetector(
//                    child:
//                    Card(
//                      shape: RoundedRectangleBorder(
//                          side: BorderSide(color: Colors.orange, width: 2.0),
//                          borderRadius: BorderRadius.circular(4.0)),
//                      elevation: 5,
//                      child: Padding(
//                        padding: EdgeInsets.all(5),
//                        child:  Container(
//                          child: Text(
//                            "By Location",
//                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,foreground: Paint()..shader = linearGradient),
//                          ),
//                        )
//                      ),
//                    ),
//
//                    onTap: (){
//
//                    },
//                  ),

                  ListTile(
                      contentPadding: EdgeInsets.only(left: 10),
                      leading: new Icon(Icons.location_city,color: iconColor),
                      title: Text('By Location',style: TextStyle(foreground: Paint()..shader = linearOrangeGradient),),
                      onTap: () async{
                        bool connected = await IsConnected();
                        if(!connected){
                          Toast.show(msgNoInternet, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                          return;
                        }
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>SearchFromPincode()
                        ));

//                        Navigator.push(context, MaterialPageRoute(
//                            builder: (context)=>ProjectListByLocationView("Location","")
//                        ));
                      }),

                  ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: new Icon(Icons.collections_bookmark,color: iconColor),
                    title: Text('By Contractor',style: TextStyle(foreground: Paint()..shader = linearOrangeGradient),),
                    onTap: () async{
                      bool connected = await IsConnected();
                      if(!connected){
                        Toast.show(msgNoInternet, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>SearchFromContractorView()
                      ));
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context)=>ProjectListByLocationView("ContractorName","")
//                      ));

                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: new Icon(Icons.merge_type,color: iconColor),
                    title: Text('By Type',style: TextStyle(foreground: Paint()..shader = linearOrangeGradient),),
                    onTap: () async{
                      bool connected = await IsConnected();
                      if(!connected){
                        Toast.show(msgNoInternet, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        return;
                      }
                      Navigator.pop(context);
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context)=>ProjectListByLocationView("Type","")
//                      ));
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>SearchFromTypeView()
                      ));
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}