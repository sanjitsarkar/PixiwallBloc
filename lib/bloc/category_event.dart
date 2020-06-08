part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
 
  List<Object> get props => [];
}

class AppStarted extends CategoryEvent{}
class RefreshCategories extends CategoryEvent{}
class LoadMoreCategories extends CategoryEvent{
  final List<CategoryModel> category;

  const LoadMoreCategories({this.category});
  @override

  List<Object> get props => [category];

  @override
  String toString() => 'LoadMoreCategories { categories: $category}';
}


