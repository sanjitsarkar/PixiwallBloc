// import 'package:firebase_admob/firebase_admob.dart';
import '../services/AdService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/bloc/auth_bloc.dart';
import 'package:pixiwall/bloc/category_bloc.dart';
// import 'package:pixiwall/bloc/favourite_bloc.dart';
import 'package:pixiwall/bloc/wallpaper_bloc.dart';
import 'package:pixiwall/model/CategoryModel.dart';
import 'package:pixiwall/model/ImageModel.dart';
// import 'package:pixiwall/model/User.dart';
import 'package:pixiwall/screens/FullView.dart';
import 'package:pixiwall/screens/SearchScreen.dart';
import 'package:pixiwall/services/UserDBProvider.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
import 'package:pixiwall/widgets/CategoryCard.dart';
import 'package:pixiwall/widgets/CustomList.dart';
import 'package:pixiwall/widgets/HorzLine.dart';
import 'package:pixiwall/widgets/TitleBar.dart';
import 'package:pixiwall/widgets/WallPaperCard.dart';

class Home extends StatefulWidget {
  // User user;
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int limit;
  UserDBProvider db = UserDBProvider();
  bool isOpen;
  // static const platform = const MethodChannel('com.pixi.pixiwall/info');
  String search;
  final _scrollController = ScrollController();
  final _scrollController1 = ScrollController();
  TextEditingController _controller;
  var _currentIndex;

  List<CategoryModel> list;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState

    //  Future<List<ImageModel>> list = ImageService().search('Iron man');
    isOpen = false;
    search = 'Iron Man';
    _controller = TextEditingController();
    _currentIndex = 1;
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    Ads.initialize();
    Ads.showBannerAd();
    Ads.hideBannerAd();

    // db.open();
    // db.inW
    //  list = [];
    // print('hello');
    // getData();
//  print(list);
//     _getMsg().then((String message)
//     {
// print(message);
//     });
  }

  //  Future<String> _getMsg()
  // async{
  //   String val;
  //   try{
  //   val = await platform.invokeMethod('getMsg');
  //   }
  //   catch(e)
  //   {
  //     print(e);
  //   }
  //   return val;

  // }
//  getData()
// async{
// List<CategoryModel> list1 =  await WallpaperCategoryRepo().getCatgory(limit: 5);
// setState(() {
//   list = list1;
// });

// }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case 0:
          Navigator.pushNamed(context, '/category',
              arguments: {'type': 'Trending'});
          break;
        case 1:
