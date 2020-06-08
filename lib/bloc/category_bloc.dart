import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pixiwall/model/CategoryModel.dart';
import 'package:pixiwall/repositories/WallpaperCategoryRepo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  
  final WallpaperCategoryRepo _categoryRepo;
 DocumentSnapshot lDoc;
 var l;
  CategoryBloc({@required WallpaperCategoryRepo categoryRepo}):assert(categoryRepo!=null),
  _categoryRepo=categoryRepo;

  
  
  @override
  CategoryState get initialState => CategoryEmpty();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
  if(event is AppStarted)
  {
yield* _mapAppStartedToState();
  }
  else if(event is RefreshCategories)
  {
yield* _getCategories(categories:[]);
  }
  else if(event is LoadMoreCategories)
  {
yield* _mapLoadMoreCategoriesToState(event);
  }
  
  }

  Stream<CategoryState> _getCategories({List<CategoryModel> categories,int limit = 5,DocumentSnapshot lastDoc})
  async* {
try{
  List<CategoryModel> catList;
  QuerySnapshot snap = await _categoryRepo.getCatgory(limit: limit,lastDoc: lastDoc);
  
  l = snap.documents.length;
  // snap.documents.map((doc)
  // {
  //    catList.add(CategoryModel.fromDoc(doc));
  // });
catList =  snap.documents.map((doc)=>CategoryModel.fromDoc(doc)).toList();
 
 
 List<CategoryModel> newCategoryList = categories +  catList;
//     {
// catList.add(CategoryModel.fromDoc(doc));

//     });
//   });;

  // print(lDoc);
if(l>=limit)
{
  lDoc = snap.documents[snap.documents.length-1];
}


yield CategoryLoaded(category: newCategoryList);

}
catch(err){
  print(err);
  yield CategoryError();

}
  }

Stream<CategoryState> _mapAppStartedToState()
async*{
  yield CategoryLoading();
  yield* _getCategories(categories: []);

}


  Stream<CategoryState> _mapLoadMoreCategoriesToState(LoadMoreCategories event)
  async*{
  int limit = WallpaperCategoryRepo.limit;
  print(l);
if(l>=limit)
{
    yield* _getCategories(categories: event.category,limit: limit,lastDoc:lDoc );
}
    

  }
}
