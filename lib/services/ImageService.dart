import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show get;
import 'package:image_downloader/image_downloader.dart';
import 'package:pixiwall/model/CategoryModel.dart';
import 'package:pixiwall/model/Favourite.dart';
// import 'package:pixiwall/model/UserDataModel.dart';
import 'dart:io' as io;
import './UserDBProvider.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static const platform = const MethodChannel('com.pixi.pixiwall/wallpaper');
  static final _firestore = Firestore.instance;

  UserDBProvider userDBProvider;
// UserDataModel userDataModel;
  Favourite _favourite;
  Stream<List<ImageModel>> get images {
    Stream<QuerySnapshot> snaps = _firestore
        .collection('Wallpapers')
        .orderBy('created_at')
        .limit(3)
        .snapshots();
    return snaps.map((docs) =>
        docs.documents.map((doc) => ImageModel.fromDoc(doc)).toList());
  }

  Future<List<ImageModel>> getWall(title) async {
    QuerySnapshot snaps = await _firestore
        .collection('Wallpapers')
        .where('title', isEqualTo: title)
        .limit(1)
        .getDocuments();
    return snaps.documents.map((doc) => ImageModel.fromDoc(doc)).toList();
  }

  Future<ImageModel> getFavWall({docId}) async {
    DocumentSnapshot snaps =
        await _firestore.collection('Wallpapers').document(docId).get();
    return ImageModel.fromDoc(snaps);
  }

  Future<List<ImageModel>> search(search) async {
    var limit = 10;
    var srch = search.toString().toLowerCase();
    QuerySnapshot snaps = await _firestore
        .collection('Wallpapers')
        .where('tags', arrayContains: srch)
        .limit(10)
        .getDocuments();
    return snaps.documents.map((doc) => ImageModel.fromDoc(doc)).toList();
  }

  Future<List<ImageModel>> show({type, limit}) {
    switch (type) {
      case 'Trending':
        return showTrending(limit: limit);
        break;
      case 'Recent':
        return showRecents(limit: limit);
        break;
      default:
        print('Invalid type');
    }
  }

  Future favourite({docId, fav}) async {
    DocumentReference snap =
        _firestore.collection('Wallpapers').document(docId);
    await snap
        .updateData({'favourites': FieldValue.increment((fav ? (1) : (-1)))});

    userDBProvider = UserDBProvider();
    await userDBProvider.open();
// userDBProvider.deleteALl();

    if (fav == true) {
      _favourite = Favourite(wallId: docId);
      await userDBProvider.insert(_favourite);
    } else {
      userDBProvider.delete(docId);
    }
//  await userDBProvider.getWall(docId);
    await userDBProvider.getFavWallCount();
    await userDBProvider.close();
    print('object');
  }

  Future share({docId}) async {
    DocumentReference snap =
        _firestore.collection('Wallpapers').document(docId);
    await snap.updateData({'shares': FieldValue.increment(1)});
  }

  Future downloadCount({docId}) async {
    DocumentReference snap =
        _firestore.collection('Wallpapers').document(docId);
    await snap.updateData({'downloads': FieldValue.increment(1)});
    DocumentReference snap1 = _firestore.collection('Counts').document('count');
    await snap1.updateData({'downloads': FieldValue.increment(1)});
    // userDBProvider = UserDBProvider();
    // userDataModel = UserDataModel(
    //   isAdSeen: 0,
    //   wallId: docId
    // );
    // // userDBProvider.update(userDataModel);
    // userDBProvider.getUserCount(docId);
  }

  // Future check(docId)
  // async{
  // userDBProvider = UserDBProvider();

  // userDBProvider.getUserCount(docId).then((val)
  // async{
  //   if(val==0)
  //   {
  //     userDataModel = UserDataModel(
  //   isAdSeen: 0,
  //   wallId: docId
  // );
  //     await userDBProvider.insert(userDataModel);
  //     print('avail');
  //   }
  //   else{
  //     print('not avail');
  //   }
  // }
  // );

  // }
  Future<String> downloadImg({url, title}) async {
    var imageId = await ImageDownloader.downloadImage(
      url,
      destination: AndroidDestinationType.custom(directory: 'Pixiwall')
        ..subDirectory("Wallpapers/$title.jpg"),
    );
    var path = await ImageDownloader.findPath(imageId);
    return path;
  }

  Future downloadImage({url, title, docId, type}) async {
    // for a file
    // String msg;
    String imgPath = '/storage/emulated/0/Pixiwall/Wallpapers/$title.jpg';
    // print(msg);
    await io.File(imgPath).exists().then((data) async {
      if (data) {
        await setWallpaper(path: imgPath, type: type);
      } else {
        await downloadImg(title: title, url: url).then((path) async {
          print(path);
          await setWallpaper(path: path, type: type);
          await downloadCount(docId: docId);
        });
      }
    });

    // return msg;
  }

  //  Future asyncMethod(imgUrl,title) async {
  //     //comment out the next two lines to 'prove' the next time that you run
  //     // the code to prove that it was downloaded and saved to your device
  //     var url = imgUrl;
  //     var response = await get(url);
  //     var documentDirectory = await getApplicationDocumentsDirectory();
  //     var firstPath = documentDirectory.path + "/wallpapers";
  //     var filePathAndName = documentDirectory.path + '/downloaded/$title.jpg';
  //     //comment out the next three lines to 'prove' the next time that you run
  //     // the code to prove that it was downloaded and saved to your device
  //     await Directory(firstPath).create(recursive: true);
  //     File file2 = new File(filePathAndName);
  //     file2.writeAsBytesSync(response.bodyBytes);
  //     return true;
  //   }

  Future<String> setWallpaper({path, String type}) async {
    try {
      String ty = type;
      String val = await platform.invokeMethod(ty, {"imgPath": path});
      print(val);
      return val;
    } catch (e) {
      print(e);
      // return e;
    }
  }

  Future<void> shareTo({imgUrl, title, docId}) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse('$imgUrl'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('$title', '$title.jpg', bytes, 'image/jpg');
      await Share.files(
          'Share Wallpaper',
          {
            '$title.jpg': bytes,
          },
          '*/*',
          text:
              'Download Pixiwall App to download Awesome wallpaper like this.');
      await share(docId: docId);
    } catch (e) {
      print('error: $e');
    }
  }

  Stream<List<CategoryModel>> getCategories() {
    var limit = 5;
    Stream<QuerySnapshot> snaps = _firestore
        .collection('Categories')
        .orderBy('downloads')
        .limit(limit)
        .snapshots();
    return snaps.map((docs) =>
        docs.documents.map((doc) => CategoryModel.fromDoc(doc)).toList());
  }

  Future<List<ImageModel>> showTrending({limit}) async {
    Future<QuerySnapshot> snaps = await _firestore
        .collection('Wallpapers')
        .orderBy('downloads', descending: true)
        .limit(limit)
        .getDocuments()
        .then((snap) {
      snap.documents.map((data) {
        return ImageModel.fromDoc(data);
      }).toList();
    });
  }

  Future<List<ImageModel>> showRecents({limit}) async {
    Future<QuerySnapshot> snaps = await _firestore
        .collection('Wallpapers')
        .orderBy('created_at', descending: true)
        .limit(limit)
        .getDocuments()
        .then((snap) {
      snap.documents.map((data) {
        return ImageModel.fromDoc(data);
      }).toList();
    });
  }

  Stream<List<ImageModel>> showByCat({catName, limit}) {
    Stream<QuerySnapshot> snaps = _firestore
        .collection('Wallpapers')
        .where('category', isEqualTo: catName)
        .limit(limit)
        .snapshots();
    return snaps.map((docs) =>
        docs.documents.map((doc) => ImageModel.fromDoc(doc)).toList());
  }

  Future<int> deleteFile(FileSystemEntity file) async {
    try {
      // final file = await _localFile;

      await file.delete();
    } catch (e) {
      return 0;
    }
  }
}