// Navigator.pushNamed(context, '/');
          break;
        case 2:
          Navigator.pushNamed(context, '/fav',
              arguments: {'type': 'Favourite'});
          break;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    Ads.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    // final images = Provider.of<List<ImageModel>>(context)??[];
    // final categories = Provider.of<List<CategoryModel>>(context)??[];
    // list.forEach((f)
    // {
    //   print(f.title);
    // });
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthUser) {
            // print(state.user.uid);

            return Scaffold(
                backgroundColor: Primary,
                appBar: AppBar(
                  title: !isOpen
                      ? Text('PIXIWALL')
                      : TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _controller,
                          autofocus: !isOpen ? false : true,
                          style: GoogleFonts.montserrat(color: Colors.white),
                          onSubmitted: (e) {
                            if (e.isNotEmpty || e == ' ') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                            src: e,
                                          )));
                              _controller.clear();
                              setState(() {
                                isOpen = false;
                              });
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Please Enter Something',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                backgroundColor: red2,
                                elevation: 8,
                              ));
                            }
                          },
                          onChanged: (e) {
                            search = e;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white.withOpacity(.8),
                              ),
                              border: InputBorder.none,
                              filled: false,
                              // fillColor: Colors.white,

                              hintText: "Search WallPapers",
                              hintStyle: GoogleFonts.montserrat(
                                  color: Colors.white.withOpacity(.5))),
                        ),
                  centerTitle: true,
                  elevation: 7,
                  actions: <Widget>[
                    IconButton(
                        icon: !isOpen
                            ? Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScren()));
                          setState(() {
                            isOpen = !isOpen;
                          });
                        }),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: grad2,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                  backgroundColor: Secondary,
                  // bottom: TabBar(
                  //   controller: tabController,
                  //   indicatorWeight: 2.0,
                  //   labelStyle:
                  //       GoogleFonts.roboto(color: Colors.white.withOpacity(.8)),
                  //   unselectedLabelStyle: GoogleFonts.roboto(color: Colors.white),
                  //   indicatorColor: Colors.white,
                  //   onTap: (i) {
                  //     if (i == 0) {
                  //       Navigator.pushNamed(context, '/category',
                  //           arguments: {'type': 'Trending'});
                  //       tabController.index = 1;
                  //     } else if (i == 2) {
                  //       Navigator.pushNamed(context, '/category',
                  //           arguments: {'type': 'Favourite'});
                  //       tabController.index = 1;
                  //     } else if (i == 1 && tabController.index != 1) {
                  //       Navigator.pushNamed(
                  //         context,
                  //         '/',
                  //       );
                  //     }
                  //   },
                  //   tabs: <Widget>[
                  //     Tab(
                  //       icon: FaIcon(FontAwesomeIcons.fire, color: Colors.white),
                  //       text: "Trending",
                  //     ),
                  //     Tab(
                  //         icon: Icon(
                  //           Icons.home,
                  //           color: Colors.white,
                  //           size: 30,
                  //         ),
                  //         text: "Home"),
                  //     Tab(
                  //         icon:
                  //             FaIcon(FontAwesomeIcons.heart, color: Colors.white),
                  //         text: "Favourite"),
                  //     Tab(
                  //         icon:
                  //             FaIcon(FontAwesomeIcons.crown, color: Colors.white),
                  //         text: "Premium"),
                  //   ],
                  // ),
                ),
                drawer: Drawer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Accent,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ListView(
                          children: <Widget>[
                            DrawerHeader(
                                decoration: BoxDecoration(
                                  gradient: grad2,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 63,
                                          height: 63,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              color: Colors.white),
                                        ),
                                        if (state.user != null)
                                          Container(
                                              width: 63,
                                              height: 63,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${state.user.displayPic}'),
                                                      fit: BoxFit.cover))),
                                        if (state.user == null)
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              },
                                              child: Text('LOGIN'))
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    if (state.user != null)
                                      Text(
                                        '${state.user.username}',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    if (state.user != null)
                                      Text('${state.user.email}',
                                          style: GoogleFonts.montserrat(
                                              color:
                                                  Colors.white.withOpacity(.58),
                                              fontSize: 15)),
                                  ],
                                )),
                            customList(
                                title: 'Downloaded Wallpapers',
                                iconData: Icons.file_download,
                                context: context,
                                route: '/downloaded'),
                            if (state.user != null)
                              customList(
                                  title: 'Notifications',
                                  iconData: Icons.notifications),
                            if (state.user != null)
                              customList(
                                  title: 'Premium Wallpapers',
                                  iconData: Icons.wallpaper),
                            if (state.user != null)
                              customList(
                                  title: 'Order Custom Wallpapers',
                                  iconData: Icons.add_shopping_cart),
                            customList(
                                title: 'Rate Our App',
                                iconData: Icons.star_border),
                            customList(title: 'Share', iconData: Icons.share),
                            customList(title: 'About Us', iconData: Icons.info),
                          ],
                        ),
                        if (state.user != null)
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                alignment: Alignment.center,
                                height: h(context) / 12,
                                width: w(context),
                                decoration: BoxDecoration(color: Colors.white),
                                child: FlatButton(
                                  //  color: Colors.white,
                                  onPressed: () async {
                                    context.bloc<AuthBloc>().add(LogOut());
                                    // Navigator.popAndPushNamed(context, "/home");
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'Logout',
                                      style: GoogleFonts.roboto(
                                        color: Primary,
                                      ),
                                    ),
                                    leading:
                                        Icon(Icons.exit_to_app, color: Primary),
                                  ),
                                ),
                              )),
                      ],
                    ),
                  ),
                ),
                body:
                    //     child: MultiBlocListener(
                    //          listeners: [
                    //   BlocListener<CategoryBloc, CategoryState>(
                    //     listener: (context, state) {

                    //     },
                    //   ),
                    //   BlocListener<WallpaperBloc, WallpaperState>(
                    //     listener: (context, state) {},
                    //   ),

                    // ],

                    RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      context.bloc<CategoryBloc>().add(RefreshCategories());
                      context
                          .bloc<WallpaperBloc>()
                          .add(RefreshWallpapers(limit: 4, sort: 'Recent'));
                    });
                  },
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                          padding: content,
                          //  height: h(context)/4,
                          width: double.infinity,
                          child: Column(children: <Widget>[
                            titleBar(
                              title: 'CATEGORIES',
                            ),
                            SizedBox(height: 25),
                            Container(
                              height: 80,
                              width: double.infinity,
                              child: BlocListener<CategoryBloc, CategoryState>(
                                  listener: (context, state) {},
                                  child:
                                      BlocConsumer<CategoryBloc, CategoryState>(
                                          listener: (context, state) {
                                    // do stuff here based on BlocA's state
                                  }, builder: (context, state) {
                                    return Category(state);
                                    // return widget here based on BlocA's state
                                  })),
                            ),
                          ])),
                      SizedBox(height: 20),
                      line(height: 2.0, color: Secondary),
                      WallpaperSect(
                        title: 'Recent',
                      ),
                      line(color: Secondary, height: 2.0),

