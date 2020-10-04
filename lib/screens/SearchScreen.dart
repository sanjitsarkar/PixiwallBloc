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
// import 'package:pixiwall/services/ImageService.dart';
// import 'package:pixiwall/services/snap.dataervice.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
// import 'package:pixiwall/widgets/ResultSect.dart';
// import 'package:pixiwall/widgets/SearchBar.dart';
import 'package:pixiwall/widgets/Tags.dart';
// import 'package:pixiwall/widgets/WallPaperCard.dart';
import 'package:pixiwall/widgets/WallPaperCardNew.dart';
import 'package:popup_menu/popup_menu.dart';
// import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  String src;
  SearchScreen({Key key,this.src}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController;
String search;
int length;
TextEditingController _controller;
String sort;
PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    search=widget.src;
    length=0;
    _controller = TextEditingController();
   sort = 'Trending';
_controller.text=widget.src;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
   
print(search);
    return MultiBlocProvider(
      providers: [  
       BlocProvider<TagBloc>(
      create: (_)=>TagBloc(tagsRepo: TagsRepo(),)..add(AppStarted3(limit: 10,sort:sort,search: search))),BlocProvider(
           create: (context) => WallpaperBloc(wallpaperRepo: WallpaperRepo())..add(AppStarted1(limit: 4,search: search,sort:sort)))],
          child: Scaffold(
           backgroundColor: Primary,
           body:
             BlocListener<WallpaperBloc, WallpaperState>(
               listener: (context, state) {
                 // TODO: implement listener
               },
               child: ListView(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                      
                    //  SizedBox(height:30),
      
  
       
                       BlocBuilder<WallpaperBloc, WallpaperState>(
                         builder: (context, state) {


                                 bool _onScrollNotificationWallpaper(BuildContext context,ScrollNotification notif,WallpaperLoaded state)
{
  if(notif is ScrollEndNotification && _scrollController.position.extentAfter == 0)
  {
      
      context.bloc<WallpaperBloc>().add(LoadMoreWallpapers(wallpapers: state.wallpapers,sort: sort,limit: 5,search: search));

  }
  return false;
}
                          //  print(search);
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

        context.bloc<WallpaperBloc>()..add(RefreshWallpapers(limit: 4,search: search,sort:sort));
        context.bloc<TagBloc>().add(AppStarted3(search:search,limit: 10 ,sort:sort));
print(sort);
      });
    }
    else if(item.menuTitle=='Trending')
    {
      setState(() async{
        sort = 'Trending';

        context.bloc<WallpaperBloc>()..add(RefreshWallpapers(limit: 4,search: search,sort:sort));
        context.bloc<TagBloc>().add(AppStarted3(search:search,limit: 10 ,sort:sort));
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
return Container(
  width:w(context),
  height:h(context),
  child:   Center(
  
    child:SpinKitChasingDots(
  
          color:Colors.white,
  
          size:50.0,
  
        ),
  
  ),
);
  }

  else if(state is WallpaperLoaded)
  {

      if(state.wallpapers.length==0)
      {
            return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              
         
             SizedBox(height:h(context)/20),
  buildTopBar(context, maxColumn), 

  // buildSort(sort: sort),
    // buildForm(context),
      //  child: child,5
  
 buildStatus()]);
      }
      else{
return RefreshIndicator(
  onRefresh: ()
  async{
      setState(() {
      context.bloc<WallpaperBloc>()..add(RefreshWallpapers(sort: sort,limit: 4,search: search));
      });

  },
  child:   NotificationListener<ScrollNotification>(
      onNotification: (notification)=> _onScrollNotificationWallpaper(context,notification,state),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
   buildSort(sort: sort),
            buildTopBar(context, maxColumn),
        
          //  buildForm(context),
      

      SizedBox(height:20),
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
      // SizedBox(height:10),
      
            SingleChildScrollView(
                          child: Container(
                      width: w(context),
                      height: h(context)/1.2,
      
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
                   );}
                
 
  }
   else if(state is WallpaperError)
  {
return(
Center(child: Text('${state.error}',style: style1,),)
);
  }
  else
  {
      return Container();
  }
                         },
                       ),
                     ],
                   )
             ),
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
    context.bloc<TagBloc>().add(RefreshTags(search:search,limit: 10 ));
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
  Padding buildStatus() {
    return Padding(
 padding: EdgeInsets.only(top:30),
 child: Center(
     child: Text('WALLPAPER NOT FOUND 😞',style: GoogleFonts.montserrat(color: Colors.white,
     
     fontSize: 20),),
 ));
  }

  Row buildTopBar(BuildContext context, void maxColumn()) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             IconButton(icon: Icon(Icons.arrow_back,color:Colors.white), onPressed: (){Navigator.pop(context);}),
             Expanded(child: buildForm(context)),
               IconButton(icon: Icon(Icons.list,color: Colors.white,),key: btnKey,onPressed: (){

        maxColumn();
      },),
        
          ],);
  }

  Form buildForm(BuildContext context) {
    return Form(
    child: Container(
            alignment: Alignment.center,
            width:w(context)/2.5,
            // margin:const EdgeInsets.symmetric(horizontal:60.0) ,
            padding: EdgeInsets.symmetric(horizontal:10.0,vertical:0.0),
          
            //Search box codes!
            decoration: BoxDecoration(
              
              color: Accent.withOpacity(.5),
              borderRadius: BorderRadius.circular(100.0)
            ),
            child: TextField(

              textAlignVertical: TextAlignVertical.center,
                      controller: _controller,        
                autofocus: false,
                style:  GoogleFonts.montserrat(color: Colors.white),
//                   onSubmitted: (e)
//                   {
// setState(() {
//   search=e;

// });
//                   },
onSubmitted:(e)
                async{
 setState(() {
 search = e;
 
context.bloc<WallpaperBloc>()..add(RefreshWallpapers(limit: 4,search: e,sort:sort));
context.bloc<TagBloc>().add(AppStarted3(search:search,limit: 10 ,sort:sort));
 });
                 
                  print(e);
                  if(e.isNotEmpty || e == ' ')
                  {
 
//  _controller.clear();
 
print(search);



                  }
                  else{
Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please Enter Something',style:style1),backgroundColor: Secondary,));
                  }
                },
                onChanged: (e)
                {
search=e;
                },
                decoration: InputDecoration(
                
                prefixIcon: Icon(Icons.search,color: Colors.white.withOpacity(.8),),
                suffixIcon: search.isNotEmpty?IconButton(onPressed: ()
                {
                  search='';
                  _controller.clear();
                }, icon:Icon(Icons.clear),color: Colors.white):null,
                border: InputBorder.none,
       
                filled: false,
                // fillColor: Colors.white,
                
                hintText:"Search WallPapers",
                hintStyle:GoogleFonts.montserrat(color: Colors.white.withOpacity(.5))
                ),
              
              ),

          ),
    //  child: child,
);
  }


  
}

