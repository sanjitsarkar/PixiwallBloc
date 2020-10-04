import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';

Widget wallPapercardNew({imgUrl, title, grad, context, id}) {
  return

      // height: h(context),
      // padding: EdgeInsets.all(value),
      // width: w(context),

      Container(
          // width: w(context)/3.5,
          // height: h(context)/3.6,
          // padding: EdgeInsets.all(8),
          // margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Secondary,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
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
          ));
}
