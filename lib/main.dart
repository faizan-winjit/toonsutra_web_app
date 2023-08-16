import 'dart:js';

import 'package:flutter/material.dart';
import 'package:toonsutra_web_app/comicdetailsmodel.dart';
import 'comicdetailsold.dart';
import 'DownloadAd.dart' as Dow;

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    initialRoute: '/',
    onGenerateRoute: (settings) {
      if (settings.name!.startsWith('/comic/')) {
        // Extract the comic ID from the URL path segment
        final comicID = settings.name!.split('/').last;

        // Return MaterialPageRoute with FirstRoute widget
        return MaterialPageRoute(builder: (context) => FirstRoute(comicID));
      }
      // Handle other routes
      return MaterialPageRoute(builder: (context) => SecondRoute());
    },
  ));
}

class FirstRoute extends StatelessWidget {
  String comicID;
  // Creating its constructor
  FirstRoute(this.comicID);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return Scaffold(
            body: Center(
          child: SingleChildScrollView(
            child: Iphone142Widget(),
          ),
        ));
      } else {
        return Scaffold(
            body: Center(
          child: ComicDetails(comicID),
        ));
      }
    });
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Dow.ComicDetails());
  }
}