class buildSort extends StatelessWidget {
  const buildSort({
    Key key,
    @required this.sort,
  }) : super(key: key);

  final String sort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:50.0,bottom: 15),
      child: Center(child: Text('$sort Wallpapers',style:style4)),
    );
  }
}



// IconButton(icon: Icon(Icons.arrow_back,color:Colors.white), onPressed: (){Navigator.pop(context);})
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
//   }
// }






//         return Column(
               
//                children: <Widget>[
// // SizedBox(height:60),
      
//     // SizedBox(height:10),
// resultSect(result: '${snap.data.length}'),
//     SizedBox(height:5),
//     TagList(),
//     SizedBox(height:20),
//     Expanded(
//       child: Container(
//                 // padding: EdgeInsets.all(16.0),
//                 width: double.infinity,
//                 child: GridView.builder(
//                   controller: _scrollController,
//                   itemCount: snap.data.length,
//                   physics: ClampingScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0,
//                   childAspectRatio: 2/3
//                   ),
//                   itemBuilder: (BuildContext context, int i){
//                    return InkWell(
//                    autofocus: false,
                   
//                      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => FullView(img: ImageModel(
//             imgUrl: snap.data[i].imgUrl,
//             title: snap.data[i].title,
//             author:snap.data[i].author,
//             id:snap.data[i].id,
//             category:snap.data[i].category,
//             downloads:snap.data[i].downloads,
//                      ))));},
//                      child: wallPapercardNew(imgUrl: snap.data[i].imgUrl,grad: grad1,title:snap.data[i].title ,context: context,id:snap.data[i].id ));
//                   },
//             )),
//     ),
      
//     //  Tags(grad: grad1,name: 'iron man'),
//     //      Tags(grad: grad1,name: 'iron man'),
//              ],)