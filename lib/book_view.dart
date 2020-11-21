import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  final String bookId;
  BookView(this.bookId);
  @override
  _BookViewState createState() => _BookViewState();
}

Firestore database = Firestore.instance;

class _BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Truyện")),
        body: FutureBuilder(
            future: database.collection("MyBook").document(widget.bookId).get(),
            builder: (context, dataSnapshot) {
              if (!dataSnapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                children: <Widget>[
                  Text(dataSnapshot.data["title"],),
                  Text(dataSnapshot.data["description"],),
                  Text(dataSnapshot.data["author"],),

                ],
              );
            }));
  }
}
