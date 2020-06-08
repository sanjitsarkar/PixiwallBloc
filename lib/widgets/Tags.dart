import 'package:flutter/material.dart';
import 'package:pixiwall/screens/SearchScreen.dart';
import 'package:pixiwall/shared/consts.dart';

Widget Tags({name,grad,context})
{
 return InkWell(
   onTap: ()
   {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(src: name,)));
   },
    child: Container(
     alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal:10),
      padding: EdgeInsets.symmetric(horizontal: 20,),
      decoration: BoxDecoration(
        gradient: grad,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text('$name',style: style3,),
    ),
 );
}