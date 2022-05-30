

import 'package:calender/model/event.dart';
import 'package:calender/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../widgets/custom_text_form_field.dart';


class eventEditingPage extends StatefulWidget {
  final Event? event;
  const eventEditingPage({Key? key, this.event,}) : super(key: key);
  @override
  _eventEditingPageState createState() => _eventEditingPageState();
}

class _eventEditingPageState extends State<eventEditingPage> {
  final _formkey=GlobalKey<FormState>();
  final TextEditingController _namecontroller =TextEditingController();
  final TextEditingController _notecontroller =TextEditingController();
  late final TextEditingController _startDcontroller =TextEditingController();
  late final TextEditingController _timecontroller =TextEditingController();
  late final TextEditingController _personcontroller =TextEditingController();
  late final TextEditingController _remcontroller =TextEditingController();
  DateTime ? _startDate;
  TimeOfDay? _selectedTime;
  int _selectedremind=8;
  List<int>remindlist=[ 8,12, 24];

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namecontroller.dispose();
    _notecontroller.dispose();
    _startDcontroller.dispose();
    _timecontroller.dispose();
    _personcontroller.dispose();
    _remcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(('Add Appointment')),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
            addAppointment();
            ScaffoldMessenger.of(context)
                .showMaterialBanner(
                MaterialBanner(
                  backgroundColor: Colors.blue[900],
                  content: const Text('New Appointment inserted ',
                    style: TextStyle(color: Colors.white),),
                  actions: [TextButton(
                      child: const Text(
                        'Close', style: TextStyle(color: Colors.white),),
                      onPressed: () => ScaffoldMessenger.of(context)
                          .hideCurrentMaterialBanner())
                  ],
                )
            );
            },
            child:const Padding(
              padding: EdgeInsets.only(top: 8.0,right: 4),
              child: Text('Add',style:TextStyle(color: Colors.white,fontSize: 18)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [

              InputField(title: 'Where is it?', hint: ' ',controller: _namecontroller,),
              const SizedBox(height: 5.0,),
              InputField(title: "Who is it with?", hint: '',controller: _personcontroller, ),
              const SizedBox(height: 15.0,),
              CustomDatepickerFormField(controller: _startDcontroller, title: "Appointment Date",
                  callback: (){
                    pickDate(context);
                  }),
              const SizedBox(height: 10.0,),
              CustomDatepickerFormField(controller: _timecontroller, title: "Time",
                  callback: (){
                    pickTime(context);
                  }),
              const SizedBox(height: 10.0,),
              InputField(title: "Remind me ", hint:"Before  $_selectedremind hours",controller: _remcontroller,
                widget:DropdownButton(
                    elevation:4,
                    underline: Container(width: 0),
                    icon:const Icon(Icons.keyboard_arrow_down,color: Colors.grey),
                    iconSize: 32,
                    onChanged: (String? newval){
                      setState(() {
                        _selectedremind=int.parse(newval!);
                        _remcontroller.text=newval;
                      });
                    },
                    items:remindlist.map<DropdownMenuItem<String>>((int value)
                    {
                      return DropdownMenuItem<String> (
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }
                    ).toList()
                ) ,
              ),
              const SizedBox(height: 7.0,),
              InputField(controller: _notecontroller,title: 'Notes (Optional)',hint: '',),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> pickDate(BuildContext context)async{
    final initialDate=DateTime.now();
    final newDate=await showDatePicker(
        context: context,
        initialDate:_startDate?? initialDate,
        firstDate:DateTime(DateTime.now().year-10),
        lastDate: DateTime(DateTime.now().year+2)
    );
    if(newDate==null){
      return;
    }
    setState(() {
      _startDate=newDate;
      String date=DateFormat.yMd().format(newDate);
      _startDcontroller.text=date;
    });
  }
  Future<void> pickTime(BuildContext context)async{
    TimeOfDay initialTime=TimeOfDay.now();
    final  timeOfDay=
    await showTimePicker(context: context,
        initialTime:_selectedTime??initialTime
    );
    if(timeOfDay!=null) {
      setState(() {
        _selectedTime=timeOfDay;
        String time=timeOfDay.format(context);
        _timecontroller.text=time;
      });
    }
  }

  Future addAppointment()async{
    final isVaild =_formkey.currentState!.validate();
    if(isVaild){
      final event=Event(
          person: _personcontroller.text,
          remind: _selectedremind,
          note: _notecontroller.text,
          date:_startDcontroller.text ,
          place: _namecontroller.text,
          time:_timecontroller.text,

      );

   final provider =Provider.of<EventProvider>(context,listen:false);

     provider.addEvents(event);


    }
  }
}
