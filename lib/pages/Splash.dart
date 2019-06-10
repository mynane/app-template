import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './Home.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new MyHomePage(),
      title: new Text('Welcome In SplashScreen',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}

// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//       title: new Text("Welcome In SplashScreen Package"),
//       automaticallyImplyLeading: false
//       ),
//       body: new Center(
//         child: new Text("Done!",
//         style: new TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 30.0
//         ),),

//       ),
//     );
//   }
// }