import 'package:Behind_APAC/providers/userProvider.dart';
import 'package:Behind_APAC/screens/Manage_admins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SignIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // sign out
  Future signOut() async {
    try {
      Provider.of<UserProvider>(context, listen: false).setUserData(null);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignIn(),
          ),
          ModalRoute.withName('/SignIn'));
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    if (_user.userData.atype == 'super-admin') {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Row(
                children: [
                  Text(
                    'APAC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 210,
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label:
                        Text('logout', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      signOut();
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.redAccent,
          ),
          body: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(40)),
                RaisedButton(
                    child: Text(
                      'Manage Administrators',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Admin_Manager()),
                      );
                    }),

                RaisedButton(
                    child: Text(
                      'Manage Users',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),

                RaisedButton(
                    child: Text(
                      'Manage News Portal',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),

                RaisedButton(
                    child: Text(
                      'Manage Treads',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),

                RaisedButton(
                    child: Text(
                      'Manage Laws',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),

                RaisedButton(
                    child: Text(
                      'Manage Public Awarness',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),

                // Padding(padding: EdgeInsets.all(70)),
                // Text('Welcome \n' + _user.userData?.f_name),
                // Text('Dashboard'),
              ],
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
        home: Container(
          color: Colors.yellow,
          child: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(40)),
                Text('You no Super Admin'),
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: Text('logout', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
