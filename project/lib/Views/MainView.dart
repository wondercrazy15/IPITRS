
import 'package:barcode_scan/barcode_scan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/QRCode.dart';
import 'package:project/ViewModels/QRCodeViewModel.dart';
import 'package:project/Views/LoginView.dart';
import 'package:flutter/services.dart';
import 'package:project/Views/ProjectView.dart';
import 'package:toast/toast.dart';
import 'RegistrationView.dart';
import 'SizeConfig.dart';

class MainView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _mainView();
  }

}
class _mainView extends State<MainView>{
  QRCodeViewModel vm= QRCodeViewModel();
  List<QRCodeData> QRCodeList;
  @override
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
  final List<Banners> payloadList = [
    Banners(
      title: "Title 2",
      imageUrl:  'assets/images/Project1.jpg',
    ),
    Banners(
      title: "Title 3",
      imageUrl: 'assets/images/Project2.jpg',
    ),
    Banners(
      title: "Title 3",
      imageUrl: 'assets/images/Project3.jpg',
    ),
    Banners(
      title: "Title 3",
      imageUrl: 'assets/images/Project4.jpg',
    ),
  ];
  int _current = 0;
  bool isScanned=false;
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
      body:

      SafeArea(child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        print("Login click");
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => new LoginView()));

                      },

                      child: Padding(padding: EdgeInsets.all(10),child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.orange,thickness: 1.0,)),
                  GestureDetector(
                      onTap: () {
                        print("Registration click");

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>RegistrationView(false)
                        ));
                      },
                      child: Padding(padding: EdgeInsets.all(10),child: Text("Registration",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      )),
                ],
              ),
            )
            ,
            SizedBox(height: 20,),
//            Center(
//                heightFactor: 2,
//                child:
//                Column(
//                  children: [
//                    Image.asset("assets/images/DigitalIndia.png"),
//                    SizedBox(height: SizeConfig.screenHeight * 0.02),
//                    Container(
//                      height: 50.0,
//                      width: 100.00,
//                      child: RaisedButton(
//                        onPressed: () {
//
//                        },
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                        padding: EdgeInsets.all(0.0),
//
//                        child: Ink(
//                          decoration: BoxDecoration(
//                              gradient: LinearGradient(colors: [Color(0xffFF9933), Color(0xff58A451)],
//                                begin: Alignment.centerLeft,
//                                end: Alignment.centerRight,
//                              ),
//                              borderRadius: BorderRadius.circular(10.0)
//                          ),
//                          child: Container(
//                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
//                            alignment: Alignment.center,
//                            child: Text(
//                              "Scan",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: 18,
//                                  color: Colors.white
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                )
//            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width-200,
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
                            "Scan QR Code",
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
                  Container()
                ],

              ),
            ),
            Container(
          child:
            Align(
              alignment: FractionalOffset.bottomCenter,
              child:
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.85,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },

                ),

                items: payloadList.map((payload) {
                  return Builder(builder: (BuildContext context) {
                    return Column(

                      children: <Widget>[
                        Padding( padding: EdgeInsets.only(top: 10.0),),
//                          Text(payload.title),
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              payload.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                      ],
                    );
                  });
                }).toList(),
              ),
            )),
            Padding(padding: EdgeInsets.only(bottom: 15))
          ],
        ),
      ),),
    );
  }

}