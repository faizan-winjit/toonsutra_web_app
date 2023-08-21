import 'dart:js';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'comicdetails.dart';

void main() {
  runApp(MaterialApp(
    title: "Toonsutra - World's Leading Webtoons Platform",
    initialRoute: '/',
    onGenerateRoute: (settings) {
      if (settings.name!.startsWith('/comic/')) {
        // Extract the comic ID from the URL path segment
        final comicID = settings.name!.split('/').last;

        // Return MaterialPageRoute with FirstRoute widget
        return MaterialPageRoute(builder: (context) => ComicRoute(comicID));
      }
      // Handle other routes
      return MaterialPageRoute(builder: (context) => DefaultRoute());
    },
  ));
}

class ComicRoute extends StatelessWidget {
  String comicID;
  // Creating its constructor
  ComicRoute(this.comicID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComicDetails(comicID),
      drawer: Drawer(
        child: ToonSutraDrawer(),
      ),
    );
  }
}

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      body: ComicDetails('288'),
      drawer: Drawer(
        child: ToonSutraDrawer(),
      ),
    );
  }
}
