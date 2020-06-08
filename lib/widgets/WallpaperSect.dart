import 'package:flutter/material.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/screens/FullView.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
import 'package:pixiwall/widgets/TitleBar.dart';
import 'package:pixiwall/widgets/WallPaperCard.dart';

class WallPaperSect extends StatelessWidget {
  final String title;
  List<ImageModel> images;
   WallPaperSect({Key key,this.title,this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: content,
      child: Column(
       
        children: <Widget>[
          titleBar(title: '$title',type:'Recent',context: context),
          SizedBox(height:30),
          Container(
            
            width: double.infinity,
            height:h(context)/2.7,
            child: 
            
            
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
             itemCount: images.length,
             itemBuilder: (context,i)
             {
           return InkWell(
             autofocus: false,
             
               onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => FullView(img: ImageModel(
                 imgUrl: images[i].imgUrl,
                 title: images[i].title,
                 author:images[i].author,
                 id:images[i].id,
                 downloads:images[i].downloads,
                 fav: images[i].fav,
                 shares: images[i].shares,
                 
                 category:images[i].category 
               ))));},
               child: wallPapercard(imgUrl: images[i].imgUrl,grad: grad1,title:images[i].title ,context: context,id:images[i].id ));
              },),
  
          ),
          

         
        ],
      ),
    );
  }
}