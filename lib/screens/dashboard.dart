import 'package:Behind_APAC/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getUser();
  //   });
  // }

  // void getUser() {
  //   UserProvider _user = Provider.of<UserProvider>(context, listen: false);
  //   print(_user.userData.ph);
  // }

  @override
  Widget build(BuildContext context) {
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'APAC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(70)),
              Text('Welcome \n' + _user.userData?.ph),
              Text('Dashboard'),
            ],
          ),
        ),
      ),
    );
  }
}