//  BlocListener<WallpaperBloc, WallpaperState>(
//       listener: (context, state) {},
//       child:
// BlocConsumer<WallpaperBloc, WallpaperState>(
//   listener: (context, state) {
//       // do stuff here based on BlocA's state
//   },
//   builder: (context, state) {
//       return  WallPaperSect(title: 'FEATURED UPLOADS',state: state,context: context,);
//       // return widget here based on BlocA's state
//   }
// )),
                    ],
                  ),
                ),

                // )

                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Secondary,

                  type: BottomNavigationBarType.fixed,

                  elevation: 4,
                  onTap: onTabTapped, // new
                  currentIndex: _currentIndex,

                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.fire, color: Colors.white),
                      title: Text('Trending',
                          style: GoogleFonts.roboto(color: Colors.white)),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Home',
                          style: GoogleFonts.roboto(color: Colors.white),
                        )),

                    // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list,color: Colors.white), title: Text('Category',style: TextStyle(color:Colors.white))),

                    BottomNavigationBarItem(
                        icon:
                            FaIcon(FontAwesomeIcons.heart, color: Colors.white),
                        title: Text('Favourite',
                            style: GoogleFonts.roboto(color: Colors.white))),
                    BottomNavigationBarItem(
                        icon:
                            FaIcon(FontAwesomeIcons.crown, color: Colors.white),
                        title: Text('Premium',
                            style: GoogleFonts.roboto(color: Colors.white))),
                  ],
                ));
          } else {
            return Container();
          }
        }));
  }

  Category(CategoryState state) {
    if (state is CategoryLoading) {
      return Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      );
    } else if (state is CategoryLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            context.bloc<CategoryBloc>().add(RefreshCategories());
          });
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _onScrollNotification(notification, state),
          child: Container(
            height: h(context) / 6,
            width: w(context),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              //  padding: EdgeInsets.symmetric(horizontal:10),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,

              shrinkWrap: false,

              itemCount: state.category.length,

              itemBuilder: (context, i) {
                return categoryCard(
                    grad: grad1,
                    imgUrl: state.category[i].imgUrl,
                    title: state.category[i].title,
                    context: context);
              },
            ),
          ),
        ),
      );
    } else if (state is CategoryError) {
      return (Center(
        child: Text(
          'Error Loading Categories',
          style: style1,
        ),
      ));
    } else {
      return Container();
    }
  }

  bool _onScrollNotification(ScrollNotification notif, CategoryLoaded state) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context
          .bloc<CategoryBloc>()
          .add(LoadMoreCategories(category: state.category));
    }
    return false;
  }

  bool _onScrollNotificationTag(
      ScrollNotification notif, CategoryLoaded state) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context
          .bloc<CategoryBloc>()
          .add(LoadMoreCategories(category: state.category));
    }
    return false;
  }

