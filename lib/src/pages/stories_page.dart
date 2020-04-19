import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_course/models/job.dart';

class Stories extends StatefulWidget{
  @override
  _StoriesState createState() => _StoriesState();
}

final _firestore = Firestore.instance;

class _StoriesState extends State<Stories> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('stories').snapshots(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
                        );
                      }
                      final stories = snapshot.data.documents;
                      List <StoryModel> storyList = [];
                      int index;
                      for (var story in stories) {
                        final content = story.data['content'];

                        final storyData = StoryModel(
                            story : content,
                        );

                        storyList.add(storyData);
                      }
                      return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 11.0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('About Us', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),),
                              Hero(
                                tag: 'tulbalogo',
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'images/Tulba - Copy.png'),
                                  radius: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 11,
                        ),

                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(9.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Our Superstars!', style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    child: Center(child: Text(storyList[0].story, )),
                                    height: 300,
                                    width: 500,
                                    margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    child: Center(child: Text(storyList[1].story)),
                                    height: 300,
                                    width: 500,
                                    margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    child: Center(child: Text(storyList[2].story,),),
                                    height: 300,
                                    width: 500,
                                    margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
