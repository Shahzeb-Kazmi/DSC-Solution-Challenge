import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/job_container.dart';
import 'job_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_course/models/job.dart';

final _firestore = Firestore.instance;

class AllJobs extends StatefulWidget{
  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {

  @override
  void initState() {
    super.initState();

    jobsStream();
  }

  void jobsStream() async{
    await for (var snapshot in _firestore.collection('jobs').snapshots()){
      for(var job in snapshot.documents){
        print(job.data);
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
                          Text('All Jobs', style: TextStyle(
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
                         return Expanded (
                            child: ListView.builder(
                            itemCount: jobList.length,
                            itemBuilder: (ctx, i) {
                              final tapIndex = i;
                              return ListTile(
                                title: JobContainer(
                                  description: jobList[i].description,
                                  iconUrl: jobList[i].iconUrl,
                                  location: jobList[i].location,
                                  salary: jobList[i].salary,
                                  title: jobList[i].title,
                                  company: jobList[i].company,
                                  type: jobList[i].type,
                                  hours: jobList[i].hours,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        print(i);
                                        return DetailsScreen(index: i);
                                        },
                                    ),
                                  ),
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
