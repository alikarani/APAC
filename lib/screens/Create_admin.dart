import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Create_Admin extends StatefulWidget {
  @override
  _Create_AdminState createState() => _Create_AdminState();
}

class _Create_AdminState extends State<Create_Admin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  final _formkey = GlobalKey<FormState>();
  String id,
      email,
      password,
      f_name,
      l_name,
      ph,
      atype,
      cnic,
      card_no,
      user_rating;
  bool account_state = null;

  Future<void> showAlertMyDialog(String alert_text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alert_text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessMyDialog(String success_text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Successfull!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(success_text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  createData() async {
    if (atype == null || account_state == null) {
      showAlertMyDialog('You have to select Account State and Account type');
    } else {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();

        try {
          AuthResult reuslt = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          FirebaseUser user = reuslt.user;

          final CollectionReference user_info =
              Firestore.instance.collection('user_info');

          await user_info.document(user.uid).setData({
            'first_name': f_name,
            'last_name': l_name,
            'email': email,
            'phone_no': ph,
            'account_type': atype,
            'cnic_no': cnic,
            'creditcard_no': card_no,
            'user_rating': 5,
            'account_state': account_state,
          });

          setState(() {
            id = user.uid;

            print(user.uid);
            print(email);
          });
          showSuccessMyDialog('The Account is Successfully Created');
        } catch (e) {
          return null;
        }
      }
    }
  }

  readData() async {
    try {
      print(id);
      DocumentSnapshot snapshot =
          await db.collection('user_info').document(id).get();
      print(snapshot.data['email']);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(atype);
    print(account_state);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Center(child: Text('Create Administrators')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: SingleChildScrollView(
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
                    validator: (val) =>
                        val.isEmpty ? 'Enter an password' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter First Name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter First Name' : null,
                    onChanged: (val) {
                      setState(() => f_name = val);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Last Name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Last Name' : null,
                    onChanged: (val) {
                      setState(() => l_name = val);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Enter Phone Number' : null,
                    onChanged: (val) {
                      setState(() => ph = val);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter CNIC NO.',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter CNIC NO.' : null,
                    onChanged: (val) {
                      setState(() => cnic = val);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Credit Card No.',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? null : val,
                    onChanged: (val) {
                      setState(() => card_no = val);
                    },
                  ),
                  DropdownButton(
                      value: atype,
                      items: [
                        DropdownMenuItem(
                            child: Text("Select Admin Type"), value: null),
                        DropdownMenuItem(
                            child: Text("super-admin"), value: 'super-admin'),
                        DropdownMenuItem(
                            child: Text("news-portal-admin"),
                            value: 'news-portal-admin'),
                        DropdownMenuItem(
                            child: Text("news-letter-admin"),
                            value: 'news-letter-admin'),
                        DropdownMenuItem(
                            child: Text("thread-admin"), value: 'thread-admin'),
                        DropdownMenuItem(
                            child: Text("law-admin"), value: 'law-admin'),
                        DropdownMenuItem(
                            child: Text("awarness-admin"),
                            value: 'awarness-admin')
                      ],
                      onChanged: (value) {
                        setState(() {
                          atype = value;
                          print(value);
                        });
                      }),
                  DropdownButton(
                      value: account_state,
                      items: [
                        DropdownMenuItem(
                            child: Text("Select Account State"), value: null),
                        DropdownMenuItem(child: Text("false"), value: false),
                        DropdownMenuItem(child: Text("true"), value: true),
                      ],
                      onChanged: (value) {
                        setState(() {
                          account_state = value;
                          print(value);
                        });
                      }),
                  Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          RaisedButton(
                            child: Text('REGISTER'),
                            onPressed: createData,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                              child: Text('print Email'), onPressed: readData)
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
