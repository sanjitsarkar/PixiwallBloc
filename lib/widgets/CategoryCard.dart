import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiwall/shared/consts.dart';

Widget categoryCard({title,imgUrl,grad,context}) {
  
    return InkWell(
      onTap: ()
      {
        Navigator.pushNamed(context, '/categoryType',arguments: {'type':title});
      },
          child: Container(
        margin: EdgeInsets.only(right:30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
Container(
              
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                // gradient: grad,
                color: Colors.white
// image: DecorationImage(image: AssetImage('),fit: BoxFit.cover

// )
              ),
             
              
            ),
            
              Container(
              
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                
),
child: ClipRRect(
  borderRadius:BorderRadius.circular(100),
  child:   CachedNetworkImage(imageUrl: '$imgUrl',
  
          fit: BoxFit.cover,
  
          placeholder: (context, url) =>SpinKitChasingDots(
  
          color:Colors.white,
  
          size:50.0,
  
        ) ,
  
         
  
          errorWidget: (context, url, error) => Icon(Icons.error,color:Colors.redAccent),),
),

)
              
             
              
            
            
            ],),
            
            SizedBox(height:10),
                    Text('$title',style:style2)
          ],
        ),
      ),
    );
  }
