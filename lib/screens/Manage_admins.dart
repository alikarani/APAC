import 'package:Behind_APAC/screens/Create_admin.dart';
import 'package:Behind_APAC/screens/Edit_Admin_Account.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Admin_Manager extends StatefulWidget {
  @override
  _Admin_ManagerState createState() => _Admin_ManagerState();
}

class _Admin_ManagerState extends State<Admin_Manager> {
  String id;
  String name;
  final db = Firestore.instance;
  final _formkey = GlobalKey<FormState>();
  //CollectionReference users = Firestore.instance.collection('bandnames');

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter name';
        }
      },
      onSaved: (newValue) {
        name = newValue;
      },
    );
  }

  createData() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      DocumentReference ref =
          await db.collection('CRUD').add({'name': '$name ⭐'});
      setState(() {
        id = ref.documentID;
        print(ref.documentID);
      });
    }
  }

  readData() async {
    DocumentSnapshot snapshot =
        await db.collection('user_info').document(id).get();
    print(snapshot.data['first_name']);
  }

  updateData(DocumentSnapshot doc) async {
    _formkey.currentState.save();
    await db
        .collection('user_info')
        .document(doc.documentID)
        .updateData({'first_name': '$name'});
  }

  deleteData(DocumentSnapshot doc, bool state) async {
    await db
        .collection('user_info')
        .document(doc.documentID)
        .updateData({'account_state': state});

    print('toggeled state to : $state');
  }

  // deleteData(DocumentSnapshot doc) async {
  //   await db.collection('CRUD').document(doc.documentID).delete();
  //   setState(() {
  //     id = null;
  //   });
  // }

  Card buildItem(DocumentSnapshot doc) {
    if (doc.data['account_state'] == false) {
      return Card(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${doc.data['first_name']} ${doc.data['last_name']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Designation: ${doc.data['account_type']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      //print(doc.documentID.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Admin(doc)),
                      );
                    },
                    child: Text(
                      'Edit Account Type',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (doc.data['account_state'] == true) {
                        deleteData(doc, false);
                      } else {
                        deleteData(doc, true);
                      }
                    },
                    child: Text(
                      doc.data['account_state'] ? 'Deactivate' : 'Activate',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${doc.data['first_name']} ${doc.data['last_name']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Designation: ${doc.data['account_type']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  FlatButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Edit_Admin(doc)),
                    ),
                    child: Text(
                      'Edit Account Type',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (doc.data['account_state'] == true) {
                        deleteData(doc, false);
                      } else {
                        deleteData(doc, true);
                      }
                    },
                    child: Text(
                      doc.data['account_state'] ? 'Deactivate' : 'Activate',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Center(child: Text('Adminstrator Manager')),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Form(
              key: _formkey,
              child: buildTextFormField(),
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Create_Admin()),
                    );
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.green,
                ),
                RaisedButton(
                  onPressed: id != null ? readData : null,
                  child: Text(
                    'Read',
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              //for all values in collection
              // stream: db.collection('user_info').snapshots(),

              //for single type value in collection
              // stream: db
              //     .collection('user_info')
              //     .where("account_type", isEqualTo: "super-admin")
              //     .snapshots(),

              // for searching multiple values in collection
              stream:
                  db.collection('user_info').where("account_type", whereIn: [
                "super-admin",
                "news-portal-admin",
                "news-letter-admin",
                "thread-admin",
                "law-admin",
                "awarness-admin"
              ]).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      children: snapshot.data.documents
                          .map((doc) => buildItem(doc))
                          .toList());
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class Crude_stuff extends StatefulWidget {
//   @override
//   _Crude_stuffState createState() => _Crude_stuffState();
// }

// class _Crude_stuffState extends State<Crude_stuff> {
//   String id;
//   final db = FirebaseFirestore.instance;

//   String name, number, cnic;
//   void creatData() async {
//     if (_formkey.currentState.validate()) {
//       _formkey.currentState.save();

//       // DocumentReference ref =
//       //     await db.collection('CRUD').add({'name': '$name ⭐'});
//     }
//   }

//   void readDate() async {
//     if (_formkey.currentState.validate()) {
//       _formkey.currentState.save();
//       // DocumentReference ref = await db.collection('')
//     }
//   }

//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.red[900],
//           title: Center(child: Text('I Am Poor')),
//         ),
//         body: Center(
//             child: Column(
//           children: [
//             SizedBox(
//               height: 200,
//             ),
//             Form(
//               key: _formkey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(
//                         hintText: 'Enter Name', fillColor: Colors.white),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Mother fucker enter the name ';
//                       } else {
//                         return null;
//                       }
//                     },
//                     onSaved: (value) => name = value,
//                   ),
//                   RaisedButton(
//                     onPressed: () {
//                       if (_formkey.currentState.validate()) {
//                         print(name);
//                         creatData();
//                       }
//                     },
//                   ),
//                   RaisedButton(
//                     onPressed: () {
//                       if (_formkey.currentState.validate()) {
//                         print(name);
//                         if (id != null) {
//                           readDate();
//                         }
//                       }
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
