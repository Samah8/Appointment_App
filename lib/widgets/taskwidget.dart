import 'package:calender/model/event_data_source.dart';
import 'package:calender/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../pages/event_view_page.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
   final provider=Provider.of<EventProvider>(context);
   final selectedEvents=provider.eventsOfSelectedDate;
   if(selectedEvents.isEmpty){
     return const Center(
       child: Text("No Events Found!",style: TextStyle(fontSize: 24),),
     );
   }
   return SfCalendarTheme(
     data: SfCalendarThemeData(
     ),
     child: SfCalendar(
       view: CalendarView.timelineDay,

       dataSource: EventDataSource(provider.events),
       initialDisplayDate: provider.selectDate,
       appointmentBuilder:appointmentBuilder ,
       headerHeight: 0,
       onTap: (details){
         if(details.appointments==null)return;
         final event=details.appointments!.first;
         Get.to(EventVeiwingPage(event:event));
       },
     ),
   );
  }
Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details
    )
{
  final event=details.appointments.first;
  return Container(
    width: details.bounds.width,
    height: details.bounds.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.blue.shade50.withOpacity(0.5)
    ),
    child: Center(
      child: Text(
        event.place,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}
}
