import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_course/models/job.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_course/models/user.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;


class FeaturedScreen extends StatefulWidget {
  FeaturedScreen({@required this.index});
  final int index;

  @override
  State<StatefulWidget> createState() {
    return FeaturedScreenState(
      index: this.index,
    );
  }

}

class FeaturedScreenState extends State<FeaturedScreen> {
  FeaturedScreenState({@required this.index});
  final int index;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    jobsStream();
  }

  void jobsStream() async{
    await for (var snapshot in _firestore.collection('featured').snapshots()){
      for(var job in snapshot.documents){
        print(job.data);
      }
    }
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/tulba-adf4f.appspot.com/o/backgrounds%2Fbackground5.jpg?alt=media&token=bb6e9b54-6cd9-42dc-b037-fc0bfec7ed1b",
              fit: BoxFit.cover,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height / 1.6,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('featured').snapshots(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
                          );
                        }
                        final jobs = snapshot.data.documents;
                        List <FeaturedJobModel> jobList = [];
                        for (var job in jobs) {
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
                        return StreamBuilder<QuerySnapshot>(
                            stream: _firestore.collection('userprofile').snapshots(),
                            builder: (context, snapshot){
                              if(!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
                                );
                              }
                              final userprofile = snapshot.data.documents;
                              List <UserModel> userInfo = [];
                              int uindex;
                              for (var profile in userprofile) {
                                final name = profile.data['name'];
                                final profileimg = profile.data['profileimage'];
                                final cgpa = profile.data['cgpa'];
                                final majorsubject = profile.data['majorsubject'];
                                final university = profile.data['university'];
                                final degreestat = profile.data['degreestat'];
                                final linkedin = profile.data['linkedin'];
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
                                  linkedin: linkedin,
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
                                  uindex = uIndex;
                                }

                                userInfo.add(userData);
                              }
                              return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          jobList[index].title,
                                          style: Theme.of(context).textTheme.headline5,
                                        ),
                                        Text(
                                          jobList[index].location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .apply(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          jobList[index].image),
                                      radius: 30.0,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Text(
                                  "Overview",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  jobList[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .apply(color: Colors.grey),
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Job Type:",
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      jobList[index].type,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .apply(color: Colors.grey),
                                      maxLines: 3,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "Job Hours:",
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      jobList[index].hours,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .apply(color: Colors.grey),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Text(
                                  "Job Company",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  jobList[index].company,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .apply(color: Colors.grey),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  "Job Salary",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  jobList[index].salary,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .apply(color: Colors.grey),
                                  maxLines: 3,
                                ),
                                SizedBox(height:  MediaQuery.of(context).size.height /12),
                                Container(
                                  width: MediaQuery.of(context).size.height * .7,
                                  height: 45,
                                  child: RaisedButton(
                                    child: Text(
                                      "Apply",
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .apply(color: Colors.black, fontSizeFactor: 1.2),
                                    ),
                                    color: Colors.amber,
                                    onPressed: () async {
                                      final Email email = Email(
                                        body: 'I\'m applying for a job through the Tulba app! Below is my profile: \n\n- Name: ' + userInfo[uindex].name +
                                            ',\n - University: ' + userInfo[uindex].university + ',\n - School Email: ' + loggedInUser.email + ',\n - Degree: ' + userInfo[uindex].degreestat +
                                            ',\n - Major: ' + userInfo[uindex].majorsubject + ',\n - CGPA: ' + userInfo[uindex].cgpa.toStringAsFixed(2)
                                             + ',\n - Skills: ' + userInfo[uindex].skill1 + ', ' + userInfo[uindex].skill2 + ', ' + userInfo[uindex].skill3 + ', ' +
                                            userInfo[uindex].skill4 + ', ' + userInfo[uindex].skill5 + ', ' + userInfo[uindex].skill6  + ',\n\n - LinkedIn: ' + userInfo[uindex].linkedin,
                                        subject: 'Applying for ' + jobList[index].company + ', Job: ' + jobList[index].title,
                                        recipients: ['tulbaincofficial@gmail.com'],
                                        isHTML: false,
                                      );
                                      await FlutterEmailSender.send(email);
                                      print('pressed!');
                                    },
                                  ),
                                )
                              ],
                            );
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}