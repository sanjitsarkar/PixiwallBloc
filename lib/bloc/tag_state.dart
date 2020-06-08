part of 'tag_bloc.dart';

abstract class TagState extends Equatable {
  const TagState();
}

class TagInitial extends TagState {
  @override
  List<Object> get props => [];
}

class TagLoading extends TagState {
  @override
  List<Object> get props => [];
}

class TagLoaded extends TagState {
   final List<Tag> tags;

  TagLoaded({this.tags});

  @override
  // TODO: implement props
  List<Object> get props => [tags];

  @override
  String toString()=> 'TagLoaded{tags:$tags}';
}
class TagError extends TagState {
  final String error;

  TagError({this.error});
  @override
  List<Object> get props => [error];
}