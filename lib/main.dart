import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/bloc/category_bloc.dart';
import 'package:pixiwall/bloc/tag_bloc.dart';
import 'package:pixiwall/model/CategoryModel.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/repositories/AuthRepo.dart';
import 'package:pixiwall/repositories/TagsRepo.dart';
import 'package:pixiwall/repositories/WallpaperCategoryRepo.dart';
import 'package:pixiwall/repositories/WallpaperRepo.dart';
import 'package:pixiwall/screens/CategoryScreen.dart';
import 'package:pixiwall/screens/CategoryTypeScreen.dart';
import 'package:pixiwall/screens/DownloadedWallpaper.dart';
import 'package:pixiwall/screens/FavouriteScreen.dart';
import 'package:pixiwall/screens/FullView.dart';
import 'package:pixiwall/screens/Home.dart';
import 'package:pixiwall/screens/LoginScreen.dart';
import 'package:pixiwall/screens/SearchScreen.dart';
// import 'package:pixiwall/screens/TrendingScreen.dart';
import 'package:pixiwall/services/UserDBProvider.dart';
import 'package:pixiwall/widgets/Category.dart';
import 'package:pixiwall/widgets/CategoryCard.dart';
import 'package:pixiwall/widgets/CustomList.dart';
import 'package:pixiwall/widgets/HorzLine.dart';
import 'package:pixiwall/widgets/Tags.dart';
import 'package:pixiwall/widgets/TitleBar.dart';
import 'package:pixiwall/widgets/WallPaperCard.dart';
import 'package:pixiwall/widgets/WallpaperSect.dart';

import './shared/colors.dart';
import './shared/consts.dart';
import './services/ImageService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/wallpaper_bloc.dart';
import 'repositories/wallpaper_respository.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CategoryBloc>(
              create: (_) => CategoryBloc(
                    categoryRepo: WallpaperCategoryRepo(),
                  )..add(AppStarted())),
          BlocProvider<WallpaperBloc>(
              create: (_) => WallpaperBloc(
                    wallpaperRepo: WallpaperRepo(),
                  )..add(AppStarted1(sort: 'Recent', limit: 4))),
          BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(authRepo: AuthRepo())
                ..add(IsLoggedIn())
                ..add(GetUser()))
        ],
        child: MaterialApp(
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/home': (context) => Home(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/category': (context) => CategoryScreen(),
            '/categoryType': (context) => CategoryTypeScreen(),
            '/downloaded': (context) => DownloadedWallpaperScreen(),
            '/fav': (context) => FavouriteScreen(),
            '/login': (context) => LoginScreen(),
          },
          debugShowCheckedModeBanner: false,
          home: Home(),
          theme: ThemeData(),
          color: Secondary,
        ));
  }
}
