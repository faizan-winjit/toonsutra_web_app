/*
Widget No 0: ComicDetails (A Combination of all below mentioned widgets to create the Comic Details Web View Page)
Widget No 1: ComicDetailsCard
Widget No 2: ChapterBox
Widget No 3: ChapterBoxGrid
Widget No 4: DownloadAd
Widget No 5: ToonSutra NavBar
*/

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'comicdetailsmodel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class apiData {
  static Map<String, dynamic> result = {'': ''};
}

class ComicDetails extends StatefulWidget {
  String comicID;
  ComicDetails(this.comicID);
  ComicDetailsState createState() => ComicDetailsState(comicID);
}

class ComicDetailsState extends State<ComicDetails> {
  String comicID;
  ComicDetailsState(this.comicID);
  bool _isDataLoaded = false;
  @override
  void initState() {
    super.initState();
    apicall(); // Call your API fetching method
  }

  Future<void> apicall() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"comic_id": comicID, "language_id": 2});
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
      apiData.result = jsonResponse['result'];
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

    return Container(
        width: 1140,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ToonSutraNavBar(),
              SizedBox(height: 25.0),
              ComicDetailsCard(),
              SizedBox(height: 25.0),
              DownloadAd(),
              SizedBox(height: 25.0),
              Text(
                'Chapters',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 25.0),
              ChapterBoxGrid(),
              SizedBox(height: 25.0),
              // Text('ToonSutra 2023'),
              ElevatedButton(
                onPressed: () {
                  _showFullScreenModal(context);
                },
                child: Text('Show Full-Screen Modal'),
              ),
            ],
          ),
        ));
  }
}

class ComicDetailsCard extends StatefulWidget {
  @override
  ComicDetailsCardState createState() => ComicDetailsCardState();
}

class ComicDetailsCardState extends State<ComicDetailsCard> {
  String comic_name = apiData.result['name'];
  String author = apiData.result['author'];
  String description = apiData.result['description'];
  String comic_thumbnail = apiData.result['comic_thumbnail'];
  var totalLikes = apiData.result['totalLikes'] ?? 'Not Known';
  String averageRating = apiData.result['averageRating'];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1140,
        height: 254,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 360,
                  height: 254,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                        begin:
                            Alignment(0.041685800999403, -0.9855149388313293),
                        end:
                            Alignment(0.9855149388313293, 0.031459104269742966),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 1),
                          Color.fromRGBO(0, 0, 0, 0)
                        ]),
                    image: DecorationImage(
                      image: NetworkImage(comic_thumbnail),
                    ),
                  ))),
          Positioned(
              top: 9.1865234375,
              left: 437.1904296875,
              child: Text(
                comic_name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.2),
              )),
          Positioned(
              top: 41.4169921875,
              left: 437.1904296875,
              child: Container(
                  width: 118.6103515625,
                  height: 18,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          author,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                      top: 2.84375,
                      left: 106.2978515625,
                      child: Container(),
                    ),
                  ]))),
          Positioned(
              top: 14.7626953125,
              left: 912.865234375,
              child: Container(
                  width: 227.134765625,
                  height: 24.392578125,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 227.134765625,
                            height: 24.392578125,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 107.177734375,
                                      height: 24,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 107.177734375,
                                                height: 24,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 3.31640625,
                                                      left: 31.177734375,
                                                      child: Text(
                                                        '$averageRating Ratings',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontFamily:
                                                                'Space Grotesk',
                                                            fontSize: 14,
                                                            letterSpacing:
                                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1),
                                                      )),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child:
                                                        Icon(Icons.star_border),
                                                  ),
                                                ]))),
                                      ]))),
                              Positioned(
                                  top: 0.392578125,
                                  left: 132.939453125,
                                  child: Container(
                                      width: 94.1953125,
                                      height: 24,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 94.1953125,
                                                height: 24,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 2.609375,
                                                      left: 31.1953125,
                                                      child: Text(
                                                        '$totalLikes Likes',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    237,
                                                                    28,
                                                                    36,
                                                                    1),
                                                            fontFamily:
                                                                'Space Grotesk',
                                                            fontSize: 14,
                                                            letterSpacing:
                                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1),
                                                      )),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Color.fromRGBO(
                                                          237, 28, 36, 1),
                                                    ),
                                                  ),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
            top: 102.7646484375,
            left: 437.1904296875,
            child: Container(
              width: 700, // Set a maximum width for the text to wrap
              child: Text(
                description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(63, 63, 63, 1),
                  fontFamily: 'DM Sans',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5714285714285714,
                ),
              ),
            ),
          ),
          Positioned(
              top: 65.4912109375,
              left: 437.1904296875,
              child: Text(
                '22k Reads',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(176, 176, 176, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 229,
              left: 437.1904296875,
              child: Container(
                  width: 71.34033203125,
                  height: 21,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            //  width: 20,
                            // height: 21,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                //  top: 1.751922607421875,
                                // left: 1.6657075881958008,
                                child: Icon(Icons.share),
                              ),
                            ]))),
                    Positioned(
                        top: 1.36895751953125,
                        left: 25.34033203125,
                        child: Text(
                          'SHARE',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
        ]));
  }
}

