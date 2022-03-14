import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'errorPopUp.dart';

class createProfile extends StatelessWidget {

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPassword2 = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(10), 
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 0), 
              child: const Text(
                'New to True Martial Arts?',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 26, 
                )
              )
            ),
            Container(
              padding: const EdgeInsets.all(8), 
              child: TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              )
            ),
            Container(
              padding: const EdgeInsets.all(5), 
              child: TextField(
                controller: controllerPassword,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              )
            ),
            Container(
              padding: const EdgeInsets.all(5), 
              child: TextField(
                controller: controllerPassword2,
                decoration: const InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              )
            ),
            TextButton(onPressed: () async {
                if (controllerPassword.text != controllerPassword2.text) {
                  createError(context, 'Your passwords are not the same!'); 
                } else {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: controllerEmail.text, 
                      password: controllerPassword.text
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      createError(context, 'Password is too weak');
                    } else if (e.code == 'email-already-in-use') {
                      createError(context, 'The account already exists for that email');
                    }
                  }
                }
              },
              child: const Text('Make Account')
            )
          ],
        )
      )
    );
  }
}