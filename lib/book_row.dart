import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truyenco/book_view.dart';

class BookRow extends StatelessWidget {
  PageController pageController = new PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 380.0,
        width: double.infinity,
        child: StreamBuilder(
            stream: Firestore.instance.collection("MyBook").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data.documents[index];
                          return Padding(
                              padding: EdgeInsets.all(9.0),
                              child: new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: new BorderRadius.circular(10.0),
                                  boxShadow: <BoxShadow>[
                                    new BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0,
                                        offset: new Offset(0.0, 2.0)),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Container(
                                        height: 220.0,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0)),
                                          child: new Image.network(document["url"],
                                              fit: BoxFit.cover),
                                        )),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10.0, top: 10.0),
                                      child: new Text(document["title"],
                                          style:
                                              const TextStyle(fontSize: 25.0),
                                          textAlign: TextAlign.right),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10.0),
                                      child: new Text(document["author"]),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      child: new ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                        child: new MaterialButton(
                                          minWidth: 70.0,
                                          onPressed: () {
                                            print(document.documentID);

                                            new Future.delayed(new Duration(
                                                    milliseconds: 250))
                                                .then((_) =>
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute<
                                                                Null>(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return BookView(
                                                          document.documentID);
                                                    })));
                                          },
                                          color: Colors.blue[900],
                                          child: new Text('Đọc truyện',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));

                  });
            }));
  }
}