import 'package:calender/pages/event_edit_page.dart';
import 'package:calender/provider/event_provider.dart';
import 'package:calender/widgets/calender_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>EventProvider(),
      child: GetMaterialApp(
        title: 'Calender Demo',
        home:Scaffold(
          appBar:AppBar(
            title: const Text('Appointment') ,
            centerTitle: true,
          ),
          body: const CalenderWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () { Get.to(()=>const eventEditingPage()); },
            child:const Icon(Icons.add) ,
          ),
        )
      ),
    );
  }
}

