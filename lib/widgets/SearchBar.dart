import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixiwall/shared/colors.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String search;
  TextEditingController _controller = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    search='';
    _controller.text = '';
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
              alignment: Alignment.center,
              width:double.infinity,
              margin:const EdgeInsets.symmetric(horizontal:30.0) ,
              padding: EdgeInsets.symmetric(horizontal:20.0,vertical:3.0),
            
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
