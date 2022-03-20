import 'package:flutter/material.dart';
import 'package:csia/event.dart';
import 'package:csia/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/get_doc_name.dart';

class EventList extends StatefulWidget {
  EventListState createState() => EventListState();
}

Future<List<Event>>? calcAllEvents() async {

  List<Event> ret = []; 
    await events.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.data().toString().contains('Time')) {
          DateTime dt = getDT(doc['Time']); 
          DateTime ndt = DateTime(dt.year, dt.month, dt.day, doc['Hour'], doc['Minute']);
          ret.add(Event(description: doc['Description'], name: doc['Name'], id: 0, time: ndt)); 
        }
      });
    });
  print(ret.length); 
  ret.sort((fir, sec) => fir.time.compareTo(sec.time)); 
  return ret; 
}

class EventListState extends State<EventList> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Event>>(
        future: calcAllEvents(), 
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(snapshot.data![index].name), 
                  )
                );
              },
            );
          } else {
            return SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}