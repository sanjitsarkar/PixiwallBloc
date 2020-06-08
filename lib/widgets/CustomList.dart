import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/shared/consts.dart';

Widget customList({title,iconData,context,route}) {

 
    return  Container(
    decoration: BoxDecoration(
      boxShadow:[shadow1]
    ),
    child: ListTile(
      leading: Icon(iconData,color: Colors.white,),
      onTap: ()
      {
        Navigator.pushNamed(context, route);
      },
      contentPadding: EdgeInsets.symmetric(horizontal:20,vertical:8),
      title: Text('$title',style: GoogleFonts.roboto(color:Colors.white,fontSize: 15)),
    ),
  );
  
}