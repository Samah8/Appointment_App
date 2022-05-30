import 'package:calender/widgets/taskwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_data_source.dart';
import '../provider/event_provider.dart';


class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events=Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      dataSource: EventDataSource(events),
      cellBorderColor: Colors.transparent,
      onTap: (details){
        final provider=Provider.of<EventProvider>(context,listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context,
            builder: (context)=>const TaskWidget(),);
      },
    );
  }
}

