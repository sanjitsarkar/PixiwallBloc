import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixiwall/model/ImageModel.dart';


class FavRepo
{
  Firestore _firestore = Firestore.instance; 


Future<DocumentSnapshot> getWallpaper({String docId}) async {
 try{
      DocumentSnapshot snap;
 
      
       print('not Called');
snap  = await _firestore.collection('Wallpapers').document(docId).get();
return snap;
}


 


catch(e)
{
print(e);
}
}
}