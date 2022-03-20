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
  @override
  _ButtonState createState() => _ButtonState();
}

Icon icon1 = Icon(CupertinoIcons.bell);
Icon icon2 = Icon(CupertinoIcons.bell_fill);
Map<Tuple3<String, String, DateTime>, int> map = new Map();

class _ButtonState extends State<Button> {
  List<Icon> lst = [icon1, icon2];
  int idx = 0;
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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
            NotificationService.showSchedNotif(
                title: title, body: body, scheduledDate: public, id: id);
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
// Icon icon1 = const Icon(CupertinoIcons.bell);
// Icon icon2 = const Icon(CupertinoIcons.bell_fill);