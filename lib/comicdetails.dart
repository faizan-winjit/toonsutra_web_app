// Dependencies
// Flutter Material Package
import 'dart:js';

import 'package:flutter/material.dart';
// Dart Async for Asynchoronous Flow
import 'dart:async';
// Dart Conver to use json.convert to convert POST API body into json.
import 'dart:convert';
// Flutter Dio Package for API call
import 'package:dio/dio.dart';
// Dart HTML Package to use window.location.href so that we can use links inside our page and get the current url
import 'dart:html';
// Flutter Share Plus Package to use the inbuild share functionality of platforms.
import 'package:share_plus/share_plus.dart';
// Flutter Services package to use Clipboard.setData()
import 'package:flutter/services.dart';

// A class used to store the API Result Data
class apiData {
  static Map<String, dynamic> result = {'': ''};
}

// ComicDetails
// ID: 0
// Parent Widget of all widgets that make the Comic Details Page
// StatefulWidget ComicDetails which makes the API Call.
class ComicDetails extends StatefulWidget {
  var comicID;
  ComicDetails(this.comicID);
  @override
  ComicDetailsState createState() => ComicDetailsState(comicID);
}

class ComicDetailsState extends State<ComicDetails> {
  var comicID;
  ComicDetailsState(this.comicID);
  bool _isDataLoaded = false;
  @override
  void initState() {
    super.initState();
    apicall(); // API Fetching Method
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
      apiData.result = jsonResponse['result'];
      setState(() {
        _isDataLoaded = true;
      });
      print('API Call Sucessful, Data Loaded');
    } else {
      print('API Call Failed. Data Not Loaded');
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
    return ComicDetailsWidget();
  }
}

// Comic Details Widget- The Overall Widget making the entire ToonSutra Comic Details Page.
// ID:0
/* It consists of main 6 widgets:part 
1. NavBar
2. ComicDetailsCard
3. DownloadAd
4. ChapterBox
5. ChapterBoxGrid
6. ChapterPreview

*/
Widget ComicDetailsWidget() {
  // Data from API to be passed to various Widgets as Parameter
  var comic_name = apiData.result['name'] ?? 'Not Known';
  var author = apiData.result['author'] ?? 'Not Known';
  var description = apiData.result['description'] ?? 'Not Known';
  var comic_thumbnail = apiData.result['comic_thumbnail'] ?? 'Not Known';
  var totalLikes = apiData.result['totalLikes'] ?? '0';
  var averageRating = apiData.result['averageRating'] ?? '0.0';
  int comicID = apiData.result['id'] ?? 0;
  var chapters = apiData.result['chapters'];
  //-----------------------------------------------------------------

  return SingleChildScrollView(
    child: Center(
      child: FractionallySizedBox(
          widthFactor: 1588 / 1728,
          child: LayoutBuilder(builder: ((context, constraints) {
            double w = constraints.maxWidth;
            bool mobile = w < 1100 ? true : false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * (mobile ? 0.04722 : 0.0192)),
                NavBar(mobile),
                SizedBox(height: w * (mobile ? 0.0733 : 0.037)),
                ComicDetailsCard(mobile, comic_name, author, description,
                    comic_thumbnail, totalLikes, averageRating, comicID),
                SizedBox(height: w * (mobile ? 0.1121 : 0.020)),
                DownloadAd(mobile, comic_name),
                SizedBox(height: w * (mobile ? 0.123 : 0.0371)),
                Text(
                  "Chapters",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * (mobile ? 0.0666 : 0.0151),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                    // height: 17 / 24,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: w * (mobile ? 0.1075 : 0.0231)),
                ChapterBoxGrid(mobile, chapters, comic_name),
              ],
            );
          }))),
    ),
  );
}
//-------------------------------------------------------------------------------------------------

