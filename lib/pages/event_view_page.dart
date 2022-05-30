import 'package:calender/model/event.dart';
import 'package:calender/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_edit_page.dart';

class EventVeiwingPage extends StatelessWidget {
  final Event event;

  const EventVeiwingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => eventEditingPage(
                          event: event,
                        )),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  final provider = Provider.of<EventProvider>(context);
                  provider.deleteEvents(event);
                }),
          ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text(event.place),

        ],
      ),
    );

}