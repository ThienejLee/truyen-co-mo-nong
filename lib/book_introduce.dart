import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truyenco/book_view.dart';

class BookIntroduce extends StatelessWidget {
  PageController pageController = new PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        height: 380.0,
        width: double.infinity,
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("Content")
                .document("55MFVHprdNSMoM8PxJ1E")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data['title'], textAlign: TextAlign.center, style: TextStyle(fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold),),
                    Text('${snapshot.data['description']}', style: TextStyle(fontSize: 18),),
                  ],

                ),
              );
            }),
      ),
    );
  }
}