// Nav Bar Widget
/// This widget represents the navigation bar that contains links and icons
/// for various sections of the website. It adapts its layout and behavior
/// based on the device type (mobile or desktop).
///
/// The [mobile] parameter determines whether the navigation bar is optimized
/// for mobile devices or not.
///
/// The widget includes clickable links to different sections of the website,
/// such as Home, FAQ, Privacy Policy, Terms & Conditions, and Contact Us.
///
/// The links use the [window.location.href] method to redirect users to
/// the respective URLs.
///
/// On mobile devices, a "hamburger" icon is displayed, which when clicked,
/// opens the drawer to show the navigation links.
///
/// Usage:
/// ```dart
/// NavBar(mobile: true),
/// ```
Widget NavBar(bool mobile) {
  return AspectRatio(
    aspectRatio: (mobile ? 8 : 1588 / 50.23),
    child: LayoutBuilder(builder: (context, constraints) {
      double w = constraints.maxWidth;
      return Stack(
        children: [
          // ToonSutra Icon
          Positioned(
            left: 0,
            top: w * (mobile ? 0 : 0.0032),
            child: InkWell(
                onTap: () {
                  window.location.href = 'https://www.toonsutra.com/';
                },
                child: Image.asset(
                  'assets/images/toonsutra_logo.png',
                  width: w * (mobile ? 0.125 : 0.02833),
                  height: w * (mobile ? 0.125 : 0.02833),
                )),
          ),

          //-----------------------------------------------------------------------------
          // Home
          Positioned(
            top: 0,
            left: w * 0.698041562,
            child: Visibility(
              visible: !mobile,
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://www.toonsutra.com/';
                },
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.0088,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5f5f5f),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //-----------------------------------------------------------------------------
          // FAQ
          Positioned(
            top: 0,
            left: w * 0.741492443,
            child: Visibility(
              visible: !mobile,
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://toonsutra.in/faq_01/';
                },
                child: Text(
                  "FAQ",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.0088,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5f5f5f),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //-----------------------------------------------------------------------------
          // Privacy Policy
          Positioned(
            top: 0,
            left: w * 0.77738665,
            child: Visibility(
              visible: !mobile,
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://toonsutra.in/privacy-policy/';
                },
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.0088,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5f5f5f),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //-----------------------------------------------------------------------------
          // Terms & Conditions
          Positioned(
            top: 0,
            left: w * 0.853583123,
            child: Visibility(
              visible: !mobile,
              child: InkWell(
                onTap: () {
                  window.location.href =
                      'https://toonsutra.in/terms-and-conditions/';
                },
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.0088,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5f5f5f),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //-----------------------------------------------------------------------------
          // Contact Us
          Positioned(
            top: 0,
            left: w * 0.951819899,
            child: Visibility(
              visible: !mobile,
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://toonsutra.in/contact/';
                },
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.0088,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5f5f5f),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //-----------------------------------------------------------------------------
          // Hamburger/ Drawer
          Positioned(
            top: w * 0.029,
            left: w * 0.9277,
            child: Visibility(
              visible: mobile,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  size: w * 0.0666,
                ),
              ),
            ),
          ),
          //-----------------------------------------------------------------------------
        ],
      );
    }),
  );
}
//--------------------------------------------------------------------------------------

// ComicDetailsCard Widget
// ID: 2
// A Widget that shows various details of a comic including comic_name, author, no of reads (Unavailable right now)
// description, comic_thumbnail, likes, ratings and a share button that shares the current page link.
Widget ComicDetailsCard(mobile, comic_name, author, description,
    comic_thumbnail, totalLikes, averageRating, comicID) {
  var url = window.location.href;
  return AspectRatio(
    aspectRatio: mobile ? 360 / 559.63 : 1588 / 254,
    child: LayoutBuilder(builder: ((context, constraints) {
      double w = constraints.maxWidth;
      double h = constraints.maxHeight;
      return Container(
        width: w,
        height: h,
        child: Stack(
          children: [
            // Comic Thumbnail Image
            Positioned(
              left: 0,
              child: Container(
                height: (mobile ? 0.705 * w : h),
                width: (mobile ? 1 : 0.236) * w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    comic_thumbnail ?? "https://picsum.photos/200/300",
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------------------------
            // Comic Name
            Positioned(
              left: (mobile ? 0 : 0.255) * w,
              top: (mobile ? 0.7649 : 0.0057) * w,
              child: Text(
                '$comic_name',
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: w * (mobile ? 0.0555 : 0.0125),
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                  // height: 24 / 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //------------------------------------------------------------------------
            // Author Name
            Positioned(
                left: (mobile ? 0 : 0.255) * w,
                top: (mobile ? 0.854 : 0.026) * w,
                child: Text(
                  author,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * (mobile ? 0.0388 : 0.0088),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                    //height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                )),
            //-----------------------------------------------------------------------
            // Number of Reads
            Positioned(
              left: (mobile ? 0 : 0.255) * w,
              top: (mobile ? 0.9213 : 0.0412) * w,
              child: Text(
                "22k Reads",
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: (mobile ? 0.0333 : 0.007) * w,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffb1b1b1),
                  // height: 16 / 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //-----------------------------------------------------------------------
            // Description
            Positioned(
              left: (mobile ? 0 : 0.255) * w,
              top: (mobile ? 1.131 : 0.0715) * w,
              // Text has been put in a container here to wrap the text down (i.e. to make it multiline)
              child: Container(
                width: (mobile ? 1 : 0.6) * w,
                child: Text(
                  description,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * (mobile ? 0.0388 : 0.0088),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404040),
                    // height: 44 / 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            //-----------------------------------------------------------------------
            //Share Icon & Text
            Positioned(
              // top: w * (mobile ? 1.496 : 0.14),
              top: (mobile ? h * 0.93 : w * 0.14),
              left: (mobile ? 0 : 0.255) * w,
              child: TextButton(
                // If its a mobile, then the inbuilt share functionality of the platform (Android or iOS) opens
                // we are using Share Plus Package to do this.
                onPressed: mobile
                    ? () => Share.share(
                        'Hey Check out this awesome comic $comic_name by $author ${url}comic/$comicID')
                    // If its a PC, then the Share Link is copied to the Clipboard
                    : () => Clipboard.setData(ClipboardData(
                                text:
                                    "Hey Check out this awesome comic $comic_name by $author ${url}comic/$comicID"))
                            .then((_) {
                          // After copying the link to the clipboard, a snackbar is shown affirming the same
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              width: 0.3 * w,
                              content: Center(
                                  child: Text('Link Copied to Clipboard'))));
                        }),
                // Row Containing the Share Icon & Text
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Share Icon
                    Icon(
                      Icons.share_rounded,
                      size: (mobile ? 0.0555 : 0.012) * w,
                      color: Colors.black,
                    ),

                    // Share Text
                    Text(
                      "SHARE",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: w * (mobile ? 0.038 : 0.0088),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000),
                        //   height: 18 / 14,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ),
            //----------------------------------------------------------------------

            //Ratings Icon (Rounded Star)
            Positioned(
              top: w * (mobile ? 1.010 : 0.007),
              left: w * (mobile ? 0 : 0.8541),
              child: Icon(Icons.star_border_rounded,
                  size: w * (mobile ? 0.0666 : 0.015)),
            ),
            //-------------------------------------------------------------------------
            //Ratings
            Positioned(
                top: w * (mobile ? 1.029 : 0.0092),
                left: w * (mobile ? 0.0866 : 0.8737),
                child: Text(
                  '$averageRating Ratings',
                  style: TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: (mobile ? 0.03888 : 0.0088) * w,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                    // height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                )),
            //-------------------------------------------------------------------------
            //Like Icon
            Positioned(
                left: w * (mobile ? 0.3699 : 0.9378),
                top: w * (mobile ? 1.010 : 0.007),
                child: Icon(
                  Icons.favorite_rounded,
                  size: w * (mobile ? 0.0666 : 0.015),
                  color: Color.fromRGBO(237, 28, 36, 1),
                )),
            //---------------------------------------------------------------------------
            //Likes
            Positioned(
                left: w * (mobile ? 0.4565 : 0.957),
                top: w * (mobile ? 1.029 : 0.0092),
                child: Text(
                  '$totalLikes Likes',
                  style: TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: (mobile ? 0.03888 : 0.0088) * w,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffed1c24),
                    //  height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                )),
            //--------------------------------------------------------------------------
          ],
        ),
      );
    })),
  );
}
//-------------------------------------------------------------------------------------

// DownloadAd Widget
// ID: 3
Widget DownloadAd(mobile, comic_name) {
  return AspectRatio(
    aspectRatio: (mobile ? 360 / 429 : 1588 / 217),
    child: LayoutBuilder(builder: (context, constraints) {
      double w = constraints.maxWidth;
      double h = constraints.maxHeight;

      return Stack(
        children: [
          // The Download Ad Frame
          Container(
            width: w,
            height: h,
            child: Image.asset(
              mobile
                  ? 'assets/images/DownloadAdMobileFrame.png'
                  : 'assets/images/DownloadAdFrame.png',
              fit: BoxFit.fill,
            ),
          ),
          //----------------------------------------------------------------------

          // Download Ad Text (Downlaod and Read Comic_Name on Toonsutra app today!)
          Positioned(
            top: w * (mobile ? 0.064 : 0.024),
            left: w * (mobile ? 0.0494 : 0.034),
            child: Container(
              width: w * (mobile ? 0.9 : 0.314),
              child: Text(
                "Download and read $comic_name on Toonsutra app today!",
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: w * (mobile ? 0.0722 : 0.016),
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                  // height: 72 / 26,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          //------------------------------------------------------------------------------------------

          // Get it on Google Play Button
          Positioned(
              top: w * (mobile ? 0.41 : 0.086),
              left: w * (mobile ? 0.0494 : 0.034),
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://www.toonsutra.com/';
                },
                child: Container(
                  width: w * (mobile ? 0.4 : 0.090),
                  height: w * (mobile ? 0.1222 : 0.027),
                  child: Image.asset('assets/images/googleplay.png',
                      fit: BoxFit.contain),
                ),
              )),
          //-----------------------------------------------------------------------------------------

          // Download on the App Store Button
          Positioned(
              top: w * (mobile ? 0.41 : 0.086),
              left: w * (mobile ? 0.460 : 0.1388),
              child: InkWell(
                onTap: () {
                  window.location.href = 'https://www.toonsutra.com/';
                },
                child: Container(
                  width: w * (mobile ? 0.4 : 0.090),
                  height: w * (mobile ? 0.1222 : 0.027),
                  child: Image.asset(
                    'assets/images/appstore.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          //------------------------------------------------------------------------------------------

          // Mobile Screen Pic
          Positioned(
            // top: w * 0.0111,
            top: (mobile ? 0.6103 : 0.0157) * w,
            left: w * (mobile ? 0.0746 : 0.790),
            child: Container(
                width: w * (mobile ? 0.576 : 0.1306),
                height: w * (mobile ? 0.5799 : 0.125),
                child: Image.asset(
                  'assets/images/mobile.png',
                  fit: BoxFit.contain,
                )),
          ),
          //------------------------------------------------------------------------------------------
        ],
      );
    }),
  );
}
//-------------------------------------------------------------------------------------

//ChapterBox Widget
Widget ChapterBox(
  name,
  chapter_thumbnail,
  publishDate,
  totalChapterLike,
  chapter_num,
) {
  return AspectRatio(
    aspectRatio: 358 / 99.5,
    child: LayoutBuilder(builder: (context, constraints) {
      double w = constraints.maxWidth;

      return Container(
        //color: Colors.white,
        child: Stack(
          children: [
            // Comic Chapter Thumbnail Image
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                  width: w * 0.21,
                  height: w * 0.21,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      chapter_thumbnail,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  )),
            ),
            //-------------------------------------
            // Chapter Name
            Positioned(
                left: w * 0.26,
                top: 0,
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                    //  height: 11 / 16,
                  ),
                  textAlign: TextAlign.left,
                )),
            //-------------------------------------------
            //Publish Date
            Positioned(
                left: w * 0.26,
                top: w * 0.06,
                child: Text(
                  publishDate,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * 0.033,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff807e7e),
                    //  height: 8 / 12,
                  ),
                  textAlign: TextAlign.left,
                )),
            //------------------------------------------------
            //Heart Icon
            Positioned(
              left: w * 0.26,
              top: w * 0.172,
              child: Icon(
                Icons.favorite_rounded,
                color: Color.fromRGBO(108, 108, 108, 1),
                size: w * 0.0391,
              ),
            ),
            //-------------------------------------------------------
            //Number of Likes
            Positioned(
                top: w * 0.166,
                left: w * 0.316,
                child: Text(
                  totalChapterLike,
                  style: TextStyle(
                    fontFamily: "Space Grotesk",
                    fontSize: w * 0.0391,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6b6b6b),
                    height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                )),
            //-------------------------------------------------------
            //EYE Icon
            Positioned(
              left: w * 0.902,
              top: w * 0.05,
              child: Icon(Icons.remove_red_eye,
                  color: Colors.black, size: w * 0.06),
            ),
            //------------------------------------------------------
            //Divider
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Color.fromRGBO(228, 228, 228, 1),
                  width: w,
                  height: 1,
                )),
            //----------------------------------------------------
          ],
        ),
      );
    }),
  );
}
//--------------------------------------------------------------------------------------

//ChapterBoxGrid
// ID: 5
Widget ChapterBoxGrid(bool mobile, chapters, comic_name) {
  if (chapters == null) {
    return Text(
      'Someting Went Wrong. It seems like you are not authorized to view the Chapters of this Comic',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  return LayoutBuilder(builder: (context, constraints) {
    double w = constraints.maxWidth;
    return Container(
        width: w,
        child: Wrap(
          spacing: w * 0.01,
          runSpacing: w * (mobile ? 0.06215 : 0.0157),
          children: chapters.map<Widget>((chapter) {
            String name = chapter['name'];
            String chapter_thumbnail =
                chapter['chapter_thumbnail'] ?? 'https://picsum.photos/200/300';
            String publishDate = chapter['pubilshDate'] ?? 'DD/MM/YY';
            String totalChapterLike = chapter['totalChapterLike'] ?? '0';
            String chapter_num = chapter['chapter_num'] ?? '0';
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChapterPreview(
                            mobile, comic_name, chapter, context)),
                  );
                },
                child: Container(
                    width: w * (mobile ? 1 : 0.24),
                    child: ChapterBox(
                      name,
                      chapter_thumbnail,
                      publishDate,
                      totalChapterLike,
                      chapter_num,
                    )));
          }).toList(),
        ));
  });
}
//---------------------------------------------------------------------------------------

// Chapter Preview Widget
// It opens up a new Screen when you click on any ChapterBox
/*  
Parameters: 
1. bool mobile : Tells the widget whether we are in mobile view (true) or PC view (false).
2. String comic_name : Supplies the Name of the Comic to be used in the Preview Screen. 
3. Map<String, dynamic> chapter: chapter is a Map that contains the entire information related to a chapter. It is one index of the chapters array. 
*/
Widget ChapterPreview(mobile, comic_name, chapter, context) {
  double screenWidth = MediaQuery.of(context).size.width;
  mobile = screenWidth < 800 ? true : false;
  return Scaffold(
    drawer: Drawer(
      child: ToonSutraDrawer(),
    ),
    body: Center(
      // To make the Screen Scrollable
      child: SingleChildScrollView(
          // To cover only about 90% of the Screen Width
          child: FractionallySizedBox(
        // widthFactor: 1588 / 1728,
        widthFactor: 1,
        // Using layout builder to access the dynamic width 'w'
        child: LayoutBuilder(builder: ((context, constraints) {
          // w represents the current dynamic width of the FractionallySizedBox
          double w = constraints.maxWidth;
          /* 
          This column contains the following items: 
          1. NavBar Widget (Widget 1) (Navigation Bar)
          2. A Row containing Back Arrow (To go to previous screen), comic_name and chapter_name. 
          3. First 5 Image Slices of this chapter for preview 
          4. A DownlaodAd box showing an Ad to user to downlaod the App from Play Store or App Store 
          */
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height:
                      w * (mobile ? 0.04722 : 0.0192)), // for Vertical Spacing
              // 1. NavBar Widget (Widget 1) (Navigation Bar)
              FractionallySizedBox(
                widthFactor: 1588 / 1728,
                child: NavBar(mobile),
              ),

              SizedBox(
                  height:
                      w * (mobile ? 0.04722 : 0.0192)), // for Vertical Spacing
              //2. A Row containing Back Arrow (To go to previous screen), comic_name and chapter_name.
              FractionallySizedBox(
                // widthFactor: 1588 / 1728,
                widthFactor: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Back Arrow
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back,
                          color: Colors.black,
                          size: w * (mobile ? 0.07 : 0.02)),
                    ),
                    // Comic Name
                    Text(
                      '$comic_name/',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(237, 28, 36, 1),
                        fontFamily: "DM Sans",
                        fontSize: w * (mobile ? 0.04 : 0.015),
                        fontWeight: FontWeight.w600,
                        //  height: 31 / 24,
                      ),
                    ),
                    // Chapter Name
                    Flexible(
                      child: Text(
                        '${chapter['name']}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(137, 137, 137, 1),
                          fontFamily: "DM Sans",
                          fontSize: w * (mobile ? 0.03 : 0.015),
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,

                          // height: 31 / 24,
                        ),
                      ),
                    ),
                  ],
                ),
                // Row Ends Here
              ),
              SizedBox(height: w * (mobile ? 0.02 : 0.038)), // Vertical Spacing
              // 3. First 5 Image Slices of this chapter for preview
              Wrap(
                spacing: 0, // Horizontal spacing between items
                runSpacing: 0, // Vertical spacing between items
                children: chapter['chapter_split_arr']
                    .take(5)
                    .map<Widget>((entry) => Image.network(
                        entry['split_img_url'],
                        fit: BoxFit.cover))
                    .toList(),
              ),
              // Chapter Image Slices End Here
              // SizedBox(height: w * (mobile ? 0.02 : 0.038)),
              //4. A DownlaodAd box showing an Ad to user to downlaod the App from Play Store or App Store
              DownloadAd(mobile, comic_name),
            ],
          );
        })),
      )),
    ),
  );
}
//-----------------------------------------------------------------------------------------

