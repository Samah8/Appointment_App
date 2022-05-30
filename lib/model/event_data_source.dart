
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:calender/model/event.dart';


class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Event>appointments){
   this.appointments=appointments;
  }
  // convert from dynamic object to event object
  Event getEvent(int index)=>appointments![index] as Event;

  String getPlace(int index)=>getEvent(index).place;

  String getPerson(int index)=>getEvent(index).person;

  String getNote(int index)=>getEvent(index).note;

  String getDate(int index)=>getEvent(index).date;

  int getRemind(int index)=>getEvent(index).remind;

  String getTime(int index)=>getEvent(index).time;

  @override
  Color getColor(int index)=> getEvent(index).background;
}