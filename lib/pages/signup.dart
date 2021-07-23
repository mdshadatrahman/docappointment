import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorappointment/pages/loginmethods.dart';
import 'package:doctorappointment/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var authHandler = new Auth();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phonrnumberControllr = TextEditingController();

  String _genderController;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('Register'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[600],
              ),
              child: Text('Sign in'),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter your full name';
                      }
                      return null;
                    },     
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(      
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white
                    ),   
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter your age';
                      }
                      return null;
                    },     
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      hintText: 'Age',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[800]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          value: _genderController,
                          
                          dropdownColor: Colors.grey[800],
                          style: TextStyle(color: Colors.white),
                          items:<String>[
                            'Male',
                            'Female',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Select your gender',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (String value){
                            setState(() {
                              _genderController = value;
                            });
                          },
                          
                        ),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(      
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white
                    ),   
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      hintText: 'Address',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(      
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white
                    ),
                    keyboardType: TextInputType.number,
                    controller: _phonrnumberControllr,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter your email';
                      }
                      return null;
                    }, 
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email (Optional)',
                      hintStyle: TextStyle(color: Colors.white),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green
                    ),
                    onPressed: () async{
                      try {
                        await authHandler.handleSignUp(_emailController.text, _passwordController.text);
                        
                        print(FirebaseAuth.instance.currentUser.uid);

                        users.doc(FirebaseAuth.instance.currentUser.uid)
                        .set({
                          'name': _nameController.text,
                          'age': _ageController.text,
                          'gender': _genderController,
                          'address': _addressController.text,
                          'phone':_phonrnumberControllr.text,
                          'email': _emailController.text,
                        }).then((value) {
                          Fluttertoast.showToast(msg: 'Registration Successfull. Please sign in now.',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0,);
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginScreen()));
                        })
                      .catchError((error){
                        Fluttertoast.showToast(
                          msg: '$error',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0,
                          );
                      });
                      } catch (e) {
                        Fluttertoast.showToast(
                        msg: '$e',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                        );
                      }
                    },
                    child: Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}