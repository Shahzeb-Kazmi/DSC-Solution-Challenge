import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
import 'package:flutter_smart_course/src/pages/all_jobs_page.dart';
import 'package:flutter_smart_course/src/pages/job_info_page.dart';
import 'package:flutter_smart_course/src/pages/profile_page.dart';
import 'package:flutter_smart_course/src/pages/stories_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:flutter_smart_course/src/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_course/models/job.dart';
import 'about_page.dart';
import 'all_opps_page.dart';
import 'featured_job_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double width;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    jobsStream();
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

  void jobsStream() async{
    await for (var snapshot in _firestore.collection('featured').snapshots()){
      for(var feature in snapshot.documents){
        print(feature.data);
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
        child:
        FadeAnimation(1, Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
              color: LightColor.purple,
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    top: 30,
                    right: -100,
                    child: _circularContainer(300, LightColor.lightpurple)),
                Positioned(
                    top: -100,
                    left: -45,
                    child: _circularContainer(width * .5, LightColor.darkpurple)),
                Positioned(
                    top: -180,
                    right: -30,
                    child: _circularContainer(width * .7, Colors.transparent,
                        borderColor: Colors.white38)),
                Positioned(
                    top: 40,
                    left: 0,
                    child: Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Hero(
                              tag: 'tulbalogo',
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                  'images/Tulba - Copy.png'),
                                radius: 45.0,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Connecting Students and Jobs",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic
                              ),
                            )
                          ],
                        )))
              ],
            )),
      )),
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

  Widget _categoryRowA(Color primary, Color textColor, context)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
              onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>About())),
              child: _chip("About Us", primary),
          ),

          GestureDetector(
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>Stories())),
            child: _chip("Stories", primary),
          ),

          GestureDetector(
            onTap:() async {
                final Email email = Email(
                recipients: ['tulbaincofficial@gmail.com'],
                isHTML: false,
                );
                await FlutterEmailSender.send(email);
                print('pressed!');
                },
            child: _chip("Contact", primary),
          )
        ],
      ),
    );
  }

  Widget _categoryRowB(String title, Color primary, Color textColor, context)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllJobs())),
              child: _chip("See all", primary))
        ],
      ),
    );
  }

  Widget _categoryRowC(String title, Color primary, Color textColor, context)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
              onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllOpps())),
              child: _chip("See all", primary))
        ],
      ),
    );
  }

  Widget _featuredRowA(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('featured').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
              );
            }
            final featured = snapshot.data.documents;
            List <FeaturedJobModel> jobList = [];
            for (var job in featured) {
              final jobtitle = job.data['title'];
              print('success');
              final imageUrl = job.data['image'];
              final location = job.data['joblocation'];
              final description = job.data['description'];
              final salary = job.data['jobsalary'];
              final jobcompany = job.data['company'];
              final jobhours = job.data['jobhours'];
              final jobtype = job.data['type'];

              final jobData = FeaturedJobModel(
                description: description,
                image: imageUrl,
                location: location,
                title: jobtitle,
                salary: salary,
                company: jobcompany,
                hours: jobhours,
                type: jobtype,
                photos: [
                  "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
                ],
              );
              jobList.add(jobData);
            }
            return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                    return FeaturedScreen(index: 0,);
                  })
                ),
                child: _card(
                    primary: LightColor.orange,
                    backWidget:
                        _decorationContainerA(LightColor.lightOrange, 50, -30),
                    chipColor: LightColor.orange,
                    chipText1: jobList[0].title + " at " + jobList[0].company,
                    isPrimaryCard: true,
                    imgPath:
                        jobList[0].image,
                ),
              ),
              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                  return FeaturedScreen(index: 1);
                })
                ),
                child: _card(
                    primary: Colors.white,
                    chipColor: LightColor.seeBlue,
                    backWidget: _decorationContainerB(Colors.white, 90, -40),
                    chipText1: jobList[1].title + " at " + jobList[1].company,
                    imgPath:
                        jobList[1].image),
              ),
              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                  return FeaturedScreen(index: 2);
                })
                ),
                child: _card(
                    primary: Colors.white,
                    chipColor: LightColor.lightOrange,
                    backWidget: _decorationContainerC(Colors.white, 50, -30),
                    chipText1: jobList[2].title + " at " + jobList[2].company ,
                    imgPath:
                       jobList[2].image),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _featuredRowB(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('jobs').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
              );
            }
            final jobs = snapshot.data.documents;
            List <JobModel> jobList = [];
            for (var job in jobs) {
              final jobtitle = job.data['jobtitle'];
              print('success');
              final imageUrl = job.data['image'];
              final location = job.data['joblocation'];
              final description = job.data['jobdescription'];
              final salary = job.data['jobsalary'];
              final jobcompany = job.data['jobcompany'];
              final jobhours = job.data['jobhours'];
              final jobtype = job.data['jobtype'];

              final jobData = JobModel(
                description: description,
                iconUrl: imageUrl,
                location: location,
                title: jobtitle,
                salary: salary,
                company: jobcompany,
                hours: jobhours,
                type: jobtype,
                photos: [
                  "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
                ],
              );
              jobList.add(jobData);
            }
            return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailsScreen(index: 0,);
                })
                ),
                child: _card(
                    primary: LightColor.seeBlue,
                    chipColor: LightColor.seeBlue,
                    backWidget: _decorationContainerD(
                        LightColor.darkseeBlue, -130, -65,
                        secondary: LightColor.lightseeBlue,
                        secondaryAccent: LightColor.seeBlue),
                    chipText1: jobList[0].title + " at " + jobList[0].company,
                    isPrimaryCard: true,
                    imgPath:
                       jobList[0].iconUrl),
              ),

              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailsScreen(index: 1,);
                })
                ),
                child: _card(
                    primary: Colors.white,
                    chipColor: LightColor.lightpurple,
                    backWidget: _decorationContainerE(
                      LightColor.lightpurple,
                      90,
                      -40,
                      secondary: LightColor.lightseeBlue,
                    ),
                    chipText1: jobList[1].title + " at " + jobList[1].company,
                    imgPath:
                    jobList[1].iconUrl),
              ),

              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailsScreen(index: 2,);
                })
                ),
                child: _card(
                    primary: Colors.white,
                    chipColor: LightColor.lightOrange,
                    backWidget: _decorationContainerF(
                        LightColor.lightOrange, LightColor.orange, 50, -30),
                    chipText1: jobList[2].title + " at " + jobList[2].company,
                    imgPath:
                    jobList[2].iconUrl),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _featuredRowC(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('opportunities').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
              );
            }
            final opps = snapshot.data.documents;
            List <OppModel> oppList = [];
            for (var opp in opps) {
              final title = opp.data['title'];
              print('success');
              final imageUrl = opp.data['image'];
              final org = opp.data['organisation'];
              final description = opp.data['description'];
              final type = opp.data['type'];
              final name = opp.data['name'];
              final learnmore = opp.data['learnmore'];

              final oppData = OppModel(
                description: description,
                imageUrl: imageUrl,
                name: name,
                title: title,
                learnmore: learnmore ,
                organisation: org,
                type: type,
                photos: [
                  "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
                ],
              );
              oppList.add(oppData);
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap:() {
                    _launchURL(oppList[0].learnmore);
                 },
                  child: _card(
                      primary: Colors.green[400],
                      chipColor: LightColor.seeBlue,
                      backWidget: _decorationContainerD(
                          Colors.green[500], -160, -80,
                          secondary: Colors.green[100],
                          secondaryAccent: Colors.green[100]),
                      chipText1: oppList[0].name + " by " + oppList[0].organisation,
                      chipText2: 'Learn More',
                      isPrimaryCard: true,
                      imgPath:
                      oppList[0].imageUrl),
                ),

                GestureDetector(
                  onTap:() {
                      _launchURL(oppList[1].learnmore);
                  },
                  child: _card(
                      primary: Colors.white,
                      chipColor: LightColor.lightpurple,
                      backWidget: _decorationContainerE(
                        LightColor.lightpurple,
                        150,
                        -70,
                        secondary: LightColor.lightseeBlue,
                      ),
                      chipText1: oppList[1].name + " by " + oppList[1].organisation,
                      chipText2: 'Learn More',
                      imgPath:
                      oppList[1].imageUrl),
                ),

                GestureDetector(
                  onTap:(){
                      _launchURL(oppList[1].learnmore);
                  },
                  child: _card(
                      primary: Colors.white,
                      chipColor: LightColor.lightOrange,
                      backWidget: _decorationContainerF(
                          LightColor.lightOrange, LightColor.orange, 50, -30),
                      chipText1: oppList[2].name + " by " + oppList[2].organisation,
                      chipText2: 'Learn More',
                      imgPath:
                      oppList[2].imageUrl),
                ),
              ],
            );
          }
      ),
    );
  }


  //#########################################################################//
  //########################################################################//
  //############################## Design Resources Below ##################//
  //#######################################################################//
  //######################################################################//

  Widget _card(
      {Color primary = Colors.redAccent,
      String imgPath,
      String chipText1 = '',
      String chipText2 = 'Apply',
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(imgPath),
                    )),
                Positioned(
                  bottom: 10,
                  left: 5,
                  child: _cardInfo(chipText1, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String jobs, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(jobs, primary, height: 7, isPrimaryCard: isPrimaryCard),
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return InkWell(

      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
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

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
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
          currentIndex: 0,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.person),
          ],
          onTap: (index) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              SizedBox(height: 20),
              _categoryRowA(LightColor.purple, LightColor.darkpurple, context),
              SizedBox(height: 20),
              _categoryRowB("Featured", Colors.white, Colors.white, context),
              _featuredRowA(context),
              SizedBox(height: 0),
              _categoryRowB(
                  "Jobs", LightColor.purple, LightColor.darkpurple, context),
              _featuredRowB(context),
              SizedBox(height: 0),
              _categoryRowC(
                  "Opporutunities", LightColor.purple, LightColor.darkpurple, context),
              _featuredRowC(context),
            ],
          ),
        )));
  }
}

_launchURL(var learnmore) async {
  var url = "$learnmore";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}