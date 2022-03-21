import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TMA/event.dart';
import 'package:TMA/event_list.dart';
import 'package:TMA/notification_service.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:TMA/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Button extends StatefulWidget {
  late String title, body;
  late DateTime public;
  Button(String title, String body, DateTime public) {
    this.title = title;
    this.body = body;
    this.public = public;
    print(title);
  }
  @override
  _ButtonState createState() => _ButtonState(title, body, public);
}

const Icon iconNoNotif = Icon(CupertinoIcons.bell);
const Icon iconYesNotif = Icon(CupertinoIcons.bell_fill);
Map<Tuple3<String, String, DateTime>, int> map = new Map();

class _ButtonState extends State<Button> {
  List<Icon> lst = [iconNoNotif, iconYesNotif];
  int idx = 0;
  late String title, body;
  late DateTime public;
  _ButtonState(String title, String body, DateTime public) {
    this.title = title;
    this.body = body;
    this.public = public;
  }
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('foo');
        setState(() {
          int id = 0;
          if (map.containsKey(Tuple3(title, body, public))) {
            var id2 = map[Tuple3(title, body, public)];
            if (id2 != null) {
              id = id2;
            }
          } else {
            firestore
                .collection('counter')
                .get()
                .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((doc) {
                id = doc['cnt'];
              });
            });
          }
          if (idx == 0) {
            print(public);
            print('foo');
            NotificationService.showSchedNotif(
                title: title, body: body, scheduledDate: public, id: id);
            // NotificationService.showSchedNotif(body: 'test1', title: 'test69', scheduledDate: DateTime.now().add(Duration(seconds: 6)) );
          } else {
            NotificationService.cancel(id);
          }
          idx ^= 1;
        });
      },
      child: lst[idx],
    );
  }
}
