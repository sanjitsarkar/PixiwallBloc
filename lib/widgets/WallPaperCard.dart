import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';

Widget wallPapercard({imgUrl, title, grad, context, id}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 6),

    // height: h(context),
    // padding: EdgeInsets.all(value),
    // width: w(context),
    child: Stack(
      // overflow: Overflow.clip,
      // overflow: Overflow.visible,clear
      // fit: StackFit.expand,

      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned(
          top: 10,
          child: Container(
            width: w(context) / 3 + 20,
            height: h(context) / 3.6 + 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black87.withOpacity(.3))
              ],
              gradient: grad,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,

              // child:

              // Padding(

              //   padding: const EdgeInsets.only(bottom:10.0),

              //   child: Text('$title',style: style3,),

              // )
            ),
          ),
        ),
        Positioned(
          //  top:-15,
          child: Container(
              width: w(context) / 3,
              height: h(context) / 3.6,
              // padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Primary,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: '$id',
                  child: CachedNetworkImage(
                    imageUrl: '$imgUrl',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SpinKitChasingDots(
                      color: Colors.white,
                      size: 50.0,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.redAccent),
                  ),
                ),
              )),
        )
      ],
    ),
  );
}
