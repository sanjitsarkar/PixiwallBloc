part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

   @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {

}

class FavouriteLoading extends FavouriteState
{

}

class FavouriteLoaded extends FavouriteState
{
  final List<ImageModel> fav;

  FavouriteLoaded({this.fav});

  @override
  // TODO: implement props
  List<Object> get props => [fav];

  @override
  String toString()=> 'FavouriteLoaded{Favourites:$fav}';
  
}
class FavouriteError extends FavouriteState
{
final String error;

  FavouriteError({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];



}
class FavouriteCount extends FavouriteState
{

}