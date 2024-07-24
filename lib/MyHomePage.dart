import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'phone number'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'password number'),
            ),
            ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: const Text('signin'),
            ),
            ElevatedButton(
              onPressed: () {
                loginCheckUser();
              },
              child: const Text('login'),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: nameController.text, password: passwordController.text,);
      print("success");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void logIn(User user) async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userData.exists) {
      // User data exists, proceed with your logic
      print('User data: ${userData.data()}');
    } else {
      // User data does not exist, handle accordingly
      print('No user data found for ${user.email}');
    }
  }

  Future loginCheckUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: nameController.text, password: passwordController.text,);

      User? user = userCredential.user;

      if(user != null) {
        // final userData = await _firestoreService.getUserData(userCredential.user!.uid);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen(userData: userData)),
        // );
      }else{
        print("no");
      }


    }catch (e) {
      print("kk $e");
    }
  }
}
