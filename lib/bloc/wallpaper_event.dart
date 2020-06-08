part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AppStarted1 extends WallpaperEvent{

final int limit;
final String cat,premium,search,sort;
  const AppStarted1({this.cat,this.limit,this.premium,this.search,this.sort});
  @override

  List<Object> get props => [limit,search,premium,sort,cat];

  @override
  String toString() => 'LoadMoreWallpapers { wallpapers: $sort limit: $limit}';

}
class RefreshWallpapers extends WallpaperEvent{

  final int limit;
final String cat,premium,search,sort;
  const RefreshWallpapers({this.cat,this.limit,this.premium,this.search,this.sort});
  @override

  List<Object> get props => [limit,search,premium,sort,cat];
}
// class SearchWallpaper extends WallpaperEvent{
  
// }
class LoadMoreWallpapers extends WallpaperEvent{
  final List<ImageModel> wallpapers;
  final int limit;
final String cat,premium,search,sort;
  const LoadMoreWallpapers({this.wallpapers,this.limit,this.cat,this.premium,this.search,this.sort});
  @override

  List<Object> get props => [wallpapers,limit,search,premium,cat,sort];

  @override
  String toString() => 'LoadMoreWallpapers { wallpapers: $wallpapers and type: }';
  
}

