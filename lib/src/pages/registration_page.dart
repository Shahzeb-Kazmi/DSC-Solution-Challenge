import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/FadeAnimation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

final _firestore = Firestore.instance;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  String schoolEmail;
  String altEmail;
  String fName;
  String lName;
  String password;
  String uniName;
  String majSub;
  String degreestat;
  String city;
  String linkedin;
  String cgpa;
  String skills;


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 370,
              child: Stack(
                children: <Widget>[

                  Positioned(
                    top: -20,
                    height: 400,
                    width: width,
                    child: FadeAnimation(2, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeAnimation(1, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(1.5, Text("Register", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  SizedBox(height: 15,),
                  FadeAnimation(1.5, Text("Please Fill All Sections", style: TextStyle( color: Color.fromRGBO(196, 135, 198, 1)),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.5, Text("Write NA For Unavailable", style: TextStyle( fontSize: 10 ,color: Colors.redAccent),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "School Issued Email  (@xyz.edu.pk)",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              schoolEmail = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Personal Email",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              altEmail = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "First Name",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              fName = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Last Name",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              lName = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password  (min 6 characters)",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              password = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "University Name",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              uniName = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "What Are You Studying?",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              majSub = value;
                            },
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Degree Status",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              degreestat = value;
                            },
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Your City",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              city = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "CGPA",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              cgpa = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "LinkedIn Account Link",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              linkedin = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "6 Notable Skills",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              skills = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  ),
                  SizedBox(height: 30,),

                  FadeAnimation(1.9, GestureDetector(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child: Text("Register", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    onTap: () {
                      //flag ----------------------------------------------

                      final regDetails = [
                        schoolEmail,
                        altEmail,
                        fName,
                        lName,
                        password,
                        uniName,
                        majSub,
                        city,
                        cgpa,
                        linkedin,
                        skills,
                      ];

                      int flag = 1;

                      for(var field in regDetails) {
                        if (field == null) {
                          flag = flag * 0;
                        }

                        else{
                          flag = flag * 1;
                        }
                      }

                      if(flag == 0) {
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: "Please Enter All Fields",
                          desc: 'Write NA for unavailable',
                        ).show();
                      }

                      else{
                        _firestore.collection('registerations').add({
                          'schoolEmail' : schoolEmail,
                          'altEmail' : altEmail,
                          'fName' : fName,
                          'lName' : lName,
                          'password' : password,
                          'uniName' : uniName,
                          'majSub' : majSub,
                          'degreestat' : degreestat,
                          'city' : city,
                          'cgpa' : cgpa,
                          'linkedin' : linkedin,
                          'skills' : skills,
                        });
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Details Submitted!",
                          desc: "You'll hear from us soon",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "COOL!",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder:
                              (context){
                                return LoginPage();
                              })),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                      //flag ----------------------------------------------
                    },
                  )),
                  SizedBox(height: 30,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
