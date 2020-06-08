import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/bloc/favourite_bloc.dart';
// import 'package:pixiwall/bloc/wallpaper_bloc.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/repositories/FavRepo.dart';
// import 'package:pixiwall/repositories/WallpaperRepo.dart';
import 'package:pixiwall/screens/FullView.dart';
// import 'package:pixiwall/services/ImageService.dart';
// import 'package:pixiwall/services/state.Favouriteservice.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
// import 'package:pixiwall/widgets/SearchBar.dart';
// import 'package:pixiwall/widgets/Tags.dart';
// import 'package:pixiwall/widgets/WallPaperCard.dart';
import 'package:pixiwall/widgets/WallPaperCardNew.dart';
// import 'package:popup_menu/popup_menu.dart';
// import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
 final _scrollController = ScrollController();
 var _currentIndex;
 GlobalKey btnKey = GlobalKey();
 String sort;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _currentIndex = 1;
   sort = 'Favourite'
;      }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }


void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
     switch(_currentIndex)
     {
case 0:
Navigator.pushNamed(context, '/category',arguments: {'type':'Trending'});
break;
case 1:
Navigator.pushNamed(context, '/');
break;
case 2:

break;

     }
   });
 }
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    print(sort);
 
// final state.Favourites = Provider.of<List<ImageModel>>(context)??[];
    return BlocProvider<FavouriteBloc>(
      create: (_)=>FavouriteBloc(favRepo: FavRepo(),)..add(AppStarted1(limit: 5,offset: 0)),
          child: Scaffold(
          backgroundColor: Primary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Secondary,
          leading:IconButton(icon: Icon(Icons.arrow_back,color:Colors.white), onPressed: (){Navigator.pop(context);}),
          title: Text('Favourite Wallpapers',style:style4),
        
        ),
          body: 
           Container(
             width: w(context),
            //  height: h(context),
                        child: ListView(
             
               children: <Widget>[

               // SizedBox(height:50),
             
              SizedBox(height:30),
                       BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {

          
        },
        child:
BlocBuilder<FavouriteBloc, FavouriteState>(

  builder: (context, state) {

       

        if(state is FavouriteLoading)
  {
return Center(
  child:SpinKitChasingDots(
      color:Colors.white,
      size:50.0,
    ),
);
  }

  else if(state is FavouriteLoaded)
  {
    // print(state.fav.length);
    if(state.fav.length==0)
    {
      return Center(child:Text("No Favourite Wallpapers Found",style: style1,));
    }
else
{
    bool _onScrollNotificationWallpaper(BuildContext context,ScrollNotification notif,FavouriteLoaded state)
{
  if(notif is ScrollEndNotification && _scrollController.position.extentAfter == 0)
  {
    print('hello');
    context.bloc<FavouriteBloc>().add(LoadMoreWallpapers(wallpapers: state.fav,limit: 5));

  }
    print('false');
  return false;

}
  return
RefreshIndicator(
  onRefresh: ()
  async{
    setState(() {
    context.bloc<FavouriteBloc>()..add(RefreshWallpapers(limit: 5,offset: 0));
    });

  },
  child:   NotificationListener<ScrollNotification>(
    onNotification: (notification)=> _onScrollNotificationWallpaper(context,notification,state),
      child:  Container(
       width: w(context),
       height: h(context),
       
    
       child: GridView.builder(
            controller: _scrollController,
            itemCount: state.fav.length,
            physics: ClampingScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    
                    childAspectRatio: 2 / 3

                    ),
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                  // autofocus: false,
                  onTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullView(
                                      img: ImageModel(
                                    imgUrl:
                                        state.fav[i].imgUrl,
                                    title:
                                        state.fav[i].title,
                                    author:
                                        state.fav[i].author,
                                    id: state.fav[i].id,
                                    category:
                                        state.fav[i].category,
                                    downloads: 
                                        state.fav[i].downloads,
                                        
                                    isPremium:state.fav[i].isPremium,
                                    pixipoints: state.fav[i].pixipoints
                                  ))));
                  },
                  child: wallPapercardNew(
                      imgUrl: state.fav[i].imgUrl,
                      grad: grad1,
                      title: state.fav[i].title,
                      context: context,
                      id: state.fav[i].id));
            },
          ),
      //         ),
      )),
                       );
                    
 
  }
  }
   else if(state is FavouriteError)
  {
return(
Center(child: Text('Error Loading Categories',style: style1,),)
);
  }
  else
  {
    return Container();
  }
        // return widget here based on BlocA's state
  }
)),
// SizedBox(height:30),


]),
           ),
