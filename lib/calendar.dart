import 'package:flutter/material.dart'; 
import 'package:table_calendar/table_calendar.dart'; 
import 'package:csia/event.dart'; 
import 'package:intl/intl.dart'; 
import 'package:provider/provider.dart'; 

class Calendar extends StatefulWidget {
  CalendarState createState() => CalendarState(); 
}

class CalendarState extends State<Calendar> {
  DateTime? _selectedDay; 
  DateTime _focusedDay = DateTime.now(); 
  List<Event> _selectedEvents = []; 

  @override

  void addEvent() {

  }

  void removeEvent() {

  }


  Widget build(BuildContext context) {
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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; 
                _focusedDay = focusedDay; 

              });
            },
          ),
        ],
      )
    );
  }
}

// basically our goal here is to -> get a day and figure out the events for that day 
// we can do this, how, 