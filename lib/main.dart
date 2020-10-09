import 'package:Behind_APAC/providers/userProvider.dart';
import 'package:Behind_APAC/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(ApacApp());

class ApacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.initialize()),
      ],
      child: MaterialApp(
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      imageBackground: AssetImage("assets/bg.jpg"),
      seconds: 1,
      navigateAfterSeconds: new SignIn(),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.redAccent,
    );
  }
}