import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/FadeAnimation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

final _firestore = Firestore.instance;

class JobPostPage extends StatefulWidget {
  @override
  _JobPostPageState createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {

  String company;
  String description;
  String hours;
  String location;
  String postedby;
  String salary;
  String skillsreq;
  String type;
  String website;
  String workemail;
  String linkedin;


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
                  FadeAnimation(1.5, Text("Post A Job", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
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
                                hintText: "Your Email",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              workemail = value;
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
                                hintText: "Your Full Name",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              postedby = value;
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
                                hintText: "Your Linkedin Account Link",
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              onChanged: (value){
                              linkedin = value;
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
                                hintText: "Company Name",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              company = value;
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
                                hintText: "Job Type",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              type = value;
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
                                hintText: "Job Location",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              location = value;
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
                                hintText: "Work Hours (like 5-8 pm)",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              hours = value;
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
                                hintText: "Your Company Website",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              website = value;
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
                                hintText: "Skills Required",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              skillsreq = value;
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
                                hintText: "Salary",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              salary = value;
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
                                hintText: "Job Description",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                            onChanged: (value){
                              description = value;
                            },
                          ),
                        )
                      ],
                    ),
                  )),
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
                            child: Text("Post Job", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        onTap: () {
                          //flag ----------------------------------------------

                          final jobDetails = [
                          company,
                          description,
                          hours,
                          location,
                          postedby,
                          salary,
                          skillsreq,
                          type,
                          website,
                          workemail,
                          linkedin,
                          ];

                          int flag = 1;

                          for(var field in jobDetails) {
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
                            _firestore.collection('jobposts').add({
                              'company' : company,
                              'description' : description,
                              'name' : postedby,
                              'hours' : hours,
                              'location' : location,
                              'salary' : salary,
                              'type' : type,
                              'workemail' : workemail,
                              'website' : website,
                              'skillsreq' : skillsreq,
                              'linkedin' : linkedin,
                            });
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Job Details Submitted!",
                              desc: "We'll evaluate the job and post it soon",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Done",
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