class ChapterBox extends StatefulWidget {
  String name;
  String chapter_thumbnail;
  String publishDate;
  String totalChapterLike;
  String chapter_num;

  ChapterBox(this.name, this.chapter_thumbnail, this.publishDate,
      this.totalChapterLike, this.chapter_num);
  @override
  ChapterBoxState createState() => ChapterBoxState(
      name, chapter_thumbnail, publishDate, totalChapterLike, chapter_num);
}

class ChapterBoxState extends State<ChapterBox> {
  String name;
  String chapter_thumbnail;
  String publishDate;
  String totalChapterLike;
  String chapter_num;

  ChapterBoxState(this.name, this.chapter_thumbnail, this.publishDate,
      this.totalChapterLike, this.chapter_num);

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Chpt1Widget - GROUP

    return Container(
        width: 358.326171875,
        height: 99.96682739257812,
        child: Stack(children: <Widget>[
          Positioned(
              top: 99.966796875,
              left: 0,
              child: Transform.rotate(
                angle: -0.000005008956130975318 * (math.pi / 180),
                child: Divider(
                    color: Color.fromRGBO(227, 227, 227, 1), thickness: 1),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 358.326171875,
                  height: 77.96690368652344,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0.46875,
                        left: 0,
                        child: Container(
                            width: 290.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 290.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 290.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top:
                                                          0.00010824203491210938,
                                                      left: 93.34983825683594,
                                                      child: Container(
                                                          width:
                                                              197.0001678466797,
                                                          height: 77.498046875,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top: 0,
                                                                    left:
                                                                        0.00016498565673828125,
                                                                    child: Text(
                                                                      name,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                          fontFamily:
                                                                              'DM Sans',
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          height:
                                                                              1),
                                                                    )),
                                                                Positioned(
                                                                    top:
                                                                        59.498046875,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 46,
                                                                        height: 18,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 20,
                                                                                        child: Text(
                                                                                          totalChapterLike,
                                                                                          textAlign: TextAlign.left,
                                                                                          style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                        )),
                                                                                    Positioned(
                                                                                      top: 0,
                                                                                      left: 0,
                                                                                      child: Flexible(
                                                                                        child: Icon(
                                                                                          Icons.favorite,
                                                                                          color: Color.fromRGBO(107, 107, 107, 1),
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ]))),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 23,
                                                                    left: 0,
                                                                    child: Text(
                                                                      publishDate,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              127,
                                                                              125,
                                                                              125,
                                                                              1),
                                                                          fontFamily:
                                                                              'DM Sans',
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          height:
                                                                              1),
                                                                    )),
                                                              ]))),
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width: 77,
                                                          height: 77.4970703125,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(4),
                                                              topRight: Radius
                                                                  .circular(4),
                                                              bottomLeft: Radius
                                                                  .circular(4),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            color: Color.fromRGBO(
                                                                0,
                                                                0,
                                                                0,
                                                                0.6000000238418579),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    chapter_thumbnail),
                                                                fit: BoxFit
                                                                    .fitWidth),
                                                          ))),
                                                ]))),
                                      ]))),
                            ]))),
                    Positioned(
                        top: 0,
                        left: 312.326171875,
                        child: Container(
                            width: 46,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(244, 243, 243, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                          width: 1.1810990571975708,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(46, 46)),
                                      ))),
                              Positioned(
                                  top: 10.80859375,
                                  left: 10.8955078125,
                                  child: Icon(Icons.lock)),
                            ]))),
                  ]))),
        ]));
  }
}

