import 'dart:async';
import 'package:truyenco/book_shelf.dart';
import 'package:flutter/material.dart';
import 'package:truyenco/icons.dart';

void main() => runApp(new BookReaderApp());

class BookReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Truyển cổ',
      home: new BookReaderHomePage(),
      theme: new ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class BookReaderHomePage extends StatefulWidget {
  @override
  _BookReaderHomePageState createState() => new _BookReaderHomePageState();
}

class _BookReaderHomePageState extends State<BookReaderHomePage> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  String mNong = "M'nông";


  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    animation = new Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          color: Colors.blue[900],
          child: new Stack(
            children: <Widget>[
              new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Hero(
                        tag: 'image-hero',
                        child: new Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: new Image.asset('assets/images/logo.png',
                              width: 200.0, height: 200.0),
                        )),
                    new Hero(
                        tag: 'hero-text',
                        child: new Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: new Text('Truyện cổ $mNong',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                        )),
                    new Opacity(
                      opacity: animation.value,
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: new ClipRRect(
                          borderRadius: new BorderRadius.circular(50.0),
                          child: new MaterialButton(
                            minWidth: 150.0,
                            onPressed: (){
                              controller.forward();
                              new Future.delayed(new Duration(milliseconds: 250)).then((_) =>
                                  Navigator.of(context).pushReplacement(new MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return new BookShelf();
                                      }
                                  )));
                            },
                            color: Colors.white,
                            child: new Text('Tìm hiểu ngay',
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

