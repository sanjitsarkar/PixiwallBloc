import 'package:flutter/material.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';

Widget titleBar({title,type,context}) {

    return  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Text('$title',style:style1,),
             Container(
              //  padding: btn,
               height: 30,
               decoration: BoxDecoration(
                  
                 color: Secondary,
borderRadius: radiusButton,
boxShadow: [shadow1],
               ),
               child: FlatButton(
                
                 
                 onPressed: ()
               {
Navigator.pushNamed(context, '/category',arguments: {'type':type});
               }, child: Text('See All',style:style1)),
             )
           ],
         );

  
}