class ChapterBoxGrid extends StatelessWidget {
  var chapters = apiData.result['chapters'];
  var comic_name = apiData.result['name'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1140,
      // height: 100,
      child: Column(
        children: [
          Wrap(
            spacing: 1, // Horizontal spacing
            runSpacing: 1, // Vertical spacing
            children: chapters.map<Widget>((chapter) {
              String name = chapter['name'];
              String chapter_thumbnail = chapter['chapter_thumbnail'] ?? 'abcd';
              String publishDate = chapter['publishDate'] ?? 'Not Known';
              String totalChapterLike = chapter['totalChapterLike'] ?? 'abcd';
              String chapter_num = chapter['chapter_num'] ?? 'abcd';
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChapterPreview(comic_name, chapter)),
                    );
                  },
                  child: ChapterBox(
                    name,
                    chapter_thumbnail,
                    publishDate,
                    totalChapterLike,
                    chapter_num,
                  ));
            }).toList(),
          )
        ],
      ),
    );

    /* return Container(
      width: 1140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChapterBox(),
              ChapterBox(),
              ChapterBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChapterBox(),
              ChapterBox(),
              ChapterBox(),
            ],
          ),
        ],
      ),
    ); */
  }
}

class DownloadAd extends StatefulWidget {
  @override
  DownloadAdState createState() => DownloadAdState();
}

class DownloadAdState extends State<DownloadAd> {
  String comic_name = apiData.result['name'];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1140,
        height: 227,
        color: Color.fromRGBO(255, 232, 233, 1),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 400,
                      child: Text(
                        'Download and read $comic_name on Toonsutra app today!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'DM Sans',
                            fontSize: 26,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1.3846153846153846),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/googleplay.png'),
                        Image.asset('assets/images/appstore.png'),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 150),
                Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Positioned(
                    right: 0,
                    child: Image.asset('assets/images/mobile.png'),
                    /* child: CachedNetworkImage(
                      /* imageUrl:
                          "https://faizan-flutter-app-api-winjijt.s3.amazonaws.com/a.jpg",*/
                      imageUrl:
                          "https://toonsutra-assets.s3.ap-south-1.amazonaws.com/comic/thumbnail/comic-1686045024964.jpeg",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Text(error.toString()),
                    ), */
                  ),
                )
              ],
            )));
  }
}

class ToonSutraNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1139.5482177734375,
        height: 45,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 1139.5482177734375,
                  height: 45,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 45,
                          height: 45,
                          /*  decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets\images\toonsutra_logo.png'),
                                  fit: BoxFit.fitWidth),
                            )*/
                          child:
                              Image.asset('assets/images/toonsutra_logo.png'),
                        )),
                    Positioned(
                        top: 13.5,
                        left: 664.5482177734375,
                        child: Text(
                          'Home',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(94, 94, 94, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 13.5,
                        left: 733.5482177734375,
                        child: Text(
                          'FAQ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(94, 94, 94, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 13.5,
                        left: 790.5482177734375,
                        child: Text(
                          'Privacy policy',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(94, 94, 94, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 13.5,
                        left: 911.5482177734375,
                        child: Text(
                          'Terms & conditions',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(94, 94, 94, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 13.5,
                        left: 1067.5482177734375,
                        child: Text(
                          'Contact us',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(94, 94, 94, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
        ]));
  }
}

void _showFullScreenModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 20,
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Positioned(
                    left: 0,
                    child: Text(
                      'ASTRA The IMMORTAL/Ch1',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 800,
                    child: Image.network(
                        "https://toonsutra-assets.s3.ap-south-1.amazonaws.com/comic/chapter_split_images/comic_280_chapter_1827_slice0_1684057023387.jpg"),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            )),
      );
    },
  );
}

class ChapterPreview extends StatefulWidget {
  var comic_name;
  var chapter;

  ChapterPreview(this.comic_name, this.chapter);

  @override
  ChapterPreviewState createState() => ChapterPreviewState(comic_name, chapter);
}

class ChapterPreviewState extends State<ChapterPreview> {
  var comic_name;
  var chapter;

  ChapterPreviewState(this.comic_name, this.chapter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ToonSutraNavBar(),
              SizedBox(height: 25),
              Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  Text(
                    '$comic_name/',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(237, 28, 36, 1),
                      fontFamily: "DM Sans",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 31 / 24,
                    ),
                  ),
                  Text(
                    'Ch${chapter['chapter_num']}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(137, 137, 137, 1),
                      fontFamily: "DM Sans",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 31 / 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 10, // Horizontal spacing between items
                runSpacing: 0, // Vertical spacing between items
                children: chapter['chapter_split_arr']
                    .take(5)
                    .map<Widget>((entry) => Image.network(
                        entry['split_img_url'],
                        fit: BoxFit.cover))
                    .toList(),
              ),
              /*ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the modal
            },
            child: Text('Close'),
          ),*/
              SizedBox(height: 16),
              DownloadAd(),
            ],
          ),
        ),
      ),
    );
  }
}

class Iphone142Widget extends StatefulWidget {
  @override
  _Iphone142WidgetState createState() => _Iphone142WidgetState();
}

