import 'package:sqflite/sqflite.dart';

class Favourite
{
  String wallId;


  Favourite({this.wallId});
Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
       
      'wallId': wallId,

    };

    return map;
  }

 

  Favourite.fromMap(Map<String, dynamic> map) {
     Favourite(
      wallId:map['wallId'],
     
    );
  }

}