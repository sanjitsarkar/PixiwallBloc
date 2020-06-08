import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pixiwall/model/Favourite.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/repositories/FavRepo.dart';
import 'package:pixiwall/services/UserDBProvider.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
final FavRepo _favRepo;
  UserDBProvider _dbProvider;
 
  int count= 0;
   int l = 0;
    FavouriteBloc({@required FavRepo favRepo}):assert(favRepo!=null),
  _favRepo=favRepo;
  @override
  FavouriteState get initialState => FavouriteInitial();

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    // TODO: implement mapEventToState
     if(event is AppStarted1)
  {
yield* _mapAppStartedToState(event);
  }
  else if(event is RefreshWallpapers)
  {
yield* _getWallpapers();

  }
  else if(event is LoadMoreWallpapers)
  {
    print('event: ${event.wallpapers}');
yield* _mapLoadMoreCategoriesToState(event);
  }
  
  }

  Stream<FavouriteState> _getWallpapers({List<ImageModel> wallps,int limit,int offset})
  async* {
try{
// ImageModel img = ImageModel();
 List<Favourite> fav=[];
  List<ImageModel> images = [];
   _dbProvider = UserDBProvider();
 await  _dbProvider.open();
 count = await _dbProvider.getFavWallCount();
bool load_more = true;
int lim = limit;
 print("Count $count");
 l = l+limit;
 print("Total Limit $l");
// if((l-count)<limit)
// {
//   limit = (l-count);
// }
if(l>count)
{
  limit = ((l-count)-limit).abs();

print('Limit $limit');
}

if(lim>=limit)
{
  fav = await _dbProvider.getFavWalls(limit:limit,offset: offset);
  if(fav!=null)
  {
    await Future.forEach(fav,(f) async {
    DocumentSnapshot snapshot = await FavRepo().getWallpaper(docId: f.wallId);
 
//  img = ImageModel.fromDoc(snapshot);
    images.add(ImageModel.fromDoc(snapshot));
}).then((_)=>images);
  }
// yeild FavouriteLoaded(fav: images)
// print(images);
// fav.forEach((f)
//   async{
// DocumentSnapshot snapshot = await FavRepo().getWallpaper(docId: f.wallId);
 
//  img = ImageModel.fromDoc(snapshot);
//  print(img.title);
// return img;
//   });
List<ImageModel> newWallList = wallps +  images;

// print(newWallList);
 yield FavouriteLoaded(fav:newWallList);
}
  // print(fav);


  //   fav.map((f)
  // async{


  // });

//  print(images);
   
  }
  catch(e)
  {
print(e);
  }
  }
Stream<FavouriteState> _mapAppStartedToState(AppStarted1 event)
async*{
 
  yield FavouriteLoading();
  //  print('hello');
  yield* _getWallpapers(wallps:[],limit: event.limit,offset: event.offset);

}


  Stream<FavouriteState> _mapLoadMoreCategoriesToState(LoadMoreWallpapers event)
  async*{


    yield* _getWallpapers(wallps: event.wallpapers,limit: event.limit,offset: event.limit);

    

  }
  }

