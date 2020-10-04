import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_admob/firebase_admob.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixiwall/bloc/auth_bloc.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/model/PremiumWallpaper.dart';
import 'package:pixiwall/services/AdService.dart';
import 'package:pixiwall/services/ImageService.dart';
import 'package:pixiwall/services/UserDBProvider.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class FullView extends StatefulWidget {
  FullView({Key key, this.img}) : super(key: key);

  ImageModel img;

  @override
  _FullViewState createState() => _FullViewState();
}

class _FullViewState extends State<FullView> {
  var dir;
  bool fav;
  ImageService imageService = ImageService();
  bool isPressed;
  bool isPremium;
  bool loading;
  String msg, adStatus;
  int reward;
  bool setwall;
  UserDBProvider user;
  var snackBar, wallId;
  bool adLoading;
  // AdService adService;
  // dynamic _imageFile;
  RewardedVideoAd rewardedVideoAd;
  // BannerAd footer;
  @override
  void initState() {
    super.initState();
    user = UserDBProvider();
    reward = 0;
    msg = 'Watch Ad or Purchase with PixiPoints';
    setwall = false;
    isPressed = false;
    adStatus = "Loading Rewarded Ad";
    loading = false;
    fav = false;

    isPremium = widget.img.isPremium;
    // adService = AdService();
    // adService.adInitialize();
    Ads.initialize();
    // Ads.showBannerAd();
    // FirebaseAdMob.instance
    //     .initialize(appId: 'ca-app-pub-4593136213044487~8513933899');
    // super.initState();
    // MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    //   keywords: <String>['flutterio', 'beautiful apps'],
    //   contentUrl: 'https://flutter.io',
    //   birthday: DateTime.now(),
    //   childDirected: false,
    //   designedForFamilies: false,
    //   gender: MobileAdGender
    //       .unknown, // or MobileAdGender.female, MobileAdGender.unknown
    //   testDevices: <String>[], // Android emulators are considered test devices
    // );
    // footer = BannerAd(
    //   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    //   // https://developers.google.com/admob/android/test-ads
    //   // https://developers.google.com/admob/ios/test-ads
    //   // adUnitId: 'ca-app-pub-4593136213044487/1641210261',
    //   adUnitId: BannerAd.testAdUnitId,
    //   size: AdSize.smartBanner,
    //   targetingInfo: targetingInfo,
    //   listener: (MobileAdEvent event) {
    //     print("BannerAd event is $event");
    //   },
    // );
    // footer
    //   ..load()
    //   ..show(
    //     // Positions the banner ad 60 pixels from the bottom of the screen
    //     anchorOffset: 0.0,
    //     // Positions the banner ad 10 pixels from the center of the screen to the right
    //     horizontalCenterOffset: 0.0,
    //     // Banner Position
    //     anchorType: AnchorType.bottom,
    //   );
    // premium();
    geWallpaper(widget.img.id);

    // user = UserDBProvider();
    // // user.getUser(widget.img.id);

    // imageService.check(widget.img.id);
  }

  Future premium() async {
    // await user.openPremium();
    String id = await user.getWallPremium(widget.img.id);
    print("Idv ${id}");
    // await user.closePremium();
    if (id == widget.img.id) {
      setState(() {
        isPremium = false;
      });
    }
  }

