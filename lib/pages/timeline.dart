import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermedia/widgets/progress.dart';
import '../widgets/header.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    // getUserById();
    // createUser();
    // updateUser();
    deleteUser();
    super.initState();
  }

  createUser() {
    usersRef
        .doc("asdfasfd")
        .set({"username": "Jeff", "postsCount": 0, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.doc("asdfasfd").get();
    if (doc.exists) {
      doc.reference
          .update({"username": "John", "postsCount": 0, "isAdmin": false});
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await usersRef.doc("asdfasfd").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }
  // getUserById() async {
  //   final String id = "mj5wpBwHBeAtXajQVdYm";
  //   final DocumentSnapshot doc = await usersRef.doc(id).get();
  //   print(doc.data());
  //   print(doc.id);
  //   print(doc.exists);
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children =
              snapshot.data.docs.map((doc) => Text(doc['username'])).toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
      // body: Container(
      //   child: ListView(
      //       children: users.map((user) => Text(user['username'])).toList()),
      // ),
    );
  }
}
