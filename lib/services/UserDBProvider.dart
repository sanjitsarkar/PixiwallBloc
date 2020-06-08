import 'dart:async';
import 'dart:io';

import 'package:pixiwall/model/Favourite.dart';
import 'package:pixiwall/model/PremiumWallpaper.dart';
// import 'package:pixiwall/model/UserDataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class UserDBProvider {
//   final String TableName="UserTable";
//   static Database db_instance;

//   Future<Database> get db async
//   {
// if(db_instance==null)
// db_instance = await initDB();
// return db_instance;
//   }

//   initDB() async{
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path,"UserDB.db");
//     var db = await openDatabase(path,version:1,onCreate:onCreateFunc);
//     return db;
//   }
  Database db;

  String tableName = "Favourite";
  String tableName1 = "Premium";
  String wallId = "wallId";
  String date = "date";

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Pixiwall.db');
    String id = 'id';
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableName ( 
  $id integer primary key autoincrement, 
  $wallId text not null,
  $date date
  )
''');
    });

    print('done');
  }

  Future openPremium() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Pixiwall.db');
    String id = 'id';
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableName1 ( 
  $id integer primary key autoincrement, 
  $wallId text not null,
  $date date
  )
''');
    });
    print("Done Premium");
  }

  Future<int> insert(Favourite fav) async {
    int status = await db.insert(tableName, fav.toMap());
    return status;
  }

  Future<int> insertPremium({PremiumWallpaper premiumWallpaper}) async {
    int status = await db.insert(tableName1, premiumWallpaper.toMap());
    print('done $status');
    return status;
  }

//  Future<UserDataModel> insert(UserDataModel user) async {
//     user.id = await db.insert(tableName, user.toMap());
//     return user;
//   }
  Future<String> getWall(String docId) async {
    String id;
    List<Map> maps = await db.query(tableName,
        columns: [wallId], where: '$wallId = ?', whereArgs: [docId]);
    if (maps.length >= 1) {
      maps.forEach((data) {
        print(data['wallId']);
        id = data['wallId'];
      });
    }
    return id;
  }

  Future<String> getWallPremium(String docId) async {
    String id;
    List<Map> maps = await db.query(tableName1,
        columns: [wallId], where: '$wallId = ?', whereArgs: [docId]);
    if (maps.length >= 1) {
      maps.forEach((data) {
        print(data['wallId']);
        id = data['wallId'];
      });
    }
    return id;
  }

  Future<List<Favourite>> getFavWalls({limit, offset}) async {
    List<Favourite> favr = [];
    List<Map> maps = await db.query(
      tableName,
      columns: [wallId],
      offset: offset,
      limit: limit,
    );

    if (maps.length > 0) {
      print(maps.length);
      maps.map((m) {
        // print(m['wallId']);
        favr.add(Favourite(wallId: m['wallId']));
      }).toList();
      // favr.forEach((f)
      // {
      //   print(f.wallId);
      // });
      return favr;
    }
  }

  Future<List<PremiumWallpaper>> getPremiumWalls({limit, offset}) async {
    List<PremiumWallpaper> premium = [];
    List<Map> maps = await db.query(
      tableName1,
      columns: [wallId],
      offset: offset,
      limit: limit,
    );

    if (maps.length > 0) {
      print(maps.length);
      maps.map((m) {
        // print(m['wallId']);
        premium.add(PremiumWallpaper(wallId: m['wallId']));
      }).toList();
      // favr.forEach((f)
      // {
      //   print(f.wallId);
      // });
      return premium;
    }
  }

  Future<int> getFavWallCount() async {
    List<Map> maps = await db.query(tableName, columns: [wallId]);
    if (maps.length > 0) {
      print(maps.length);
      return maps.length;
    }
    return 0;
  }

  Future<int> getPremiumWallCount() async {
    List<Map> maps = await db.query(tableName1, columns: [wallId]);
    if (maps.length > 0) {
      print(maps.length);
      return maps.length;
    }
    return 0;
  }

  Future<int> delete(String id) async {
    return await db.delete(tableName, where: '$wallId = ?', whereArgs: [id]);
  }

  Future<int> deletePremium(String id) async {
    return await db.delete(tableName, where: '$wallId = ?', whereArgs: [id]);
  }

  Future<int> deleteALl() async {
    return await db.delete(tableName);
  }

  Future<int> deleteALlPremium() async {
    return await db.delete(tableName1);
  }
//   Future<int> update(UserDataModel user) async {
//     return await db.update(tableName, user.toMap(),
//         where: '$wallId = ?', whereArgs: [user.wallId]);
//   }

  Future close() async => db.close();
  Future closePremium() async => db.close();
//   void onCreateFunc(Database db, int version) async{
//   await db.execute('CREATE TABLE $TableName(
// '''
// create table $TableName (
//   _id integer primary key autoincrement,
//   wallId text not null,
//    isAdseen integer not null)
// // '''
//   );
//   }
}
