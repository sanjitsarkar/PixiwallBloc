import 'package:sqflite/sqflite.dart';

class PremiumWallpaper {
  String wallId;

  PremiumWallpaper({this.wallId});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'wallId': wallId,
    };

    return map;
  }

  PremiumWallpaper.fromMap(Map<String, dynamic> map) {
    PremiumWallpaper(
      wallId: map['wallId'],
    );
  }
}
