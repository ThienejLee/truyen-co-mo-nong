import 'package:truyenco/book_row.dart';
import 'package:flutter/material.dart';

class BookShelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.blue[900],
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Hero(
                tag: 'image-hero',
                child: new Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: new Image.asset('assets/images/logo.png',
                      width: 200.0, height: 200.0),
                )),
            new Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: new Text('Khám phá. Học hỏi. Bảo tồn.',
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w200)),
            ),
            new Container(
              height: 450.0,
              width: double.infinity,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(topLeft: const Radius.circular(30.0), topRight: const Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: new DefaultTabController(
                length: 2,
                child: new Column(
                  children: <Widget>[
                    new TabBar(
                      indicatorWeight: 2.0,
                      isScrollable: true,
                      labelColor: Colors.black87,
                      tabs: <Widget>[
                        new Tab(text: 'Truyện'),
                        new Tab(text: 'Giới thiệu'),
                      ],
                    ),
                    new BookRow(),
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
