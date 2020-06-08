import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/shared/colors.dart';

double w(BuildContext context)
{
  return MediaQuery.of(context).size.width;
}

double h(BuildContext context)
{
  return MediaQuery.of(context).size.height;
}

TextStyle style1 = GoogleFonts.montserrat(color:HexColor('#DBDADA'),fontSize:13,fontWeight: FontWeight.w500);
TextStyle style3 = GoogleFonts.montserrat(color:Colors.white,fontSize:13,fontWeight: FontWeight.w500);
TextStyle style4 = GoogleFonts.montserrat(color:Colors.white,fontSize:17,fontWeight: FontWeight.bold);
TextStyle style5 = GoogleFonts.montserrat(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold);
TextStyle style6 = GoogleFonts.montserrat(color:Colors.white,fontSize:17,fontWeight: FontWeight.w500);
TextStyle style7 = GoogleFonts.montserrat(color:Colors.white,fontSize:15,fontWeight: FontWeight.w200);
EdgeInsets btn =  EdgeInsets.symmetric(vertical:0,horizontal:5);
EdgeInsets content =  EdgeInsets.symmetric(horizontal:25); 
TextStyle style2 = GoogleFonts.lato(color:HexColor('#DBDADA'),fontSize:11,fontWeight: FontWeight.w500);
BorderRadius radiusbottom = BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15));
BorderRadius radiusButton = BorderRadius.all(Radius.circular(100));
BorderRadius radiusbottom1 = BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10));
BorderRadius radiusdiagonal = BorderRadius.only(bottomLeft: Radius.circular(28),topRight: Radius.circular(28));
BorderRadius radiusTop = BorderRadius.only(topLeft: Radius.circular(208),topRight: Radius.circular(208));
BoxShadow shadow1 = BoxShadow(color: shadowColor,offset: Offset(0, 3),blurRadius: 6);

