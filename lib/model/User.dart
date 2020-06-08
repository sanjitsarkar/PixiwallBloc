import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable
{
  final String username,email,displayPic,uid;
  final int pixipoints,purchases;

  User({this.username,this.email,this.displayPic,this.pixipoints,this.purchases,this.uid});

  @override
  // TODO: implement props
  List<Object> get props => [username,email,displayPic,pixipoints,purchases,uid];

  factory User.fromDoc(DocumentSnapshot doc)
  {
    return User(
      uid: doc['uid'],
      username:doc['username'],
      email:doc['email'],
      displayPic:doc['displayPic'],
      pixipoints:doc['pixipoints'],
      purchases:doc['purchases']
    );
  }

}