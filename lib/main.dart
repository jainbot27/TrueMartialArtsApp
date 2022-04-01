import 'package:TMA/create_profile.dart';
import 'package:flutter/material.dart';
import 'package:TMA/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:TMA/forgot_password.dart';
import 'package:TMA/error_pop_up.dart';
import 'package:TMA/main_screen_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:TMA/admin.dart';
import 'package:TMA/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

final FirebaseAuth auth = FirebaseAuth.instance;
bool admin = false;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference admins = firestore.collection('admins');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  @override 
  void initState() {
    super.initState();
    NotificationService.init();
    listenNotifs();
  }

  void listenNotifs() =>
      NotificationService.onNotif.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        // builder: (context) => SecondPage(payload: payload),
        builder: (context) => LoginScreen(),
      ));
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              padding: EdgeInsets.all(10),
              child: const Text('True Martial Arts',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                  ))),

          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: const Text('Sign In', style: TextStyle(fontSize: 20))),

          Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              )),

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
              )),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: const Text('Forgot Password'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => createProfile()),
              );
            },
            child: const Text('Need an Account?'),
          ),
          // TextButton(
          //   onPressed: () {
          //     NotificationService.showSchedNotif(
          //       title: 'test1',
          //       body: 'test2',
          //       scheduledDate: DateTime.now().add(Duration(seconds: 12)),
          //     );
          //   },

          //   child: const Text('Tester')
          // ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  if (emailTextController.text.length == 0 || passControl.text.length == 0) {
                    createError(context, 'You haven\'t entered text into one/both fields');
                    return;
                  }
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passControl.text);
                    bool isAdmin = false;
                    admins.get().then((QuerySnapshot querySnapshot) {// access admin document
                      querySnapshot.docs.forEach((doc) {
                        if (doc.data().toString().contains('Email')) {
                          if (doc['Email'] == emailTextController.text) { 
                            // checks if the current name is equal to that admin, 
                            // if so, sets a flag denoting that it is
                            isAdmin = true;
                          }
                        }
                      });
                      passControl.clear(); 
                      emailTextController.clear(); 
                      if (isAdmin) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      createError(context, 'No user was found under that name');
                    } else if (e.code == 'wrong-password') {
                      createError(context, 'Wrong password provided');
                    } else {
                      createError(context, e.code);
                    }
                  }
                },
              )),
        ]));
  }
}
