import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/bloc/tag_bloc.dart';
import 'package:pixiwall/bloc/wallpaper_bloc.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/repositories/TagsRepo.dart';
import 'package:pixiwall/repositories/WallpaperRepo.dart';
import 'package:pixiwall/screens/FullView.dart';
import 'package:pixiwall/services/ImageService.dart';
// import 'package:pixiwall/services/state.wallpaperservice.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
import 'package:pixiwall/widgets/SearchBar.dart';
import 'package:pixiwall/widgets/Tags.dart';
import 'package:pixiwall/widgets/WallPaperCard.dart';
import 'package:pixiwall/widgets/WallPaperCardNew.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:provider/provider.dart';

class CategoryTypeScreen extends StatefulWidget {
  CategoryTypeScreen({Key key}) : super(key: key);

  @override
  _CategoryTypeScreenState createState() => _CategoryTypeScreenState();
}

class _CategoryTypeScreenState extends State<CategoryTypeScreen> {
 final _scrollController = ScrollController();
 var _currentIndex;
 GlobalKey btnKey = GlobalKey();
 String sort;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _currentIndex = 1;
   sort = 'Trending'
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

break;
case 1:
Navigator.pushNamed(context, '/');
break;
case 2:
Navigator.pushNamed(context, '/fav',arguments: {'type':'Trending'});
break;

     }
   });
 }
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    print(sort);
 
