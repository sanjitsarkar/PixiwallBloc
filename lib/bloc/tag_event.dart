part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class AppStarted3 extends TagEvent
{

  final String cat,type,search,sort;
  final int limit;

  AppStarted3({this.cat, this.type, this.search, this.sort,this.limit});
 @override
  // TODO: implement props
  List<Object> get props => [cat,type,search,limit,sort];
}
class RefreshTags extends TagEvent
{
 
 final String cat,type,search,sort;
 final int limit;

  RefreshTags({this.cat, this.type, this.search, this.sort,this.limit});
 @override
  // TODO: implement props
  List<Object> get props => [cat,type,search,sort,limit];
  
}
class LoadMoreTags extends TagEvent
{
final String cat,type,search,sort;
final List<Tag> tags;
final int limit;
  LoadMoreTags({this.tags,this.cat, this.type, this.search, this.sort,this.limit});
 @override
  // TODO: implement props
  List<Object> get props => [tags,cat,type,search,sort,limit];
  
}

