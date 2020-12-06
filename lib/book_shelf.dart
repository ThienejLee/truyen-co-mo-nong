import 'package:truyenco/book_introduce.dart';
import 'package:truyenco/book_row.dart';
import 'package:flutter/material.dart';
import 'package:truyenco/book_view.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf> with TickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: "Truyện",),
    Tab(text: "Giới thiệu"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0)),
                color: Colors.white,
              ),
              child:
              new Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 48,
                  bottom: TabBar(
                    labelColor: Colors.black87,
                    controller: _tabController,
                    tabs: myTabs,
                  ),
                ),
                body: new TabBarView(
                  controller: _tabController,
                  children: myTabs.map((Tab tab) {
                    return tab.text == "Truyện" ? BookRow(): BookIntroduce();
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