//Wallpaper Section

}

class WallpaperSect extends StatefulWidget {
  final String title;

  WallpaperSect({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _WallpaperSectState createState() => _WallpaperSectState();
}

class _WallpaperSectState extends State<WallpaperSect> {
  ScrollController _scrollController1 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
        builder: (context, state) {
      bool _onScrollNotificationWallpaper(
          ScrollNotification notif, WallpaperLoaded state) {
        if (notif is ScrollEndNotification &&
            _scrollController1.position.extentAfter == 0) {
          context.bloc<WallpaperBloc>().add(LoadMoreWallpapers(
              wallpapers: state.wallpapers, limit: 2, sort: 'Recent'));
        }
        return false;
      }

      if (state is WallpaperLoading) {
        return Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 50.0,
          ),
        );
      } else if (state is WallpaperLoaded) {
        print('Title ${widget.title}');
        return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                // context.bloc<CategoryBloc>().add(RefreshCategories());
              });
            },
            child: NotificationListener<ScrollNotification>(
                onNotification: (notification) =>
                    _onScrollNotificationWallpaper(notification, state),
                child: Container(
                    width: double.infinity,
                    padding: content,
                    child: Column(children: <Widget>[
                      titleBar(
                          title: '${widget.title} Wallpapers',
                          type: 'Recent',
                          context: context),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: h(context) / 2.7,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.wallpapers.length,
                          controller: _scrollController1,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, i) {
                            Gradient grad;
                            if (i % 2 == 0) {
                              grad = grad2;
                            } else {
                              grad = grad3;
                            }
                            return GestureDetector(
                                //  autofocus: false,

                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullView(
                                              img: ImageModel(
                                                  imgUrl: state
                                                      .wallpapers[i].imgUrl,
                                                  title:
                                                      state.wallpapers[i].title,
                                                  author: state
                                                      .wallpapers[i].author,
                                                  id: state.wallpapers[i].id,
                                                  downloads: state
                                                      .wallpapers[i].downloads,
                                                  fav: state.wallpapers[i].fav,
                                                  shares: state
                                                      .wallpapers[i].shares,
                                                  isPremium: state
                                                      .wallpapers[i].isPremium,
                                                  pixipoints: state
                                                      .wallpapers[i].pixipoints,
                                                  category: state.wallpapers[i]
                                                      .category))));
                                },
                                child: wallPapercard(
                                    imgUrl: state.wallpapers[i].imgUrl,
                                    grad: grad,
                                    title: state.wallpapers[i].title,
                                    context: context,
                                    id: state.wallpapers[i].id));
                          },
                        ),
                      ),
                    ]))));
      } else if (state is WallpaperError) {
        return (Center(
          child: Text(
            'Error Loading Wallpapers',
            style: style1,
          ),
        ));

        // return Container(
        //   width: double.infinity,
        //   padding: content,
        //   child: Column(

        //     children: <Widget>[
        //       titleBar(title: '$title',type:'Recent',context: context),
        //       SizedBox(height:30),
        //       Container(

        //         width: double.infinity,
        //         height:h(context)/2.7,
        //         child:

        //         ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           shrinkWrap: true,
        //          itemCount: images.length,
        //          itemBuilder: (context,i)
        //          {
        //        return InkWell(
        //          autofocus: false,

        //            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => FullView(img: ImageModel(
        //              imgUrl: images[i].imgUrl,
        //              title: images[i].title,
        //              author:images[i].author,
        //              id:images[i].id,
        //              downloads:images[i].downloads,
        //              fav: images[i].fav,
        //              shares: images[i].shares,

        //              category:images[i].category
        //            ))));},
        //            child: wallPapercard(imgUrl: images[i].imgUrl,grad: grad1,title:images[i].title ,context: context,id:images[i].id ));
        //           },),

        //       ),

        //     ],
        //   ),
        // );

      } else {
        return Container();
      }
    });
  }
}
