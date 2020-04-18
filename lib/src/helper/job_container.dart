import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobContainer extends StatelessWidget {
  const JobContainer({
    Key key,
    @required this.iconUrl,
    @required this.title,
    @required this.location,
    @required this.description,
    @required this.salary,
    @required this.onTap,
    @required this.company,
    @required this.hours,
    @required this.type,
  }) : super(key: key);
  final String iconUrl, title, location, description, salary, company, hours, type;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(225,226, 244, 10),
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    "$iconUrl",
                    height: 71,
                    width: 71,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$title",
                        style: TextStyle(color: Color.fromRGBO(148, 153, 219, 10), fontSize: 22, fontWeight: FontWeight.w600),
                      ),

                      Text(
                        "$company",
                        style: Theme.of(context).textTheme.subtitle2.apply(
                          color: Colors.black54,
                        ),),

                      SizedBox(height: 2,),

                      Text(
                        "$location",
                        style: Theme.of(context).textTheme.subtitle2.apply(
                          color: Color.fromRGBO(148, 153, 219, 10),
                        ),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Text(
              "$description",
              style:
              Theme.of(context).textTheme.bodyText2.apply(color: Color.fromRGBO(148, 153, 219, 10), fontSizeFactor: 1),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "$salary",
                  style:
                  Theme.of(context).textTheme.subtitle1.apply(fontWeightDelta: 2, color: Colors.deepPurple),
                ),
                Text(
                "Hours: $hours",
                style:
                Theme.of(context).textTheme.subtitle1.apply(fontWeightDelta: 1, color: Colors.black, fontSizeFactor: 0.8),)
              ],
            )
          ],
        ),
      ),
    );
  }
}