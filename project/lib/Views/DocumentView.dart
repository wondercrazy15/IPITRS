import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' as h;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:share/share.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
class DocumentView extends StatefulWidget {
  final String url;

  const DocumentView({Key key, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DocumentView(this.url);
  }
}

class _DocumentView extends State<DocumentView> {
  String url;
  bool isLoading=false;
  _DocumentView(this.url);

  bool downloading = false;
  double download = 0.0;
  var progress = "";
  String downloadingStr = "No data";
  var dio=Dio();
  String Profile = "";
  String email = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    Future<Null> urlFileShare() async {
      setState(() {
        // button2 = true;
      });
      final RenderBox box = context.findRenderObject();
      if (Platform.isAndroid) {
        var urls = url;
        var response = await h.get(urls);
        var name=url.substring(url.lastIndexOf("/") + 1);
        final documentDirectory = (await getExternalStorageDirectory()).path;
        File imgFile = new File('$documentDirectory/$name');
        imgFile.writeAsBytesSync(response.bodyBytes);
        Share.shareFile(File('$documentDirectory/$name'),
            subject: 'File Share',
            text: 'Hello, check I have share Proect Documentfile!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      } else {
        Share.share('Hello, check I have share Proect Documentfile!',
            subject: 'File Share',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
      setState(() {
        // button2 = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Document", style: TextStyle(fontSize: 18)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xffff8000), Color(0xff008000)]
              )
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {

              final status = await Permission
                  .storage.status;
              if (status != PermissionStatus.granted) {
                final requestRes = await Permission.storage.request();;
                if (!requestRes.isGranted) {
                  Toast.show("Please give permission from settings", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  await openAppSettings();
                  return ;
                }
              }
              if (await Permission.storage.request().isGranted) {
                String baseDir = "";
                if (Platform.isAndroid) {
                  baseDir = "/storage/emulated/0/";
                } else {
                  baseDir = (await getApplicationDocumentsDirectory()).path;
                }

                //Directory baseDir = await getApplicationDocumentsDirectory();
                //String baseDir =await
                //ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS); //works for both iOS and Android
//                String path=await ExtStorage.getExternalStoragePublicDirectory(
//                    ExtStorage.DIRECTORY_DOWNLOADS);
                String dirToBeCreated = "IPITRS";
                String finalDir = join(baseDir, dirToBeCreated);
                //download2(dio,url,);
                var dir = Directory(finalDir);
                bool dirExists = await dir.exists();
                if (!dirExists) {
                  dir.create(recursive: true)
                  // The created directory is returned as a Future.
                      .then((Directory directory) {
                    print(directory.path);
                  });
                  //dir.create(); //pass recursive as true if directory is recursive
                }
                String dirToBeCreatedDocument = "Document";
                String finalDirDocument = join(finalDir, dirToBeCreatedDocument);
                var dirDocument = Directory(finalDirDocument);
                bool dirExistsDocument = await dir.exists();
                if (!dirExistsDocument) {
                  dirDocument.create(recursive: true)
                  // The created directory is returned as a Future.
                      .then((Directory directory) {
                    print(directory.path);
                  });
                  //dir.create(); //pass recursive as true if directory is recursive
                }

                Dio dio = Dio();
                String fullPath="${dirDocument.path}";
                File f = File("${dirDocument.path}");
                String fileName = url.substring(url.lastIndexOf("/") + 1);
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('dd_MM_yyyy_kk_mm').format(now);
                download2(dio,url,fullPath+"/"+formattedDate+"_"+fileName,context);

//                final taskId = await FlutterDownloader.enqueue(
//                  url: url,
//                  savedDir: fullPath,
//                  showNotification: true, // show download progress in status bar (for Android)
//                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//                );
//              dio.download(url, "${dir.path}/$fileName",
//                  onReceiveProgress: (rec, total) {
//                var d = true;
//                setState(() {
//                  downloading = true;
//                  download = (rec / total) * 100;
//                  downloadingStr =
//                      "Downloading : " + (download).toStringAsFixed(0);
//                });
//
//                setState(() {
//                  downloading = false;
//                  downloadingStr = "Completed";
//                });
//              });
              }
//              else{
//                Toast.show("Please give permission from settings", context,
//                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//                await openAppSettings();
//              }
            },
            icon: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              urlFileShare();
            },
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: (downloading)?
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Downloading File: $progress',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),)
          :Container(
        color: Colors.white,
        child: PDF(
          fitEachPage: true,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
        ).fromUrl(
          url,
          placeholder: (double progress) =>
              Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Loading File: $progress',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),),
//            Center(child: Text('$progress %')),
          errorWidget: (dynamic error) =>
              Center(child: Text(error.toString())),
        ),
      )

    );
  }
  static final Random random = Random();
  Future download2(Dio dio, String url, String fullPath, BuildContext context) async {
    try{

      Response respo= await dio.get(url,onReceiveProgress:showDialogProgress,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status){
          return status<500;
        }
      ));

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        //path = dirloc + randid.toString() + ".jpg";
      });

      Toast.show("Download completed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      File file=File(fullPath);
      print(fullPath);
      OpenFile.open(fullPath);
      var raf=file.openSync(mode: FileMode.write);
      raf.writeFromSync(respo.data);
      await raf.close();
    }
    catch(ex)
    {
      setState(() {
        downloading=false;
      });
      print(ex);
    }
  }

  void showDialogProgress(int count, int total) {
    if(total!=-1)
      {
        setState(() {
          downloading = true;
          progress =
              ((count / total) * 100).toStringAsFixed(0) + "%";
        });
        print((count/total*100).toStringAsFixed(0)+"%");
      }
  }
}
