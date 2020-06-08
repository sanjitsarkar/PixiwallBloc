import 'package:flutter/material.dart';
import 'package:pixiwall/shared/consts.dart';

Widget resultSect({result})
{
return
Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal:20),
  child:   (
  
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
  
    Text('$result Wallpapers Found',style: style1),
    Row(children: <Widget>[
      IconButton(icon: Icon(Icons.list,color: Colors.white,), onPressed: (){},),
      Text('Filter',style: style1)
    ],)

  ],)
  
  ),
);
}
