import 'package:flutter/material.dart'; 
import 'package:table_calendar/table_calendar.dart'; 

class Calendar extends StatefulWidget {
  CalendarState createState() => CalendarState(); 
}

class CalendarState extends State<Calendar> {
  DateTime? _selectedDay; 
  DateTime _focusedDay = DateTime.now(); 
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
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
