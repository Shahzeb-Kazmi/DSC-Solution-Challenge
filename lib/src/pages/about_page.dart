import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget{
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

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
                child: Column(
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
                            color: Colors.purple[50],
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
                                    Text('Our Purpose', style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text("Tulba is the brainchild of a group of undergraduate students who were willing to defy norms and take on the challenge of solving the issue of student unemployment. An issue which has seen students facing troubles in terms of financing their personal projects. Student employment is considered a sort of taboo in some societies, with students working to earn a living looked down upon. \n\nAs part of Developer Student Clubs, UET Taxila students have developed the platform Tulba which connects students with the right opportunities. It helps the local businesses acquire the best of minds and individuals who satisfy their vacancy. \n\nThis is the first step in eradicating student unemployment.",
                                  style: TextStyle(fontSize: 17), textAlign: TextAlign.justify,),
                                SizedBox(height: 20,),
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/tulba-adf4f.appspot.com/o/opportunities%2Fgoogledev.png?alt=media&token=8e9c941f-df8a-4a66-abcd-7fe08a333993'),
                                      backgroundColor: Colors.transparent,
                                      radius: 28,
                                    ),
                                    SizedBox(width: 20,),
                                    Flexible(
                                      child: Text('Developer Student Clubs UET Taxila', style:
                                      TextStyle(fontSize: 13,
                                      fontWeight: FontWeight.w600),),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                    ),
                      ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