  Future showAd(BuildContext context) async {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender
          .unknown, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );
    await RewardedVideoAd.instance
        .load(
            // adUnitId: 'ca-app-pub-4593136213044487/1266639890',
            adUnitId: RewardedVideoAd.testAdUnitId,
            targetingInfo: targetingInfo)
        .catchError((e) {
      setState(() {
        adStatus = 'Error Loading Ad: ${e.toString()}';
      });
    }).then((v) {
      setState(() {
        adLoading = v;
      });
    });

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$adStatus',
          style: TextStyle(color: Colors.white, fontSize: 15)),
      backgroundColor: blue4,
      elevation: 8,
      duration: Duration(milliseconds: 1500),
    ));
    // print('Loading Rewarded Ad');
    await RewardedVideoAd.instance.show().catchError((e) {
      setState(() {
        adStatus = 'Error Loading Ad: ${e.toString()}';
      });
    }).then((v) {
      setState(() {
        adLoading = false;
      });
    });
    RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event,
        {String rewardType, int rewardAmount}) async {
      if (event == RewardedVideoAdEvent.closed) {
        await RewardedVideoAd.instance
            .load(
                adUnitId: 'ca-app-pub-4593136213044487/1266639890',
                targetingInfo: targetingInfo)
            .catchError((e) {
          setState(() {
            adStatus = 'Error Loading Ad: ${e.toString()}';
          });
        }).then((v) {
          setState(() {
            adLoading = v;
          });
        });
      } else if (event == RewardedVideoAdEvent.rewarded) {
        isPremium = false;
        PremiumWallpaper premiumWallpaper =
            PremiumWallpaper(wallId: widget.img.id);
        // user = UserDBProvider();
        await user.openPremium();
        await user.insertPremium(premiumWallpaper: premiumWallpaper);
        // await user.closePremium();
        setState(() async {
          Navigator.pop(context);
        });
      }
    };
  }

  Future geWallpaper(id) async {
    await user.open();
    wallId = await user.getWall(id);
    if (wallId == widget.img.id) {
      setState(() {
        fav = true;
      });
    }

    // await user.close();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    // await footer.dispose();
    // Ads.hideBannerAd();
    super.dispose();
  }
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

  Positioned positionedButton({BuildContext context, num left, num bottom}) {
    return Positioned(
        // bottom: h(context) / 3,
        // left: w(context)/10.5,
        bottom: bottom,
        left: left,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                  isPressed = false;
                });
                await ImageService().downloadImage(
                    title: widget.img.title,
                    url: widget.img.imgUrl,
                    type: "home",
                    docId: widget.img.id);
                print('sucess home');
                setState(() {
                  loading = false;
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Hurray! Wallpaper set successfully',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  backgroundColor: blue4,
                  elevation: 8,
                  duration: Duration(milliseconds: 1500),
                ));
              },
              color: black1,
              child: Text(
                'Home Screen',
                style: style1,
              ),
              elevation: 8,
            ),
            RaisedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                  isPressed = false;
                });
                await ImageService().downloadImage(
                    title: widget.img.title,
                    url: widget.img.imgUrl,
                    type: "lock",
                    docId: widget.img.id);

                setState(() {
                  loading = false;
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Hurray! Wallpaper set successfully',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  backgroundColor: blue4,
                  elevation: 8,
                  duration: Duration(milliseconds: 1500),
                ));
                print('sucess lock');
              },
              color: black1,
              child: Text(
                'Lock Screen',
                style: style1,
              ),
              elevation: 8,
            ),
            RaisedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                  isPressed = false;
                });
                await ImageService().downloadImage(
                    title: widget.img.title,
                    url: widget.img.imgUrl,
                    type: "both",
                    docId: widget.img.id);
                setState(() {
                  loading = false;
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Hurray! Wallpaper set successfully',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  backgroundColor: blue4,
                  elevation: 8,
                  duration: Duration(milliseconds: 1500),
                ));
                print('sucess both');
              },
              color: black1,
              child: Text(
                'Both Screen',
                style: style1,
              ),
              elevation: 8,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // print(downloading);
    // print(progress);
    // print(dir);
