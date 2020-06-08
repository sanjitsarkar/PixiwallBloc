import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixiwall/model/ImageModel.dart';


class WallpaperRepo
{
  Firestore _firestore = Firestore.instance; 

  static const int limit = 2;


  @override
  Future getWallpaper({int limit,DocumentSnapshot lastDoc,String search,String sort,String cat}) async {
//  List<CategoryModel> catList = [];
print('cat $cat, search $search, sort $sort');
   try{
     QuerySnapshot snap;
     if(lastDoc==null)
     {
       print('not Called');

      
if(cat!=null)
{
       switch(sort)
       {
         case 'Recent':
print('recent cat not null');
                     snap = await _firestore.collection('Wallpapers').orderBy('created_at',descending: true).
                     where('category',isEqualTo: cat).
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('trending cat not null');
                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).limit(limit).
                     where('category',isEqualTo: cat).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).where('premium',isEqualTo: true).
                     where('category',isEqualTo: cat).limit(limit).getDocuments();
                     break;
          default:
          print('default cat not null');
          snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).
                     where('category',isEqualTo: cat).limit(limit).getDocuments();
                    
        
          
          
       }
       
     
     }
     else if(cat==null){

       if(search!=null)
       {
          print(' Repo $search');
switch(sort)
       {
         case 'Recent':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').orderBy('created_at',descending: true).where('tags',arrayContains: search).
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).where('tags',arrayContains: search).limit(limit).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).where('premium',isEqualTo: true).limit(limit).getDocuments();
                     break;
          default:
          print('default cat  null');
          snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).where('tags',arrayContains: search).limit(limit).getDocuments();
                    
        
          
          
       }
       }
       else{

       
       switch(sort)
       {
         case 'Recent':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').orderBy('created_at',descending: true).
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).limit(limit).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).where('premium',isEqualTo: true).limit(limit).getDocuments();
                     break;
          default:
          print('default cat  null');
          snap = await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).limit(limit).getDocuments();
                    
        
          
          
       }
       }
     }
     }
     else{
       print('called');
       if(cat!=null)
{
  // if(search!=null)
 
       switch(sort)
       {
         case 'Recent':
print('recent cat not null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('created_at',descending: true).
                     where('category',isEqualTo: cat).
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('trending cat not null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).
                     where('category',isEqualTo: cat).limit(limit).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).where('premium',isEqualTo: true).
                     where('category',isEqualTo: cat).limit(limit).getDocuments();
                     break;
          default:
          print('default cat not null');
          snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).
                     where('category',isEqualTo: cat).limit(limit).getDocuments();
                    
        
          
          
       }
       
     
     }
     else if(cat==null){
       if(search!=null)
       {
          print(' Repo $search');
           switch(sort)
       {
         case 'Recent':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('created_at',descending: true).where('tags',arrayContains: search).
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).where('tags',arrayContains: search).limit(limit).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).where('tags',arrayContains: search).where('premium',isEqualTo: true).limit(limit).getDocuments();
                     break;
          default:
          print('default cat  null');
          snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).where('tags',arrayContains: search).limit(limit).getDocuments();
                    
        
          
          
       }
      
       }
       else{
          switch(sort)
       {
         case 'Recent':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('created_at',descending: true).
                     
                     limit(limit).getDocuments();
                     break;
         case 'Trending':
print('recent cat  null');
                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).limit(limit).getDocuments();
                     break;
          case 'Premium':

                     snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).where('premium',isEqualTo: true).limit(limit).getDocuments();
                     break;
          default:
          print('default cat  null');
          snap = await _firestore.collection('Wallpapers').startAfterDocument(lastDoc).orderBy('downloads',descending: true).limit(limit).getDocuments();
                    
        
          
          
       }
        
       }
     }
     }

  //       snap = 
  // await _firestore.collection('Wallpapers').orderBy('downloads',descending: true).startAfterDocument(lastDoc).limit(limit).getDocuments();
     

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
    print(e);
    throw(e);
  }
  }
  
// Future<List<ImageModel>> search(search)
// async{
//   var limit = 10;
//   var srch = search.toString().toLowerCase();
// QuerySnapshot snaps = await _firestore.collection('Wallpapers').where(
//   'tags',arrayContains: srch
// )
// .limit(10).getDocuments();
// return snaps.documents.map(
//         (doc) => ImageModel.fromDoc(doc)).toList();
 
// }
}
  