class _Iphone142WidgetState extends State<Iphone142Widget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Iphone142Widget - FRAME

    return Container(
        width: 390,
        height: 1705,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 17,
              left: 16,
              child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/toonsutra_logo.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 88.40234375,
              left: 16,
              child: Container(
                  width: 360,
                  height: 254,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                        begin:
                            Alignment(0.041685800999403, -0.9855149388313293),
                        end:
                            Alignment(0.9855149388313293, 0.031459104269742966),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 1),
                          Color.fromRGBO(0, 0, 0, 0)
                        ]),
                    image: DecorationImage(
                        image: AssetImage('assets/images/image1.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 363.775146484375,
              left: 16,
              child: Text(
                'Astra The Immortal',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.2),
              )),
          Positioned(
              top: 396.005615234375,
              left: 16,
              child: Container(
                  width: 118.6103515625,
                  height: 18,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Gayatri Banerjee',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                      top: 2.84375,
                      left: 106.2978515625,
                      child: Container(),
                    ),
                  ]))),
          Positioned(
              top: 495.658203125,
              left: 16,
              child: Container(
                  width: 350,
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(63, 63, 63, 1),
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.5714285714285714),
                  ))),
          Positioned(
              top: 420.079833984375,
              left: 16,
              child: Text(
                '22k Reads',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(176, 176, 176, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 627.03125,
              left: 16,
              child: Container(
                  width: 71.34033203125,
                  height: 21,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 20,
                            height: 21,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 1.751922607421875,
                                left: 1.6657075881958008,
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                ),
                              ),
                            ]))),
                    Positioned(
                        top: 1.36895751953125,
                        left: 25.34033203125,
                        child: Text(
                          'SHARE',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          Positioned(
            top: 670.0001220703125,
            left: 13.245842933654785,
            child: Image.asset(
              'assets/images/rectangle.png',
            ),
          ),
          Positioned(
              top: 772.509765625,
              left: 217.76556396484375,
              child: Container(
                  width: 18.248779296875,
                  height: 18.248779296875,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 18.248779296875,
                            height: 18.248779296875,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(children: <Widget>[]))),
                  ]))),
          Positioned(
              top: 808.7939453125,
              left: 18,
              child: Container(
                  width: 144,
                  height: 44,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 144,
                            height: 44,
                            decoration: BoxDecoration(),
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 0.96875,
                                left: 0,
                                child: Image.asset(
                                  'assets/images/googleplay.png',
                                ),
                              ),
                            ]))),
                  ]))),
          Positioned(
              top: 808.7939453125,
              left: 165.977294921875,
              child: Container(
                  width: 144,
                  height: 44,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 144,
                            height: 44,
                            decoration: BoxDecoration(),
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 0.96875,
                                left: 0.83203125,
                                child: Image.asset(
                                  'assets/images/appstore.png',
                                ),
                              ),
                            ]))),
                  ]))),
          Positioned(
              top: 680.55859375,
              left: 18,
              child: Container(
                  width: 300,
                  child: Text(
                    'Download and read Astra The Immortal on Toonsutra app today!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'DM Sans',
                        fontSize: 26,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.3846153846153846),
                  ))),
          Positioned(
              top: 945.7808837890625,
              left: 16.014892578125,
              child: Text(
                'Chapters',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'DM Sans',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 1001.4927978515625,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 285.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 285.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 285.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              285.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 192.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 1 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 1123.23876953125,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 289.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 289.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 289.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              289.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 196.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 2 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 1244.98486328125,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 289.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 289.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 289.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              289.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 196.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 3 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 1366.73095703125,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 290.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 290.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 290.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              290.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 197.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 4 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 1488.47705078125,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 289.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 289.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 289.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              289.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 196.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 5 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 1610.22314453125,
              left: 16,
              child: Container(
                  width: 358,
                  height: 99.49807739257812,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 99.498046875,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.000005008956130975318 * (math.pi / 180),
                          child: Divider(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              thickness: 1),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 290.3500061035156,
                            height: 77.49815368652344,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 290.3500061035156,
                                      height: 77.49815368652344,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 290.3500061035156,
                                                height: 77.49815368652344,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                          width:
                                                              290.3500061035156,
                                                          height:
                                                              77.49815368652344,
                                                          child: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                    top:
                                                                        0.00010824203491210938,
                                                                    left:
                                                                        93.34983825683594,
                                                                    child: Container(
                                                                        width: 197.0001678466797,
                                                                        height: 77.498046875,
                                                                        child: Stack(children: <Widget>[
                                                                          Positioned(
                                                                              top: 0,
                                                                              left: 0.00016498565673828125,
                                                                              child: Text(
                                                                                'Ch 6 - Astra The Immortal',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontFamily: 'DM Sans', fontSize: 16, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                          Positioned(
                                                                              top: 59.498046875,
                                                                              left: 0,
                                                                              child: Container(
                                                                                  width: 46,
                                                                                  height: 18,
                                                                                  child: Stack(children: <Widget>[
                                                                                    Positioned(
                                                                                        top: 0,
                                                                                        left: 0,
                                                                                        child: Container(
                                                                                            width: 46,
                                                                                            height: 18,
                                                                                            child: Stack(children: <Widget>[
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  left: 20,
                                                                                                  child: Text(
                                                                                                    '1.5k',
                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(color: Color.fromRGBO(107, 107, 107, 1), fontFamily: 'Space Grotesk', fontSize: 14, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                                                  )),
                                                                                              Positioned(
                                                                                                top: 2,
                                                                                                left: 0,
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Colors.grey[500],
                                                                                                  size: 15,
                                                                                                ),
                                                                                              ),
                                                                                            ]))),
                                                                                  ]))),
                                                                          Positioned(
                                                                              top: 23,
                                                                              left: 0,
                                                                              child: Text(
                                                                                '10 July 2023',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color.fromRGBO(127, 125, 125, 1), fontFamily: 'DM Sans', fontSize: 12, letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/, fontWeight: FontWeight.normal, height: 1),
                                                                              )),
                                                                        ]))),
                                                                Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Container(
                                                                        width: 77,
                                                                        height: 77.4970703125,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(4),
                                                                            topRight:
                                                                                Radius.circular(4),
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            bottomRight:
                                                                                Radius.circular(4),
                                                                          ),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.6000000238418579),
                                                                          image: DecorationImage(
                                                                              image: AssetImage('assets/images/image2.png'),
                                                                              fit: BoxFit.fitWidth),
                                                                        ))),
                                                              ]))),
                                                ]))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
            top: 27.5,
            left: 350,
            child: Container(),
          ),
        ]));
  }
}
