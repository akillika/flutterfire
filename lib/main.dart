import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyHomePage('akil', '20'));
}

class MyHomePage extends StatelessWidget {
  final String name;
  final String age;
  int counter = 0;

  MyHomePage(this.name, this.age);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("akil");
    FirebaseFirestore.instance
        .collection('akil')
        .where('age', isGreaterThan: 30)
        .get()
        .then((value) => print('hell0'));
    // FirebaseFirestore.instance
    //     .collection('new user')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) => {
    //           querySnapshot.docs.forEach((doc) {
    //             print(doc["name"]);
    //           })
    //         });
    Future<void> addUser() {
      return users
          .doc('yes $counter')
          .set({'name': 'changed name', 'age': age})
          .then((value) => print('Sucessfull'))
          .catchError((error) => print('Failed due to $error'));
    }

    Future<void> deleteUser() {
      return users.doc('yes $counter').delete();
    }

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
            child: Column(
          children: [
            TextButton(
                onPressed: () {
                  addUser();
                  counter = counter + 1;
                },
                child: Text('adduser')),
            TextButton(
                onPressed: () {
                  deleteUser();
                  counter = counter - 1;
                },
                child: Text('deleteUser')),
            StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: new Text(document.data()['name']),
                      subtitle: new Text(document.data()['age']),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
// class MyHomePage extends StatelessWidget {
//   final String name;
//   final String age;
//
//   MyHomePage(this.name, this.age);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('myusers');
//
//     Future<void> adduser() {
//       return users
//           .add({
//             'fullName': name,
//             'age': age,
//           })
//           .then((value) => print('User added Sucessfully'))
//           .catchError((error) => print('Falied to add user: $error'));
//     }
//
//     return TextButton(onPressed: adduser, child: Text('Add User'));
//   }
// }