// print('WallId:$wallId');

    return Scaffold(
      backgroundColor: Primary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          void purchase() {
            if (state is AuthUser) {
              if (state.user == null) {
                // print('You need login to download the wallpaper');
                setState(() {
                  msg = 'You need to login to download the wallpaper';
                });
              } else {
                setState(() {
                  msg = 'Successfully viewed the ad';
                });
              }
            }
          }

          if (state is AuthUser) {
            return Builder(
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
                              tag: '${widget.img.id}',
                              child: Container(
                                width: double.infinity,
                                height: h(context),
                                decoration: BoxDecoration(),
                                child: CachedNetworkImage(
                                  imageUrl: '${widget.img.imgUrl}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      SpinKitChasingDots(
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            if (loading)
                              Positioned(
                                  child: SpinKitChasingDots(
                                color: Colors.white,
                                size: 100.0,
                              )),
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
                                      icon: Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      color: Primary,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      splashColor: Primary,
                                    ),
                                  ),
                                )),
                            if (isPremium)
                              Positioned(
                                  top: 30,
                                  right: 10,
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
                                        icon: FaIcon(
                                          FontAwesomeIcons.crown,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                        color: Primary,
                                        onPressed: () {
                                          // Navigator.of(context).pop();
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
                                            colors: [
                                          Colors.transparent,
                                          Primary
                                        ],
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
                                          !isPremium
                                              ? isPressed = !isPressed
                                              : Alert(
                                                  context: context,
                                                  type: AlertType.info,
                                                  title:
                                                      "${widget.img.pixipoints} PixiPoints",
                                                  desc: msg,
                                                  buttons: [
                                                    if (state.user != null)
                                                      DialogButton(
                                                        child: Text(
                                                          "Purchase",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () async {
                                                          purchase();
                                                        },
                                                        color: Color.fromRGBO(
                                                            0, 179, 134, 1.0),
                                                      ),
                                                    DialogButton(
                                                      child: Text(
                                                        "Watch Ad",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () async {
                                                        await showAd(context);

                                                        // setState(() {
                                                        //   reward += AdService()
                                                        //       .showAd();
                                                        // });
                                                        print(reward);
                                                      },
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color.fromRGBO(116,
                                                                116, 191, 1.0),
                                                            Color.fromRGBO(52,
                                                                138, 199, 1.0)
                                                          ]),
                                                    )
                                                  ],
                                                ).show();
                                        });
                                        // print('$loading');
                                        // await ImageService().downloadImage(
                                        //     title: widget.img.title,
                                        //     url: widget.img.imgUrl,
                                        //     docId: widget.img.id);

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
                                      child: RoundButton(
                                          grad: grad5,
                                          iconData: Icon(
                                            Icons.wallpaper,
                                            color: Colors.white,
                                          ),
                                          tooltip: 'Set wallpaper'),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          setState(() {
                                            !isPremium
                                                ? loading = true
                                                : loading = false;
                                          });
                                          !isPremium
                                              ? await ImageService()
                                                  .shareTo(
                                                      docId: widget.img.id,
                                                      imgUrl: widget.img.imgUrl,
                                                      title: widget.img.title)
                                                  .whenComplete(() {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                })
                                              : Alert(
                                                  context: context,
                                                  type: AlertType.info,
                                                  title:
                                                      "${widget.img.pixipoints} PixiPoints",
                                                  desc: msg,
                                                  // content: Text("${widget.img.pixipoints} PixiPoints",style: TextStyle(color: Colors.blueGrey)),
                                                  buttons: [
                                                    if (state.user != null)
                                                      DialogButton(
                                                        child: Text(
                                                          "Purchase",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () async {
                                                          purchase();
                                                        },
                                                        color: Color.fromRGBO(
                                                            0, 179, 134, 1.0),
                                                      ),
                                                    DialogButton(
                                                      child: Text(
                                                        "Watch Ad",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () async {
                                                        await showAd(context);
                                                      },
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color.fromRGBO(116,
                                                                116, 191, 1.0),
                                                            Color.fromRGBO(52,
                                                                138, 199, 1.0)
                                                          ]),
                                                    )
                                                  ],
                                                ).show();
                                        },
                                        child: RoundButton(
                                            grad: grad2,
                                            iconData: Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                            tooltip: 'Share wallpaper')),
                                    InkWell(
                                        onTap: () async {
                                          setState(() {
                                            loading = true;
                                            fav = !fav;
                                          });
                                          await ImageService()
                                              .favourite(
                                                  docId: widget.img.id,
                                                  fav: fav)
                                              .whenComplete(() {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: fav
                                                  ? Text('Added to Favourite',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15))
                                                  : Text(
                                                      'Removed from Favourite',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15)),
                                              backgroundColor:
                                                  fav ? red2 : red1,
                                              elevation: 8,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                            ));
                                          });

                                          setState(() {
                                            loading = false;
                                            // fav = !fav;
                                          });
                                        },
                                        child: RoundButton(
                                            grad: grad4,
                                            iconData: !fav
                                                ? Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                            tooltip: 'Add to Favourite')),
                                  ],
                                )),

                            if (isPressed)
                              positionedButton(
                                  context: context,
                                  bottom: h(context) / 3.5,
                                  left: w(context) / 9),
                            // positionedButton(context: context,bottom:h(context) / 3 ,left: w(context)/10.5,color:red1 ,onPress:null ,title:'Lock Screen' ),
                            //   positionedButton(context: context,bottom:h(context) / 3.65,left: w(context)/10.5,color:red1 ,onPress:null ,title:'Both Screen' ),

                            // RaisedButton(onPressed: null,child: Text('Home Screen',style: style1,),color: blue2,),
                            //                    RaisedButton(onPressed: null,child: Text('Both Screen',style: style1,),color: blue3,),
                            //    Positioned(
                            //                      top: 50,
                            //                      child: RaisedButton(onPressed: null,child: Text('Lock Screen',style: style1,),color: blue1,)),

                            Positioned(
                                width: w(context) - 40,
                                bottom: h(context) / 6 - 55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${widget.img.category}',
                                          style: style6,
                                        ),
                                        Text(
                                          '${widget.img.author}',
                                          style: style7,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('${widget.img.downloads}',
                                            style: style6),
                                        Icon(Icons.file_download,
                                            color: Colors.white)
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ));
          }
        }),
      ),
    );
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
