import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/FadeAnimation.dart';
import 'package:flutter_smart_course/src/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_course/src/pages/post_job_page.dart';
import 'package:flutter_smart_course/src/pages/registration_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

typedef RoutePredicate = bool Function(Route<dynamic> route);

class _LoginPageState extends State<LoginPage> {
  static const String id = 'login_screen';

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;


  Future<bool> _onBackPressed(){
    return  null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 370,
                  child: Stack(
                    children: <Widget>[

                      Positioned(
                        top: -20,
                        height: 415,
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
                      FadeAnimation(1.5, Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                      SizedBox(height: 30,),
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
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                onChanged: (value){
                                  email = value;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                onChanged: (value){
                                  password = value;
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                      SizedBox(height: 20,),
                      FadeAnimation(2, GestureDetector(
                        child: Center(
                          child: Text("Register An Account",
                            style: TextStyle(
                                color: Color.fromRGBO(196, 135, 198, 1)),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RegistrationPage();
                          }));
                        },
                      ),
                      ),
                      SizedBox(height: 20,),
                      FadeAnimation(1.9, GestureDetector(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        onTap: () async {

                          setState(() {
                            showSpinner = true;
                          });

                          try{
                            final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
//
                            if(user != null){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return HomePage();
                              }));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                          catch(e){
                            final error = e;
                            if(error == e){
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Login Unsuccessful",
                                desc: 'Check Your Credentials'
                              ).show();
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        },
                      )),
                      SizedBox(height: 15,),
                      FadeAnimation(2, GestureDetector(
                        child: Center(
                          child: Text("Post A Job",
                            style: TextStyle(
                                color: Color.fromRGBO(196, 135, 198, 1)),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return JobPostPage();
                          }));
                        },
                      ),
                      ),
                      SizedBox(height: 25,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
