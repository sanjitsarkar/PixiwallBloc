import 'package:flutter/widgets.dart';

Widget line({height,color})  {
 


    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical:25),
      height: height,
      decoration: BoxDecoration(
        color:color,

      ),
    );
  
}