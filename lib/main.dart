import 'package:csia/createProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csia/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csia/forgotPassword.dart'; 
import 'package:csia/createProfile.dart';
import 'package:csia/errorPopUp.dart';
import 'package:csia/regUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/admin.dart';

FirebaseAuth auth = FirebaseAuth.instance;
bool admin = false; 
FirebaseFirestore firestore = FirebaseFirestore.instance; 
CollectionReference admins = firestore.collection('admins');

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  // Firebase.initializeApp(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: const LoginScreen(), 
      ), 
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key); 
  @override
  State<LoginScreen> createState() => LoginScreen2(); 
}

class LoginScreen2 extends State<LoginScreen> {
  TextEditingController nameControl = TextEditingController(); 
  TextEditingController passControl = TextEditingController(); 
  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0), 
            padding: EdgeInsets.all(10), 
            child: const Text(
              'True Martial Arts',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              )
            )
          ),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 20)
            )
          ),

          Container(
            padding: const EdgeInsets.all(10), 
            child: TextField(
              controller: nameControl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            )
          ),

          Container(
            padding: const EdgeInsets.all(10), 
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: passControl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            )
          ),

          TextButton(
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: const Text('Forgot Password'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => createProfile()),
              );
            },
            child: const Text('Need an Account?'),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: nameControl.text, 
                    password: passControl.text
                  );
                  admins.add({
                    'Email': nameControl.text 
                  }); 
                  bool isAdmin = false; 
                  admins.get().then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      if (doc.data().toString().contains('Email')) {
                        if (doc['Email'] == nameControl.text) 
                          isAdmin = true;
                      }
                    });
                    if (isAdmin) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())); 
                    }
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    createError(context, 'No user was found under that name');
                  } else if (e.code == 'wrong-password') {
                    createError(context, 'Wrong password provided');
                  } else {
                    createError(context, e.code); 
                    // comment
                  }
                }
              },
            )
          ),
        ]
      )
    );
  }
}
