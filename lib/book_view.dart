
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
  // String url = "http://www.pdf995.com/samples/pdf.pdf";
  String pdfasset = "assets/sample.pdf";
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

    final doc = await PDFDocument.fromAsset("assets/${dn.data["crawl"]}.pdf");
    final nameAppBar = dn.data["title"];
    setState(() {
      _nameAppBar = nameAppBar;
      _doc=doc;
      _loading = false;
    });
  }
  /*
  * FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  * */

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