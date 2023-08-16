import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class Data {
  static Map<String, dynamic> result = {'': ''};
}

class DemoWidget2 extends StatefulWidget {
  @override
  DemoWidget2State createState() => DemoWidget2State();
}

class DemoWidget2State extends State<DemoWidget2> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    apicall(); // Call your API fetching method
  }

  Future<void> apicall() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"comic_id": 288, "language_id": 2});
    var dio = Dio();
    var response = await dio.request(
      'https://api.toonsutra.com/api/v1.0/appUser/getBannerComicWL',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      int status = jsonResponse['statusCode'];
      Map<String, dynamic> result = jsonResponse['result'];
      //   setState(() {
      Data.result = jsonResponse['result'];
      // _isDataLoaded = true;
      // });
      setState(() {
        _isDataLoaded = true;
      });
      //print(comic_name);
      //print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDataLoaded) {
      return Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    }

    return Column(
      children: [
        Text(Data.result.toString()),
      ],
    );
  }
}










/*

class DemoWidget extends StatefulWidget {
  DemoWidgetState createState() => DemoWidgetState();
}

class DemoWidgetState extends State<DemoWidget> {
  String comic_name = 'Initial Name';
  initState() {
    super.initState();
    //  apicall();
  }

  Future<void> apicall() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"comic_id": 289, "language_id": 2});
    var dio = Dio();
    var response = await dio.request(
      'https://api.toonsutra.com/api/v1.0/appUser/getBannerComicWL',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      int status = jsonResponse['statusCode'];
      Map<String, dynamic> result = jsonResponse['result'];
      setState(() {
        comic_name = result['name'];
      });
      print(comic_name);
      //print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://toonsutra-assets.s3.ap-south-1.amazonaws.com/comic/thumbnail/comic-1686045024964.jpeg");
  }
}




*/ 












/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DemoWidget extends StatefulWidget {
  DemoWidgetState createState() => DemoWidgetState();
}

class DemoWidgetState extends State<DemoWidget> {
  int comic_id = 289;
  int language_id = 2;
  String comic_name = 'Initial State';
  String comic_thumbnail = 'Initial Thumbnail';

  @override
  void initState() {
    // TODO: implement initState
    apicall();
    super.initState();
  }

  Future<void> apicall() async {
    String response1 = '';
    var headers = {'': '', 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api.toonsutra.com/api/v1.0/appUser/getBannerComicWL'));
    request.body =
        json.encode({"comic_id": comic_id, "language_id": language_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('API Call Made');
      response1 = await response.stream.bytesToString();
      dynamic jsonResponse = json.decode(response1);

// Access the embedded JSON properties
      int status = jsonResponse['statusCode'];
      Map<String, dynamic> result = jsonResponse['result'];

      setState(() {
        this.comic_name = result['name'];
        this.comic_thumbnail = result['comic_thumbnail'];
      });

      print('Name: $comic_name');
      print('Comic Thumbnail: $comic_thumbnail');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(comic_thumbnail),
      ),
    );
  }
}

void main() async {
  print("Hello World");
}

class OnLoadApiCall {
  int comic_id = 0;
  int language_id = 0;
  String comic_name = 'Initial State';
  String comic_thumbnail = '';

  OnLoadApiCall() {
    this.comic_id = 289;
    this.language_id = 2;
  }

  Future<void> apicall() async {
    String response1 = '';
    var headers = {'': '', 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api.toonsutra.com/api/v1.0/appUser/getBannerComicWL'));
    request.body =
        json.encode({"comic_id": comic_id, "language_id": language_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('API Call Made');
      response1 = await response.stream.bytesToString();
      dynamic jsonResponse = json.decode(response1);

// Access the embedded JSON properties
      int status = jsonResponse['statusCode'];
      Map<String, dynamic> result = jsonResponse['result'];

      this.comic_name = result['name'];
      this.comic_thumbnail = result['comic_thumbnail'];
      print('Name: $comic_name');
      print('Comic Thumbnail: $comic_thumbnail');
    } else {
      print(response.reasonPhrase);
    }
  }
}
*/ 