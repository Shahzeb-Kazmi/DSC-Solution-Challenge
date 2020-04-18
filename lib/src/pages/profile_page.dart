import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/models/user.dart';
import 'package:flutter_smart_course/src/pages/home_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double width;

  final _auth = FirebaseAuth.instance;
  String imgPath;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    userStream();
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user!=null){
        loggedInUser = user;
        print(loggedInUser.uid);
      } }
    catch(e){
      print(e);
    }
  }

  void userStream() async{
    await for (var snapshot in _firestore.collection('userprofile').snapshots()){
      for(var user in snapshot.documents){
        print(user.data);

      }
    }
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Future<bool> _onBackPressed(){
      return  null;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            height: 120,
            width: width,
            decoration: BoxDecoration(
              color: LightColor.orange,
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    top: 10,
                    right: -120,
                    child: _circularContainer(300, LightColor.lightOrange2)),
                Positioned(
                    top: -60,
                    left: -65,
                    child: _circularContainer(width * .5, LightColor.darkOrange)),
                Positioned(
                    top: -230,
                    right: -30,
                    child: _circularContainer(width * .7, Colors.transparent,
                        borderColor: Colors.white38)),
                Positioned(
                    top: 50,
                    left: 0,
                    child: Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return HomePage();
                                }));
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ))),
              ],
            )),
      ),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _profileInfo() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('userprofile').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
                );
              }
              final userprofile = snapshot.data.documents;
              List <UserModel> userInfo = [];
              int index;
              for (var profile in userprofile) {
                  final name = profile.data['name'];
                  final profileimg = profile.data['profileimage'];
                  final cgpa = profile.data['cgpa'];
                  final majorsubject = profile.data['majorsubject'];
                  final university = profile.data['university'];
                  final degreestat = profile.data['degreestat'];
                  final uIndex = profile.data['index'];
                  final userId = profile.data['userId'];
                  final skill1 = profile.data['skill1'];
                  final skill2 = profile.data['skill2'];
                  final skill3 = profile.data['skill3'];
                  final skill4 = profile.data['skill4'];
                  final skill5 = profile.data['skill5'];
                  final skill6 = profile.data['skill6'];

                  final userData = UserModel(
                  name: name,
                  profileimg: profileimg,
                  cgpa: cgpa,
                  majorsubject: majorsubject,
                  university: university,
                  degreestat: degreestat,
                  index: uIndex,
                  userId: userId,
                  skill1: skill1,
                  skill2: skill2,
                  skill3: skill3,
                  skill4: skill4,
                  skill5: skill5,
                  skill6: skill6,
                  );

                  if(loggedInUser.uid == userId){
                    index = uIndex;
                  }

                  userInfo.add(userData);
              }
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                CircleAvatar(
                  backgroundImage: NetworkImage(userInfo[index].profileimg),
                  radius: 50.0,
                ),
                SizedBox(height: 20),
                Text(userInfo[index].name,
                  textAlign: TextAlign.left,
                  style: kTitleStyle),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) {
                          _auth.signOut();
                          return LoginPage();
                           })
                         );
                        },
                        child: _chip("Log Out", Colors.purple)),
                  ],
                ),
                SizedBox(height: 10),
                Text('Credentials', style: TextStyle(
                  fontWeight: FontWeight.w600,
                    color: Colors.purple
                ),),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Degree Status:', style: kTextStyle),
                          SizedBox(height: 10.0,),
                          Text('Major Subject:', style: kTextStyle),
                          SizedBox(height: 10.0,),
                          Text('CGPA:', style: kTextStyle),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(userInfo[index].degreestat, style: kTitleStyle.copyWith(fontSize: 15.0)),
                          SizedBox(height: 10.0,),
                          Text(userInfo[index].majorsubject, style: kTitleStyle.copyWith(fontSize: 15.0)),
                          SizedBox(height: 10.0,),
                          Text(userInfo[index].cgpa.toStringAsFixed(2) + '/4', style: kTitleStyle.copyWith(fontSize: 15.0)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3.0,),
                Text('Relevant Skills', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),),
                SizedBox(height: 10.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill1, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill2, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill3, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill4, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill5, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                          Text(userInfo[index].skill6, style: kSkillStyle),
                          SizedBox(height: 15.0,),
                        ],
                      )
                    ],
                  )
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('University ', style: kTextStyle.copyWith(color: Colors.purple, fontWeight: FontWeight.w600),),
                        SizedBox(height: 10.0,),
                        Text(userInfo[index].university, style: kTextStyle.copyWith(color: Colors.deepOrangeAccent),),
                        SizedBox(height: 10.0,),
                      ],
                      ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.purple,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.person),
          ],
          onTap: (index) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              SizedBox(height: 20),
//              _categoryRow("Start a new career"),
              _profileInfo(),
            ],
          ),
        )));
  }
}

Widget _chip(String text, Color textColor,
    {double height = 0, bool isPrimaryCard = false}) {
  return InkWell(

    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    ),
  );
}

const kTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.1,
    color: Colors.redAccent,
  );

const kTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Colors.black54,
);

const kSkillStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black54,
);