import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TMA/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:TMA/get_doc_name.dart';
import 'package:TMA/button.dart';
import 'package:TMA/main.dart';

CollectionReference events = firestore.collection('events');
class EventList extends StatefulWidget {
  EventListState createState() => EventListState();
}

Future<List<Event>>? calcAllEvents() async {
  List<Event> ret = [];
  await events.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc.data().toString().contains('Time')) {
        DateTime dt = getDT(doc['Time']);
        DateTime ndt =
            DateTime(dt.year, dt.month, dt.day, doc['Hour'], doc['Minute']);
        if (ndt.compareTo(DateTime.now()) != -1) {
          ret.add(Event(
              description: doc['Description'],
              name: doc['Name'],
              id: 0,
              time: ndt));
        }
      }
    });
  });
  print(ret.length);
  ret.sort((fir, sec) => fir.time.compareTo(sec.time));
  return ret;
}

DateTime public = DateTime.now();
String title = '';
String body = '';

class EventListState extends State<EventList> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Event>>(
          future: calcAllEvents(),
          builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Icon icon1 = const Icon(CupertinoIcons.bell);
                  Icon icon2 = const Icon(CupertinoIcons.bell_fill);
                  bool current = false;
                  public = snapshot.data![index].time;
                  body = snapshot.data![index].description;
                  title = snapshot.data![index].name;
                  return Card(
                      child: ListTile(
                          onTap: () {},
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].description +
                              "\n" +
                              public
                                  .toString()
                                  .substring(0, public.toString().length - 7)),
                          leading: Button()));
                },
              );
            } else {
              return SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