// final state.wallpapers = Provider.of<List<ImageModel>>(context)??[];
    return    MultiBlocProvider(
      providers: [  
       BlocProvider<TagBloc>(
      create: (_)=>TagBloc(tagsRepo: TagsRepo(),)..add(AppStarted3(cat:args['type'],limit: 10,sort:sort))),BlocProvider<WallpaperBloc>(
      create: (_)=>WallpaperBloc(wallpaperRepo: WallpaperRepo(),)..add(AppStarted1(sort: sort,limit: 4,cat: args['type'])))],
          child: Scaffold(
          backgroundColor: Primary,
        
          body: 
           Container(
             width: w(context),
             height: h(context),
                        child: Column(
             
               children: <Widget>[

               // SizedBox(height:50),
             
              SizedBox(height:30),
                       BlocListener<WallpaperBloc, WallpaperState>(
        listener: (context, state) {},
        child:
BlocBuilder<WallpaperBloc, WallpaperState>(

  builder: (context, state) {

         bool _onScrollNotificationWallpaper(BuildContext context,ScrollNotification notif,WallpaperLoaded state)
{
  if(notif is ScrollEndNotification && _scrollController.position.extentAfter == 0)
  {
    print('hello');
    context.bloc<WallpaperBloc>().add(LoadMoreWallpapers(wallpapers: state.wallpapers,sort: sort,limit: 2,cat: args['type']));

  }
  return false;
}

PopupMenu.context = context;
// final snap.data = Provider.of<List<ImageModel>>(context)??[];
void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');

    if(item.menuTitle=='Recent')
    {
      setState(() async{
        sort = 'Recent';

        context.bloc<WallpaperBloc>()..add(RefreshWallpapers(limit: 4,sort:sort));
         context.bloc<TagBloc>().add(AppStarted3(limit: 10 ,sort:sort));
print(sort);
      });
      
    }
    else if(item.menuTitle=='Trending')
    {
      setState(() async{
        sort = 'Trending';

         context.bloc<WallpaperBloc>()..add(RefreshWallpapers(limit: 4,sort:sort));
         context.bloc<TagBloc>().add(AppStarted3(limit: 10 ,sort:sort));
print(sort);
      });
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
void maxColumn() {
    PopupMenu menu = PopupMenu(
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        maxColumn: 2,

        backgroundColor: red2,
        highlightColor: red1,
        lineColor: Colors.white,

        items: [

          MenuItem(title: 'Trending',
          image:  FaIcon(FontAwesomeIcons.fire,color: Colors.white)
             
          ),
        
          // MenuItem(
          //     title: 'Home',
          //     // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
          //     image: Icon(
          //       Icons.home,
          //       color: Colors.white,
          //     )),
          // MenuItem(
          //     title: 'Mail',
          //     image: Icon(
          //       Icons.mail,
          //       color: Colors.white,
          //     )),
          MenuItem(
             title: 'Recent',

             image: FaIcon(FontAwesomeIcons.firstOrder,color: Colors.white)),

         
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }

        if(state is WallpaperLoading)
  {
return Center(
  child:SpinKitChasingDots(
      color:Colors.white,
      size:50.0,
    ),
);
  }

  else if(state is WallpaperLoaded)
  {
    print(state.wallpapers.length);
return 
RefreshIndicator(
  onRefresh: ()
  async{
    setState(() {
    context.bloc<WallpaperBloc>()..add(RefreshWallpapers(sort: sort,limit: 4,cat: args['type']));
    });

  },
  child:   NotificationListener<ScrollNotification>(
    onNotification: (notification)=> _onScrollNotificationWallpaper(context,notification,state),
      child:  Column(
        children: <Widget>[
      buildTopBar(context, maxColumn,args['type']),
      SizedBox(height:10),
               Container(
         height: 35,
         width: double.infinity,
     child:
     BlocListener<TagBloc, TagState>(
        listener: (context, state) {},
        child:
     BlocConsumer<TagBloc, TagState>(
    listener: (context, state) {
        // do stuff here based on BlocA's state
    },
    builder: (context, state) {
        return Tag(state);
        // return widget here based on BlocA's state
    }
)
     ),),
                SizedBox(height:10),
          SingleChildScrollView(
                        child: Container(
       width: w(context),
       height: h(context)/1.27,
       
    
       child: GridView.builder(
                              controller: _scrollController,
                              itemCount: state.wallpapers.length,
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
                                                        state.wallpapers[i].imgUrl,
                                                    title:
                                                        state.wallpapers[i].title,
                                                    author:
                                                        state.wallpapers[i].author,
                                                    id: state.wallpapers[i].id,
                                                    category:
                                                        state.wallpapers[i].category,
                                                    downloads: 
                                                        state.wallpapers[i].downloads,
                                                            isPremium:state.wallpapers[i].isPremium,
                                                            pixipoints: state.wallpapers[i].pixipoints
                                                  ))));
                                    },
                                    child: wallPapercardNew(
                                        imgUrl: state.wallpapers[i].imgUrl,
                                        grad: grad1,
                                        title: state.wallpapers[i].title,
                                        context: context,
                                        id: state.wallpapers[i].id));
                              },
                            ),
              ),
          ),
        ],
      )),
                       );
                    
 
  }
   else if(state is WallpaperError)
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
// bottomNavigationBar:  BottomNavigationBar(

//     backgroundColor: Secondary,

//     type: BottomNavigationBarType.fixed,

//     elevation: 4,
//          onTap: onTabTapped, // new
//          currentIndex: _currentIndex, 

//     items: 
//         <BottomNavigationBarItem>[


//  BottomNavigationBarItem(
   
//    icon: FaIcon(FontAwesomeIcons.fire,color: Colors.white), title: Text('Trending',style: GoogleFonts.roboto(color:Colors.white)),
//  ),
//       BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,size: 30,), title: Text('Home',style: GoogleFonts.roboto(color:Colors.white),)),

     

//       // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list,color: Colors.white), title: Text('Category',style: TextStyle(color:Colors.white))),

//       BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart,color: Colors.white), title: Text('Favourite',style: GoogleFonts.roboto(color:Colors.white))),

//     ],

         

//         )
      ),

);
  }
 Tag(TagState state)
{
  if(state is TagLoading)
  {
return Center(
  child:SpinKitChasingDots(
      color:Colors.white,
      size:50.0,
    ),
);
  }

  else if(state is TagLoaded)
  {
return RefreshIndicator(
  onRefresh: ()
  async{
    setState(() {
    context.bloc<TagBloc>().add(RefreshTags());
    });

  },
  child:   NotificationListener<ScrollNotification>(
    // onNotification: (notification)=> _onScrollNotification(notification,state),
      child: Container(
        height: 20,
        // width: w(context),
        child: ListView.builder(
    physics:ClampingScrollPhysics(),
          //  padding: EdgeInsets.symmetric(horizontal:10),
    // controller: _scrollController,
                scrollDirection: Axis.horizontal,
    
                shrinkWrap: true,
    
                itemCount: state.tags.length,
   
         
                itemBuilder: (context, i)
    
                {
                  Gradient grad;
  
   if(i%2==0)
   {
     grad = grad2;
   }
  
   else if(i%3==1)
   {
     grad = grad4; 
   }
    else if(i%3==0)
   {
     grad = grad3; 
   }
    else if(i%2==1)
   {
     grad = grad5;
   }
    return Tags(grad: grad,name: state.tags[i].tagName,context: context);
    
                },
    
              ),
      ),
  ),
);
  }
   else if(state is TagError)
  {
return(
Center(child: Text('Error Loading Categories',style: style1,),)
);
  }
  else
  {
    return Container();
  }


}

    
  
  



//                                 child: GridView.builder(
//                                   controller: _scrollController,
//                                   itemCount: state.wallpapers.length,
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
//                                                             state.wallpapers[i].imgUrl,
//                                                         title:
//                                                             state.wallpapers[i].title,
//                                                         author:
//                                                             state.wallpapers[i].author,
//                                                         id: state.wallpapers[i].id,
//                                                         category: snap
//                                                             .data[i].category,
//                                                         downloads: snap
//                                                             .data[i].downloads,
//                                                       ))));
//                                         },
//                                         child: wallPapercard(
//                                             imgUrl: state.wallpapers[i].imgUrl,
//                                             grad: grad1,
//                                             title: state.wallpapers[i].title,
//                                             context: context,
//                                             id: state.wallpapers[i].id));
//                                   },
//                                 )),
//                           ),
//                         ]),
//                       )
                    
//             ]),
//           ),
  Row buildTopBar(BuildContext context, void maxColumn(),String type) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             IconButton(icon: Icon(Icons.arrow_back,color:Colors.white), onPressed: (){Navigator.pop(context);}),
             Expanded(child: buildSort(type:type,)),
               IconButton(icon: Icon(Icons.list,color: Colors.white,),key: btnKey,onPressed: (){

        maxColumn();
      },),
        
          ],);
  }
      
  }


// WallPaperGrid(WallpaperState state)
// {
 

// }



class TagList extends StatefulWidget {
  TagList({Key key}) : super(key: key);

  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
     height: 40,
     child: ListView(
scrollDirection: Axis.horizontal,
       children: <Widget>[
         Tags(grad: grad3,name: 'iron man'),
         Tags(grad: grad2,name: 'tony stark'),
          Tags(grad: grad4,name: 'iron man'),
         Tags(grad: grad3,name: 'tony stark'),
          Tags(grad: grad5,name: 'iron man'),
         Tags(grad: grad2,name: 'tony stark'),
          Tags(grad: grad4,name: 'iron man'),
         Tags(grad: grad3,name: 'tony stark'),
      Text('Hello')
       ],
     ),
    );
    
  }
  
}

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