part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
   @override
  List<Object> get props => [];
}
//Initial State
class CategoryEmpty extends CategoryState {}

//Loading State
class CategoryLoading extends CategoryState {}

//Fetched State
class CategoryLoaded extends CategoryState {
  final List<CategoryModel> category;

  CategoryLoaded({this.category});

  @override
  // TODO: implement props
  List<Object> get props => [category];

  @override
  String toString()=> 'CategoryLoaded{category:$category}';

}

// Error State
class CategoryError extends CategoryState {


}