import 'package:doctorappointment/pages/home.dart';
import 'package:doctorappointment/pages/loginmethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());  
}

class MyApp extends StatefulWidget {  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   Firebase.initializeApp();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Container(
              child: Text('Error'),
            );
          }
          if(snapshot.connectionState == ConnectionState.active){
            User user = snapshot.data;
            if(user == null){
              return MaterialApp(
                home: LoginScreen(),
              );
            }
            return MaterialApp(
              home: AppointHome(),
            );
          } 
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        },
      ),
    );
  }
}
