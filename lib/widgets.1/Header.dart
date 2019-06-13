import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../pages/Search.dart';
import '../pages/WebView.dart';
// import '../pages/Animate.dart';
// import '../pages/Sliver.dart';
import '../configs/LS_icons.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goSearchPage() {
      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
        // return new SearchPage();
        return new WebViewPage();
        // return StaggeredAnimationReplication();
        // return new SliverPage();
      }));
    }

    return Container(
      // width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(10.0),
      // decoration: BoxDecoration(
      //   gradient: const LinearGradient(
      //     colors: [Color(0xffe64646), Color(0xFFe43130)]),
      // ),
      child: GestureDetector(
        onTap: _goSearchPage,
        child: Container(
          height: 34.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            // boxShadow:  [BoxShadow(color: Color(0x99999999), offset: Offset(5.0, 5.0), blurRadius: 10.0, spreadRadius: 2.0),],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  LS.search,
                  size: 20.0,
                  color: Color(0xffcccccc),
                ),
              ),
              Text(
                "搜索文章",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
