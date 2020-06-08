part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

   @override
  List<Object> get props => [];
}

class WallpaperInitial extends WallpaperState {

}

class WallpaperLoading extends WallpaperState
{

}

class WallpaperLoaded extends WallpaperState
{
  final List<ImageModel> wallpapers;

  WallpaperLoaded({this.wallpapers});

  @override
  // TODO: implement props
  List<Object> get props => [wallpapers];

  @override
  String toString()=> 'WallpaperLoaded{wallpapers:$wallpapers}';
  
}
class WallpaperError extends WallpaperState
{
final String error;

  WallpaperError({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];



}
class WallpaperCount extends WallpaperState
{

}