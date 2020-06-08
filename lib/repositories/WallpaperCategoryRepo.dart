import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pixiwall/model/CategoryModel.dart';


class WallpaperCategoryRepo
{
  Firestore _firestore = Firestore.instance; 

  static const int limit = 2;
  @override
  void dispose() {
  
  }

  @override
  Future getCatgory({int limit,DocumentSnapshot lastDoc}) async {
//  List<CategoryModel> catList = [];
   try{
     QuerySnapshot snap;
     if(lastDoc==null)
     {
       print('not Called');
     snap = 
  await _firestore.collection('Categories').orderBy('downloads',descending: true).limit(limit).getDocuments();
     }
     else{
       print('called');
        snap = 
  await _firestore.collection('Categories').orderBy('downloads',descending: true).startAfterDocument(lastDoc).limit(limit).getDocuments();
     }

    print(lastDoc);
    return snap;

//   {
//      snap.documents.map((doc)
//     {
// catList.add(CategoryModel.fromDoc(doc));

//     });
//   });
// print(catList);

 
    
  }
  
  catch(e)
  {
    throw(e);
  }
  }
}
  
