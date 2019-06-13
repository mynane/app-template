// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

// import '../utils/AdPicture.dart';

// const timeout = const Duration(seconds: 2);

// class AnimatePage extends StatefulWidget {
//   AnimatePage({Key key}) : super(key: key);

//   _AnimatePageState createState() => _AnimatePageState();
// }

// class _AnimatePageState extends State<AnimatePage> with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   PageController _pageController = PageController();
//   Timer _timer;

//   List _adPictures = [];
//   int _index = 0;

//   @override
//   void initState() {
//     _tabController = TabController(length: 0, vsync: this);
//     _timer = Timer.periodic(timeout, _handleTimeout);
//     loadAdPictures();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("data"),
//       ),
//       body: Stack(
//         children: <Widget>[
//           PageView(
//             children: _adPictures.map((json) {
//               var adPicture = AdPicture.fromJson(json);
//               // return Image.network(adPicture.imageUrl, fit: BoxFit.contain);
//               return Container(
//                 child: Text("data123123${adPicture.imageUrl}"),
//               );
//             }).toList(),
//             onPageChanged: _onPageChanged,
//             controller: _pageController,
//           ),
//           Align(
//             alignment: Alignment(0.0, 0.5),
//             child: TabPageSelector(
//               color: Colors.white,
//               selectedColor: Colors.grey,
//               controller: _tabController,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _handleTimeout(Timer timer) {
//     if (_adPictures.length - 2 != 0) {
//       _index++;
//       _pageController.animateToPage(
//         _index % (_adPictures.length - 2),
//         duration: Duration(milliseconds: 16),
//         curve: Curves.fastOutSlowIn,
//       );
//     }
//   }

//   void _onPageChanged(int index) {
//     _index = index;
//     if (index == 0) {
//       _tabController.animateTo(_tabController.length - 1);
//       _pageController.jumpToPage(_adPictures.length - 2);
//     } else if (index == _adPictures.length - 1) {
//       _tabController.animateTo(0);
//       _pageController.jumpToPage(1);
//     } else {
//       _tabController.animateTo(index - 1);
//     }
//   }

//   void loadAdPictures() async {
//     Dio dio = Dio();
//     Response<List> response = await dio
//         .get("http://www.wanandroid.com/tools/mockapi/2511/getAdPictures");

//     List res = response.data;
//     if (res.length != 0) {
//       res.insert(0, res[res.length - 1]);
//       res.add(res[1]);

//       setState(() {
//         _adPictures = res;
//         _pageController.jumpToPage(1);
//         _tabController =
//             TabController(length: _adPictures.length - 2, vsync: this);
//       });
//     }
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class StaggeredAnimationReplication extends StatefulWidget {
  StaggeredAnimationReplication({Key key}) : super(key: key);
  @override
  _StaggeredAnimationReplicationState createState() => new _StaggeredAnimationReplicationState();
}

class _StaggeredAnimationReplicationState extends State<StaggeredAnimationReplication> with SingleTickerProviderStateMixin{

  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this);

    sequenceAnimation = new SequenceAnimationBuilder()
     .addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from: Duration.zero,
        to: const Duration(milliseconds: 200),
        curve: Curves.ease,
        tag: "opacity"
    ).addAnimatable(
        animatable: new Tween<double>(begin: 10.0, end: 50.0),
        from: const Duration(milliseconds: 250),
        to: const Duration(milliseconds: 500),
        curve: Curves.ease,
        tag: "width"
    ).addAnimatable(
        animatable: new Tween<double>(begin: 10.0, end: 50.0),
        from: const Duration(milliseconds: 500),
        to: const Duration(milliseconds: 750),
        curve: Curves.ease,
        tag: "height"
    ).addAnimatable(
        animatable: new EdgeInsetsTween(begin: const EdgeInsets.only(left: 16.0), end: const EdgeInsets.only(left: 75.0),),
        from: const Duration(milliseconds: 500),
        to: const Duration(milliseconds: 750),
        curve: Curves.ease,
        tag: "padding"
    ).addAnimatable(
      animatable: new Tween<double>(begin: 0, end: pi * 2),
      from: const Duration(milliseconds: 0),
      to: const Duration(milliseconds: 1500),
      curve: Curves.ease,
      tag: "rotate",
    ).addAnimatable(
        animatable: new BorderRadiusTween(begin: new BorderRadius.circular(4.0), end: new BorderRadius.circular(75.0),),
        from: const Duration(milliseconds: 750),
        to: const Duration(milliseconds: 1000),
        curve: Curves.ease,
        tag: "borderRadius"
    ).addAnimatable(
        animatable: new ColorTween(begin: Colors.indigo[100], end: Colors.orange[400],),
        from: const Duration(milliseconds: 1000),
        to: const Duration(milliseconds: 1500),
        curve: Curves.ease,
        tag: "color"
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return RotatedBox(
      quarterTurns: sequenceAnimation["rotate"].value,
      child: new Container(
        padding: sequenceAnimation["padding"].value,
        alignment: Alignment.centerLeft,
        child: new Opacity(
          opacity: sequenceAnimation["opacity"].value,
          child: new Container(
            width: sequenceAnimation["width"].value,
            height: sequenceAnimation["height"].value,
            decoration: new BoxDecoration(
              color: sequenceAnimation["color"].value,
              border: new Border.all(
                color: Colors.indigo[300],
                width: 3.0,
              ),
              borderRadius: sequenceAnimation["borderRadius"].value,
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Staggered Animation"),
      ),
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: new Center(
          child: new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: new Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: new AnimatedBuilder(
                animation: controller,
                builder: _buildAnimation
            ),
          ),
        ),
      ),
    );
  }
}

