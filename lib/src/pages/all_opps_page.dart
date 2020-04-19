import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/job_container.dart';
import 'job_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_course/models/job.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = Firestore.instance;

class AllOpps extends StatefulWidget{
  @override
  _AllOppsState createState() => _AllOppsState();
}

class _AllOppsState extends State<AllOpps> {

  @override
  void initState() {
    super.initState();

    oppsStream();
  }

  void oppsStream() async{
    await for (var snapshot in _firestore.collection('opportunities').snapshots()){
      for(var opp in snapshot.documents){
        print(opp.data);
      }
    }
  }

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
                          Text('All Opportunities', style: TextStyle(
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

                    StreamBuilder<QuerySnapshot>(
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
                        return Expanded (
                          child: ListView.builder(
                            itemCount: oppList.length,
                            itemBuilder: (ctx, i) {
                              final tapIndex = i;
                              return ListTile(
                                title: OppContainer(
                                  description: oppList[i].description,
                                  imageUrl: oppList[i].imageUrl,
                                  learnmore: oppList[i].learnmore,
                                  title: oppList[i].title,
                                  organisation: oppList[i].organisation,
                                  type: oppList[i].type,
                                  name: oppList[i].name,
                                  onTap: () {
                                    onTap: _launchURL(oppList[i].learnmore);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
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

_launchURL(var learnmore) async {
  var url = "$learnmore";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}