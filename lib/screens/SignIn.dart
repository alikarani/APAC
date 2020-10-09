import 'package:Behind_APAC/models/user.dart';
import 'package:Behind_APAC/providers/userProvider.dart';
import 'package:Behind_APAC/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  String id,
      email,
      password,
      f_name,
      l_name,
      ph,
      atype,
      cnic,
      card_no,
      user_rating,
      account_state,
      error = '';

  void _signInWithEmailAndPassword(_context) async {
    try {
      DocumentSnapshot snapshot;
      final user = (await _auth.signInWithEmailAndPassword(
              email: 'lumber1@gmail.com', password: '123456'))
          .user;

      snapshot = await db.collection('user_info').document(user.uid).get();

      UserData userInfo = UserData(
          uid: user.uid,
          email: snapshot.data['email'],
          f_name: snapshot.data['first_name'],
          l_name: snapshot.data['last_name'],
          ph: snapshot.data['phone_no'],
          atype: snapshot.data['account_type'],
          cnic: snapshot.data['cnic_no'],
          card_no: snapshot.data['cnic_no'],
          user_rating: snapshot.data['user_rating'],
          account_state: snapshot.data['account_state']);
      Provider.of<UserProvider>(context, listen: false).setUserData(userInfo);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ),
          ModalRoute.withName('/Home'));
    } catch (e) {
      print("Failed to sign in with Email & Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2.0),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2.0),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an password' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        RaisedButton(
                          child: Text('Sign In'),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              _signInWithEmailAndPassword(context);
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
                SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
