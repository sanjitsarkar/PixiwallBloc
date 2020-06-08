import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel
{
  String title;
  String imgUrl;
  int total;
  int downloads;
  String id;

  CategoryModel({this.title,this.imgUrl,this.total,this.downloads,this.id});
factory CategoryModel.fromDoc(DocumentSnapshot doc)
  {
    return CategoryModel(
      
      
      title:doc['categoryName'], 
      imgUrl:doc['imgUrl'],
      downloads:doc['downloads'],
      total:doc['total'],
      id:doc.documentID,
      
      
       );
  }

}