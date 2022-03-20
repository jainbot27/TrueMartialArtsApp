
import 'package:csia/error_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:csia/calendar.dart'; 
import 'package:csia/main.dart';
import 'package:csia/get_doc_name.dart'; 

class AdminScreen extends StatefulWidget {
  @override 
  AdminScreenState createState() => AdminScreenState();
}
class AdminScreenState extends State<AdminScreen> {
  TextEditingController name = TextEditingController(); 
  TextEditingController description = TextEditingController(); 
  TextEditingController year = TextEditingController(); 
  TextEditingController month = TextEditingController(); 
  TextEditingController day = TextEditingController(); 
  TextEditingController hour = TextEditingController(); 
  TextEditingController minute = TextEditingController(); 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pop();  
          },
        ),
        title: const Text('Admin Control')
      ),      
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10), 
            child: const Text(
              'Add an event',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              )
            )
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10), 
            child: const Text(
              'Admin Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              )
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: year,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Year',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: month,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Month',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: day,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Day',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: hour,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Hour',
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8), 
            child: TextField(
              controller: minute,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Minute',
              ),
            )
          ),
          Container(
            height: 55, 
            padding: EdgeInsets.all(10), 
            child: ElevatedButton(
              child: Text('Add Event'), 
              onPressed: () {
                try {
                  int Year = int.parse(year.text); 
                  int Month = int.parse(month.text);
                  int Day = int.parse(day.text); 
                  int Hour = int.parse(hour.text); 
                  int Minute = int.parse(minute.text); 
                  events.add({
                    'Hour': Hour, 
                    'Minute': Minute, 
                    // Time: getDocName(DateTime(: Year, Month: Month, Day: Day))
                    'Time': getDocName(DateTime(Year, Month, Day)),
                    'Name': name.text, 
                    'Description': description.text, 
                  });
                } on FormatException catch (e) {
                  createError(context, 'You most likely inputted a non-integer into the time boxes');
                }
              },
            ),
          ),
        ]
      )
    );
  }
}
