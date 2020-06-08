import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixiwall/model/CategoryModel.dart';

abstract class WallpaperRepository
{
  


Future getCatgory({int limit});
void dispose();



}