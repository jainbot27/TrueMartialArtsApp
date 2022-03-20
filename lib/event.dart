import 'package:flutter/material.dart';

class Event {
  int id;
  String name;
  DateTime time;
  String description;

  Event(
      {required this.id,
      required this.name,
      required this.time,
      required this.description});
}
