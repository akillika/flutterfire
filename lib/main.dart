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

  MyHomePage(this.name, this.age);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    Future<void> addUser() {
      return users
          .add({'name': name, 'age': age})
          .then((value) => print('Sucessfull'))
          .catchError((error) => print('Failed due to $error'));
    }

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: TextButton(
            onPressed: addUser,
            child: Text('Add User'),
          ),
        ),
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
