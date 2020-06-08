import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/repositories/WallpaperRepo.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
   final WallpaperRepo _wallpaperRepo;
 DocumentSnapshot lDoc;
  //  String type;
 var l;
  WallpaperBloc({@required WallpaperRepo wallpaperRepo}):assert(wallpaperRepo!=null),
  _wallpaperRepo=wallpaperRepo;

  
  
  @override
  WallpaperState get initialState => WallpaperInitial();

  @override
  Stream<WallpaperState> mapEventToState(
    WallpaperEvent event,
  
  ) async* {
  if(event is AppStarted1)
  {
yield* _mapAppStartedToState(event);
  }
  else if(event is RefreshWallpapers)
  {
yield* _getWallpapers(wallpapers:[],limit: event.limit,sort:event.sort,cat: event.cat,search:event.search);
// print(event.cat);
  }
  else if(event is LoadMoreWallpapers)
  {
yield* _mapLoadMoreCategoriesToState(event);
  }
  
  }

  Stream<WallpaperState> _getWallpapers({List<ImageModel> wallpapers,int limit,DocumentSnapshot lastDoc,String search,String sort,String cat})
  async* {
try{
  List<ImageModel> wallList;

 
  QuerySnapshot snap = await _wallpaperRepo.getWallpaper(limit: limit,lastDoc: lastDoc,cat: cat,search: search,sort: sort);
  print('Search $search');
  l = snap.documents.length;
  // snap.documents.map((doc)
  // {
  //    catList.add(ImageModel.fromDoc(doc));
  // });
wallList =  snap.documents.map((doc)=>ImageModel.fromDoc(doc)).toList();
 
 
 List<ImageModel> newWallList = wallpapers +  wallList;
//     {
// catList.add(ImageModel.fromDoc(doc));

//     });
//   });;

  // print(lDoc);
if(l>=limit)
{
  lDoc = snap.documents[snap.documents.length-1];
  yield WallpaperLoaded(wallpapers: newWallList);
}





}
catch(e) {
  print(e);
  yield WallpaperError(error: '$e.');

}

  }

Stream<WallpaperState> _mapAppStartedToState(AppStarted1 event)
async*{
  yield WallpaperLoading();
  yield* _getWallpapers(wallpapers: [],limit: event.limit,sort:event.sort,search: event.search,cat: event.cat );

}


  Stream<WallpaperState> _mapLoadMoreCategoriesToState(LoadMoreWallpapers event)
  async*{
  int limit = WallpaperRepo.limit;

  print(l);
if(l>=limit)
{
    yield* _getWallpapers(wallpapers: event.wallpapers,limit: limit,lastDoc:lDoc ,sort:event.sort,cat: event.cat,search:event.search );
}
    

  }
}


