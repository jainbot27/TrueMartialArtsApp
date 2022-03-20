import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csia/event.dart';
import 'package:csia/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/get_doc_name.dart';
import 'package:csia/button.dart'; 

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

List<bool> toggles = []; 
class EventListState extends State<EventList> {
  Widget build(BuildContext context) {
    for (int i = 0; i < toggles.length; i++) 
      toggles[i] = false; 
    return Scaffold(
      body: FutureBuilder<List<Event>>(
        future: calcAllEvents(), 
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Icon icon1 = const Icon(CupertinoIcons.bell);
                Icon icon2 = const Icon(CupertinoIcons.bell_fill);
                bool current = false; 
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(snapshot.data![index].name), 
                    leading: Button()                  )
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