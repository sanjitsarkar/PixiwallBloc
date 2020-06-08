import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path/path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/services/ImageService.dart';
import 'package:pixiwall/services/UserDBProvider.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:http/http.dart' as http;

class FullScreenDownloaded extends StatefulWidget {
  FullScreenDownloaded({Key key, this.path}) : super(key: key);

  FileSystemEntity path;

  @override
  _FullScreenDownloadedState createState() => _FullScreenDownloadedState();
}

class _FullScreenDownloadedState extends State<FullScreenDownloaded> {
  bool setwall;
  bool loading;
  bool ispressed;
  String msg = '';
  bool fav;
  var snackBar;
var path;
  ImageService imageService = ImageService();
  @override
  void initState() {
    super.initState();
    ispressed = false;
    setwall = false;
    loading = false;
    fav = false;
     path ='/${widget.path.toString().substring(8,widget.path.toString().length-1)}'; 
    
  
    // user = UserDBProvider();
    // // user.getUser(widget.img.id);

    // imageService.check(widget.img.id);
  }

  // var dir;
   
  //  Future<void> _download() async {
  //   Dio dio = Dio();

  //   var dirToSave = await getApplicationDocumentsDirectory();

  //   await dio.download(widget.img.imgUrl ,"${dirToSave.path}/${widget.img.title}.jpg",
  //       onReceiveProgress: (rec, total) {
  //     setState(() {
  //       downloading = true;
  //       progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
  //       dir ="${dirToSave.path}/${widget.img.title}.jpg";
  //     });
  //   });

  //   try {} catch (e) {
  //     throw e;
  //   }
  //   setState(() {
  //     downloading = false;
  //     progress = "Complete";
  //   });
  // }
  // dynamic _imageFile;
  // Future _download() async {
  //   print("_onImageSaveButtonPressed");
  //   var response = await http.get(widget.img.imgUrl);

  //   // debugPrint(response.statusCode.toString());

  //   var filePath =
  //       await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

  //   var savedFile = File.fromUri(Uri.file(filePath));
  //   print('Saved File $savedFile');
  //   print('filePath $filePath');
  //   setState(() {
  //     _imageFile = Future<File>.sync(() => savedFile);
  //     _getMsg(filePath);
  //   });
  // }

//   Future<dynamic> _downloadImage(String url, {AndroidDestinationType destination}) async {
//     var imageId;
//               imageId = await ImageDownloader.downloadImage(
//             url,
//             destination: destination,
//           );
//         return imageId;
// }
  @override
  Widget build(BuildContext context) {
    // print(downloading);
    // print(progress);
    // print(dir);

    return Scaffold(
      backgroundColor: Primary,
      body: Builder(
          builder: (context) => SingleChildScrollView(
                child: Container(
                  height: h(context),
                  width: w(context),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      // Row(

                      // children: <Widget>[

                      //   Column(children: <Widget>[

                      //     Text('${widget.img.title}'),

                      //     Text('${widget.img.category}'),

                      //   ],),

                      //   Icon(Icons.verified_user),

                      //   Text('${widget.img.author}')

                      // ],

                      //     ),
                      Hero(
                        tag: '${widget.path}',
                        child: Container(
                          width: w(context),
                          height: h(context),
                          decoration: BoxDecoration(),
                          child: Image.file(widget.path,fit: BoxFit.cover,)
                        ),
                      ),

                      Positioned(
                          child: loading
                              ? SpinKitChasingDots(
                                  color: Colors.white,
                                  size: 100.0,
                                )
                              : Text('')),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: grad6,
                                boxShadow: [shadow1],
                              ),
                              child: IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                color: Primary,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                splashColor: Primary,
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              width: w(context),
                              height: h(context) / 2 - 100,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.transparent, Primary],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)))),

                      Positioned(
                          bottom: h(context) / 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  // print('$loading');
                                  // await ImageService().asyncMethod(widget.img.imgUrl, widget.img.title.replaceAll(new RegExp(r"\s+\b|\b\s"), "").toLowerCase());
                                  setState(() {
                                    // loading = true;
                                    ispressed = !ispressed;
                                  });
                                  print('$loading');
                                 
                                
                              //  await ImageService().setWallpaper(path: '/storage/emulated/0/Pixiwall/Wallpapers/Moon.jpg');

                                  // Scaffold.of(context).showSnackBar(SnackBar(
                                  //   content: Text(
                                  //       'Hurray! Wallpaper set successfully',
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 15)),
                                  //   backgroundColor: blue4,
                                  //   elevation: 8,
                                  //   duration: Duration(milliseconds: 1500),
                                  // ));
                                  // setState(() {
                                  //   loading = false;
                                  // });
                             
                                          
                                  // print("Path is $path");

                                  // await ImageService().setWallpaper(path: path);

                                  // await _download().whenComplete(()
                                  // async{
                                  // }
                                  // );

                                  // print('$loading');
                                  // Scaffold.of(context).showSnackBar(new SnackBar(content: Text('$msg',style: style1,),backgroundColor: Primary,));
