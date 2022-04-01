import 'package:flutter/material.dart';
import 'package:TMA/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:TMA/get_doc_name.dart';
import 'package:TMA/button.dart';
import 'package:TMA/main.dart';
// import 'package:TMA/counter.dart';

CollectionReference events = firestore.collection('events');
class EventList extends StatefulWidget {
  EventListState createState() => EventListState();
}

Future<List<Event>>? calcAllEvents() async {
  List<Event> allRelevantEvents = [];
  await events.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc.data().toString().contains('Time')) {
        DateTime dt = getDT(doc['Time']);
        DateTime ndt =
            DateTime(dt.year, dt.month, dt.day, doc['Hour'], doc['Minute']);
        if (ndt.compareTo(DateTime.now()) != -1) {
          // weeding out events that are not useful to us 
          allRelevantEvents.add(Event(
              description: doc['Description'],
              name: doc['Name'],
              id: 0,
              time: ndt));
        }
      }
    });
  });
  // implementation of bubble sort
  for (int iterations = 0; iterations < allRelevantEvents.length; iterations++) {
    for (int pos = 0; pos < allRelevantEvents.length - 1; pos++) {
      if (allRelevantEvents[pos].time.compareTo(allRelevantEvents[pos + 1].time) == 1) {
        Event e = allRelevantEvents[pos]; 
        allRelevantEvents[pos] = allRelevantEvents[pos + 1]; 
        allRelevantEvents[pos + 1] = e; 
      }
    }
  }
  return allRelevantEvents;
}


class EventListState extends State<EventList> {
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Event>>(
          future: calcAllEvents(),
          builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DateTime public = snapshot.data![index].time;
                  String body = snapshot.data![index].description;
                  String title = snapshot.data![index].name;
                  return Card(
                      child: ListTile( // Each inidivual member of my list
                          // display info about the event
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].description +
                              "\n" +
                              public
                                  .toString()
                                  .substring(0, public.toString().length - 7)),
                          leading: Button(title, body, public)));
                },
              );
            } else {
              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
