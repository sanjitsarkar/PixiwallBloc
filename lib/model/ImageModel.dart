import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel
{
  final String title,imgUrl;
  final String id,author,category;
  final num downloads,shares,fav;
  final bool isPremium;
  final int pixipoints;

  final List<dynamic> tags,colors;

  ImageModel({this.title, this.imgUrl, this.id,this.author,this.category,this.colors,this.tags,this.downloads,this.fav,this.shares,this.isPremium,this.pixipoints});

  factory ImageModel.fromDoc(DocumentSnapshot doc)
  {
    return ImageModel(
      
      
      title:doc['title'], 
      imgUrl:doc['imgUrl'],
      author:doc['author'],
      category:doc['category'],
      tags:doc['tags'],
      downloads:doc['downloads'],
      colors:doc['colors'],
      id:doc.documentID,
      fav: doc['favourites'],
      shares: doc['shares'],
      isPremium: doc['isPremium'],
      pixipoints: doc['pixipoints']
      
       );
  }
}