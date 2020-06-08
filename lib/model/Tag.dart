import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Tag extends Equatable
{
  final String tagName;

  Tag({this.tagName});

  @override
  // TODO: implement props
  List<Object> get props => [tagName];

  factory Tag.fromDoc(DocumentSnapshot doc)
  {
    return Tag(
      tagName:doc['tags'].toString(),
    );
  }

}