// ToonSutra Drawer
Widget ToonSutraDrawer() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(16),
        // color: Colors.blue,
        width: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  window.location.href = 'https://www.toonsutra.com/';
                },
                child: Image.asset(
                  'assets/images/toonsutra_logo.png',
                  width: 80,
                  height: 80,
                )),
            SizedBox(height: 10),
            Text(
              'ToonSutra',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          window.location.href = 'https://www.toonsutra.com/';
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text('FAQ'),
        onTap: () {
          window.location.href = 'https://toonsutra.in/faq_01/';
        },
      ),
      ListTile(
        leading: Icon(Icons.lock),
        title: Text('Privacy Policy'),
        onTap: () {
          window.location.href = 'https://toonsutra.in/privacy-policy/';
        },
      ),
      ListTile(
        leading: Icon(Icons.gavel),
        title: Text('Terms & Conditions'),
        onTap: () {
          window.location.href = 'https://toonsutra.in/terms-and-conditions/';
        },
      ),
      ListTile(
        leading: Icon(Icons.contact_mail),
        title: Text('Contact Us'),
        onTap: () {
          window.location.href = 'https://toonsutra.in/contact/';
        },
      ),
      Spacer(), // Spacer to push the last item to the bottom
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '@2023 Toonsutra',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ],
  );
}
//-----------------------------------------------------------------------------------------
