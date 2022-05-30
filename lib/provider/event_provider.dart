


import 'package:calender/model/event.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier{
  final List <Event> _events=[];
  List<Event> get events=>_events;
  DateTime _selectedDate=DateTime.now();
  DateTime setDate(DateTime date)=>_selectedDate=date;
  DateTime get selectDate=>_selectedDate;
  List<Event> get eventsOfSelectedDate=>_events;

   addEvents(Event event){
    _events.add(event);

    notifyListeners();
  }
  void deleteEvents(Event event){
    _events.remove(event);

    notifyListeners();
  }
  void editEvent(Event newEvent,Event oldEvent){
   final index= _events.indexOf(oldEvent);
   _events[index]=newEvent;
   notifyListeners();
  }
}