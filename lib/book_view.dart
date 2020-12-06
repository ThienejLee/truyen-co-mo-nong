
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class BookView extends StatefulWidget {
  final String bookId;
  BookView(this.bookId);
  @override
  _BookViewState createState() => _BookViewState();
}

Firestore database = Firestore.instance;

class _BookViewState extends State<BookView> {
  PDFDocument _doc;
  bool _loading;
  String _nameAppBar = "";
  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });

    DocumentSnapshot dn = await database.collection("MyBook").document(widget.bookId).get();

    final doc = await PDFDocument.fromAsset("assets/${dn.data["crawl"].toString().toLowerCase()}");
    print("assets/data/${dn.data["crawl"]}");
    final nameAppBar = dn.data["title"];
    setState(() {
      _nameAppBar = nameAppBar;
      _doc=doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_nameAppBar),),
      body:FutureBuilder(
          future: database.collection("MyBook").document(widget.bookId).get(),
          builder: (context, dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return CircularProgressIndicator();
            }
            // _initPdf("assets/${dataSnapshot.data["crawl"]}.pdf");
            return _loading ? Center(child: CircularProgressIndicator(),) :
            PDFViewer(document: _doc,
              indicatorBackground: Colors.red,
              // showIndicator: false,
              // showPicker: false,
            );
          })
    );
  }
}