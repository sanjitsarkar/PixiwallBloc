part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AppStarted1 extends FavouriteEvent{
final int limit,offset;

   AppStarted1({this.limit,this.offset});

   @override
  // TODO: implement props
  List<Object> get props => [limit,offset];





}
class RefreshWallpapers extends FavouriteEvent{

//   final int limit;
// final String cat,premium,search,sort;
//   const RefreshWallpapers({this.cat,this.limit,this.premium,this.search,this.sort});
final int limit,offset;

   RefreshWallpapers({this.limit,this.offset});

   @override
  // TODO: implement props
  List<Object> get props => [limit,offset];
//   @override

//   List<Object> get props => [limit,search,premium,sort,cat];
}
// class SearchWallpaper extends WallpaperEvent{
  
// }
class LoadMoreWallpapers extends FavouriteEvent{
  final List<ImageModel> wallpapers;
final int limit;
  const LoadMoreWallpapers({this.wallpapers,this.limit});
  @override

  List<Object> get props => [wallpapers,limit];

  @override
  String toString() => 'LoadMoreWallpapers { wallpapers: $wallpapers and limit:$limit }';
  
}