//          print(_imageFile);
//              _getMsg().then((String message)
//     {
// print(message);
//     });
                                },
                                child: Column(
                                  children: <Widget>[
                                    RoundButton(
                                        grad: grad5,
                                        iconData: Icon(
                                          Icons.wallpaper,
                                          color: Colors.white,
                                        ),
                                        tooltip: 'Set wallpaper'),
                                        // SizedBox(height:10),
                                      
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                   
                                  await ImageService().deleteFile(widget.path).whenComplete(()
                                  {
                                      print('done');
   Navigator.popAndPushNamed(context, '/downloaded');
                                  });
                                
          //  FileSystemEntity(widget.path).delete();
         
  // print('done');
                                      setState(() {
                                      loading = false;
                                    });
     
                                    
          //   Navigator.pushNamed(context, '/downloaded');
                                   
                      
                                    },
                                  child: Column(
                                    children: <Widget>[
                                      RoundButton(
                                          grad: grad2,
                                          iconData:Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                          ),
                                          tooltip: 'Delete wallpaper'),
                                        
                                    ],
                                  ),
                                      
                                      ),
                              // InkWell(
                              //     onTap: () async {
                              //       setState(() {
                              //         loading = true;
                              //       });
                              //       await ImageService()
                              //           .favourite(docId: widget.img.id,fav: fav)
                              //           .whenComplete(() {
                              //         Scaffold.of(context)
                              //             .showSnackBar(SnackBar(
                              //           content: fav?Text('Added to Favourite',
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontSize: 15)):Text('Removed from Favourite',
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontSize: 15)),
                              //           backgroundColor: fav?red2:red1,
                              //           elevation: 8,
                              //           duration: Duration(milliseconds: 1500),
                              //         ));
                              //       });

                              //       setState(() {
                              //         loading = false;
                              //         fav = !fav;
                              //       });
                              //     },
                              //     child: RoundButton(
                              //        grad: grad4,
                              //         iconData:fav? Icon(
                              //           Icons.favorite_border,
                              //           color: Colors.white,
                              //         ):Icon(
                              //           Icons.favorite,
                              //           color: Colors.white,
                              //         ),
                                     
                                      
                              //         tooltip: 'Add to Favourite')),
                            ],
                          )),

                      // Positioned(
                      //     width: w(context) - 40,
                      //     bottom: h(context) / 6 - 55,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: <Widget>[
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: <Widget>[
                      //             Text(
                      //               '${widget.img.title}',
                      //               style: style6,
                      //             ),
                                 
                      //           ],
                      //         ),
                             
                      //       ],
                      //     )),

                    ispressed?positionedButton(context: context,bottom:h(context) / 3.5 ,left: w(context)/4):Container(),  
                    ],
                  ),
                ),
              )),
    );
  }
  Positioned positionedButton({BuildContext context,num left,num bottom}) {
    return Positioned(
                          // bottom: h(context) / 3,
                          // left: w(context)/10.5,
                          bottom: bottom,
                          left: left,
                          child:    Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: <Widget>[
                              
                               RaisedButton(onPressed: ()

                               async{
                                   setState(() {
                                   loading = true;
                                 });
           await ImageService().setWallpaper(path: path,type: 'home');
             setState(() {
                                   loading = false;
                                    ispressed=false;
                                 });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Hurray! Wallpaper set successfully',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    backgroundColor: blue4,
                                    elevation: 8,
                                    duration: Duration(milliseconds: 1500),
                                  ));
                                       print('sucess home');
                               },
                               color: black1,
                               child: Text('Home Screen',style: style1,),elevation: 8,),
                               RaisedButton(onPressed: ()
                               async{
                                   setState(() {
                                   loading = true;
                                  
                                 });
 await ImageService().setWallpaper(path: path,type: 'lock');
   setState(() {
                                   loading = false;
                                 });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Hurray! Wallpaper set successfully',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    backgroundColor: blue4,
                                    elevation: 8,
                                    duration: Duration(milliseconds: 1500),
                                  ));
                                  print('sucess lock');
                               },
                              
                                color: black1,
                               child: Text('Lock Screen',style: style1,),elevation: 8,),
                               RaisedButton(onPressed: ()
                               async{
                                   setState(() {
                                   loading = true;
                                    ispressed=false;
                                 });
 await ImageService().setWallpaper(path: path,type: 'both');
  setState(() {
                                   loading = false;
                                 });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Hurray! Wallpaper set successfully',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    backgroundColor: blue4,
                                    elevation: 8,
                                    duration: Duration(milliseconds: 1500),
                                  ));
                                      print('sucess both');
                               },
                                color: black1
                               ,child: Text('Both Screen',style: style1,),elevation: 8,),
                            ],
                          ));
  }
  
}

Widget RoundButton({grad, iconData, tooltip}) {
  return Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        shape: BoxShape.circle, gradient: grad, boxShadow: [shadow1]),
    child: IconButton(
      icon: iconData,
      onPressed: null,
      tooltip: tooltip,
    ),
  );
}