bottomNavigationBar:  BottomNavigationBar(

    backgroundColor: Secondary,

    type: BottomNavigationBarType.fixed,

    elevation: 4,
         onTap: onTabTapped, // new
         currentIndex: _currentIndex, 

    items: 
        <BottomNavigationBarItem>[


 BottomNavigationBarItem(
   
   icon: FaIcon(FontAwesomeIcons.fire,color: Colors.white), title: Text('Trending',style: GoogleFonts.roboto(color:Colors.white)),
 ),
      BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,size: 30,), title: Text('Home',style: GoogleFonts.roboto(color:Colors.white),)),

     

      // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list,color: Colors.white), title: Text('Category',style: TextStyle(color:Colors.white))),

      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart,color: Colors.white), title: Text('Favourite',style: GoogleFonts.roboto(color:Colors.white))),

    ],

         

        )
      ),

);


    }
  
  



//                                 child: GridView.builder(
//                                   controller: _scrollController,
//                                   itemCount: state.Favourites.length,
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2,
//                                           crossAxisSpacing: 0,
//                                           mainAxisSpacing: 0,
//                                           childAspectRatio: 2 / 3),
//                                   itemBuilder: (BuildContext context, int i) {
//                                     return InkWell(
//                                         autofocus: false,
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       FullView(
//                                                           img: ImageModel(
//                                                         imgUrl:
//                                                             state.fav[i].imgUrl,
//                                                         title:
//                                                             state.fav[i].title,
//                                                         author:
//                                                             state.fav[i].author,
//                                                         id: state.fav[i].id,
//                                                         category: snap
//                                                             .data[i].category,
//                                                         downloads: snap
//                                                             .data[i].downloads,
//                                                       ))));
//                                         },
//                                         child: wallPapercard(
//                                             imgUrl: state.fav[i].imgUrl,
//                                             grad: grad1,
//                                             title: state.fav[i].title,
//                                             context: context,
//                                             id: state.fav[i].id));
//                                   },
//                                 )),
//                           ),
//                         ]),
//                       )
                    
//             ]),
//           ),
  // Row buildTopBar(BuildContext context,String type) {
  //   return Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //            IconButton(icon: Icon(Icons.arrow_back,color:Colors.white), onPressed: (){Navigator.pop(context);}),
  //            Expanded(child: buildSort(type:type,)),
          
        
  //         ],);
  // }
      
  }


// WallPaperGrid(WallpaperState state)
// {
 

// }



// class TagList extends StatefulWidget {
//   TagList({Key key}) : super(key: key);

//   @override
//   _TagListState createState() => _TagListState();
// }

// class _TagListState extends State<TagList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: double.infinity,
//      height: 40,
//      child: ListView(
// scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          Tags(grad: grad3,name: 'iron man'),
//          Tags(grad: grad2,name: 'tony stark'),
//           Tags(grad: grad4,name: 'iron man'),
//          Tags(grad: grad3,name: 'tony stark'),
//           Tags(grad: grad5,name: 'iron man'),
//          Tags(grad: grad2,name: 'tony stark'),
//           Tags(grad: grad4,name: 'iron man'),
//          Tags(grad: grad3,name: 'tony stark'),
//       Text('Hello')
//        ],
//      ),
//     );
    
  // }
  
// }

class buildSort extends StatelessWidget {
  const buildSort({
    Key key,
    @required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$type Wallpapers',style:style4));
  }
}