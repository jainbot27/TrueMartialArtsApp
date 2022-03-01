import 'package:csia/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController email = TextEditingController();
  @override
  ForgotPassword({Key? key}) : super(key: key); 
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 280, 0, 0),
        // alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Container(
              child: const Text(
                'Forgot Your Password?',
                style: TextStyle(fontSize: 30, color: Colors.red), 
                textAlign: TextAlign.center,
              ), 
            ),
            Container(
              child: const Text('Enter your email below to reset your password:',
              style: TextStyle(fontSize: 15, color: Colors.black),
              textAlign: TextAlign.center,
              )
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Email',
                ),
              ),
            ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Enter Email'),
              onPressed: () {
                print(email.text);
                auth.authStateChanges().listen((User? user) {
                  if (user == null) print('User is currently signed out'); 
                  else print('User is signed in');
                })    ;
              },
            )
          ),
          ]
        )
      )  
    );
  }
}
