import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/model/ImageModel.dart';
import 'package:pixiwall/screens/FullScreenDownloaded.dart';
import 'package:pixiwall/screens/FullView.dart';
import 'package:pixiwall/services/ImageService.dart';
// import 'package:pixiwall/services/snap.dataervice.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';
import 'package:pixiwall/widgets/SearchBar.dart';
import 'package:pixiwall/widgets/WallPaperCard.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class DownloadedWallpaperScreen extends StatefulWidget {
  DownloadedWallpaperScreen({Key key}) : super(key: key);

  @override
  _DownloadedWallpaperScreenState createState() => _DownloadedWallpaperScreenState();
}

class _DownloadedWallpaperScreenState extends State<DownloadedWallpaperScreen> {
  ScrollController _scrollController;

  int limit,initial,i;
  String directory;
List<FileSystemEntity> file = new List();
List<FileSystemEntity> fileFrag = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
initial=0;
limit=6;
    _listofFiles();
    showFiles();
    _scrollController = ScrollController();
     _scrollController.addListener(_scrollListener);
    print(file);
  }

void showFiles()
{
  for( i=initial;i>initial+limit;i++)
  {
    setState(() {
    fileFrag.add(file[i]);  
    });

  }
}
_scrollListener() {
    print(_scrollController.position.pixels);
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        limit += 2;
         showFiles();
      });
    
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print('top');
      });
    }
  }
 void _listofFiles() async {
        
        setState(() {
          file = io.Directory('/storage/emulated/0/Pixiwall/Wallpapers/').listSync();  //use your folder name insted of resume.
        });
      }
      @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final Map args = ModalRoute.of(context).settings.arguments as Map;
// final snap.data = Provider.of<List<ImageModel>>(context)??[];
    return Scaffold(
        backgroundColor: Primary,
        appBar: AppBar(
                    backgroundColor: Primary,
                    elevation: 0,
                    
                    
                    title: Text(
                      'Downloaded Wallpapers',
                      style: style6,
                    ),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.list,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.popAndPushNamed(context,"/");
                        }),
                  ),
        body: Builder(
            builder: (context) => 
                  
                  file.length!=0?GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                  controller: _scrollController,
                  itemCount: file.length,
                  itemBuilder: (context,i)
                  {

                        return InkWell(
                             onTap: ()
                             {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreenDownloaded(path: file[i],)));
                             },
                             child: Hero(
                               tag: file[i],
                               child: Image.file(file[i],fit: BoxFit.cover,width: w(context)/3,height: h(context),)));
                  }):Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Text('No Downloaded Wallpaper Available',style:style1),
                    ),)
                ));
  }
}
