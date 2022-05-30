import 'package:flutter/material.dart';

class Event{
  final String place;
  final String person;
  final int remind;
  final String note;
  final String date;
  final String time;
  final Color background;


  const Event(
  { required this.person,
    required this.remind,
   required this.note,
   required this.date,
    required this.place,
    required this.time,
    this.background=Colors.lightBlueAccent,
});
}