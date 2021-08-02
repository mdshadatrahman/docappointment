import 'package:flutter/material.dart';

class UserAppointment extends StatefulWidget {
  const UserAppointment({ Key key }) : super(key: key);

  @override
  _UserAppointmentState createState() => _UserAppointmentState();
}

class _UserAppointmentState extends State<UserAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('My Appoinments'),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
      body: Text('User Appoinments'),
      
    );
  }
}