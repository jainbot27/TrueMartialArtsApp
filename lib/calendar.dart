import 'package:flutter/material.dart'; 
import 'package:table_calendar/table_calendar.dart'; 
import 'package:csia/event.dart'; 
import 'package:csia/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:csia/get_doc_name.dart'; 

CollectionReference events = firestore.collection('events'); 

class Calendar extends StatefulWidget {
  CalendarState createState() => CalendarState(); 
}

class CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now(); 
  DateTime _focusedDay = DateTime.now(); 
  // List<Widget> eventWidgets = []; 
  List<Widget> eventWidgets = [];

  @override

  // Widget Events(var d){
  //   return Container(
  //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  //     child: Container(
  //         width: MediaQuery.of(context).size.width * 0.9,
  //         padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
  //         decoration: BoxDecoration(
  //             border: Border(
  //           top: BorderSide(color: Theme.of(context).dividerColor),
  //         )),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children:[Text(d.name,
  //                           style:
  //                               Theme.of(context).primaryTextTheme.bodyText1),
  //            ]) ),
  //       );  }

  void addEvent(DateTime dt, String name, String description) {
    events.add({'Time': getDocName(dt), 'Name': name, 'Description': description}); 
  }

  void removeEvent() {

  }


  Widget menuTitle(BuildContext context) {
    print('begin menuTitle'); 
    String text = "Events"; 
    var allEvents = reset(); 
    if (allEvents.length == 0) 
      text = "No Events"; 
    print('end menutitle'); 
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Text(text), 
    );
  }

  // Widget foo() {
  //   print('FOO'); 
  //   return Material(

  //   );
  // }

  // Widget huh() {
  //   print('YANG'); 
  //   // for (int i = 0; i < allEvents.length; i++) {
  //   //   print(allEvents[i].description);
  //   // }
  //   // return Text('huh'); 
  //   print(getDocName(_selectedDay)); 
  //   print(allEvents.length); 
  //   // if (allEvents.length == 0)
  //   //   return Material(); 
  //   return Text('huh');
  // }

  List<Event> reset() {
    List<Event> allEvents = []; 
    print('begin reset'); 
    events.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.data().toString().contains('Time')) {
          // print('???'); 
          if (doc['Time'] == getDocName(_selectedDay)) {
            print(_focusedDay); 
            allEvents.add(Event(id: 0, name: doc['Name'], time: _focusedDay, description: doc['Description'])); 
            // eventWidgets.add(Text('clown'));
          }
        }
      });
    });
    print('end reset'); 
    return allEvents;
  }

  Widget build(BuildContext context) {
    // addEvent(DateTime.now(), 'Class Today', 'Red Belt');
    print('build'); 
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay; 
                _focusedDay = focusedDay; 
                // print(getDocName(_focusedDay)); 
                assert(_selectedDay == _focusedDay); 
              });
            },
          ),
          menuTitle(context), 
          // Column(children: eventWidgets),
          // foo(), 
          // huh()
          // listOfEvents(),
        ],
      )
    );
  }
}

// basically our goal here is to -> get a day and figure out the events for that day 
// we can do this, how, 