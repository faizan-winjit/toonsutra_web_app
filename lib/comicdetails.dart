import 'package:flutter/material.dart';

// Comic Details - The Overall Widget making the entire ToonSutra Comic Details Page.
/* It consists of main 5 widgets:part 
1. NavBar
2. ComicDetailsCard
3. DownloadAd
4. ChapterBox
5. ChapterBoxGrid

*/
Widget ComicDetails() {
  return SingleChildScrollView(
    child: Center(
      child: FractionallySizedBox(
          widthFactor: 1588 / 1728,
          child: LayoutBuilder(builder: ((context, constraints) {
            double w = constraints.maxWidth;
            bool mobile = w < 600 ? true : false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * (mobile ? 0.04722 : 0.0192)),
                NavBar(mobile),
                SizedBox(height: w * (mobile ? 0.0733 : 0.037)),
                ComicDetailsCard(mobile),
                SizedBox(height: w * (mobile ? 0.1121 : 0.020)),
                DownloadAd(mobile),
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
                ChapterBoxGrid(mobile),
              ],
            );
          }))),
    ),
  );
}
//-------------------------------------------------------------------------------------------------

// Nav Bar Widget
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
              child: Image.asset(
                'assets/images/toonsutra_logo.png',
                width: w * (mobile ? 0.125 : 0.02833),
                height: w * (mobile ? 0.125 : 0.02833),
              )),
          //-----------------------------------------------------------------------------
          // Home
          Positioned(
            top: 0,
            left: w * 0.698041562,
            child: Visibility(
              visible: !mobile,
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
          //-----------------------------------------------------------------------------
          // FAQ
          Positioned(
            top: 0,
            left: w * 0.741492443,
            child: Visibility(
              visible: !mobile,
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
          //-----------------------------------------------------------------------------
          // Privacy Policy
          Positioned(
            top: 0,
            left: w * 0.77738665,
            child: Visibility(
              visible: !mobile,
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
          //-----------------------------------------------------------------------------
          // Terms & Conditions
          Positioned(
            top: 0,
            left: w * 0.853583123,
            child: Visibility(
              visible: !mobile,
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
          //-----------------------------------------------------------------------------
          // Contact Us
          Positioned(
            top: 0,
            left: w * 0.951819899,
            child: Visibility(
              visible: !mobile,
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
          //-----------------------------------------------------------------------------
          // Hamburger
          Positioned(
            top: w * 0.029,
            left: w * 0.9277,
            child: Visibility(
              visible: mobile,
              child: Icon(
                Icons.menu,
                size: w * 0.0666,
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
Widget ComicDetailsCard(bool mobile) {
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
                child: Image.asset(
                  'assets/images/image1.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //-----------------------------------------------------------------------
            // Comic Name
            Positioned(
              left: (mobile ? 0 : 0.255) * w,
              top: (mobile ? 0.7649 : 0.0057) * w,
              child: Text(
                "Astra The Immortal",
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
                  "Gayatri Banerjee",
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
              child: Container(
                width: (mobile ? 1 : 0.6) * w,
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
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
            //Share Icon
            Positioned(
              top: w * (mobile ? 1.496 : 0.1450),
              left: (mobile ? 0 : 0.255) * w,
              child: Icon(Icons.share_rounded,
                  size: (mobile ? 0.0555 : 0.012) * w),
            ),
            //----------------------------------------------------------------------
            //Share
            Positioned(
                top: w * (mobile ? 1.5 : 0.1450),
                left: w * (mobile ? 0.0703 : 0.271),
                child: Text(
                  "SHARE",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: w * (mobile ? 0.038 : 0.0088),
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000),
                    //   height: 18 / 14,
                  ),
                  textAlign: TextAlign.left,
                )),
            //-------------------------------------------------------------------------
            //Ratings Icon (Rounded Star)
            Positioned(
              top: w * (mobile ? 1.020 : 0.007),
              left: w * (mobile ? 0 : 0.8541),
              child:
                  Icon(Icons.star_rounded, size: w * (mobile ? 0.0666 : 0.015)),
            ),
            //-------------------------------------------------------------------------
            //Ratings
            Positioned(
                top: w * (mobile ? 1.029 : 0.0092),
                left: w * (mobile ? 0.0866 : 0.8737),
                child: Text(
                  "4.0 Ratings",
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
                top: w * (mobile ? 1.020 : 0.007),
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
                  "1.5k Likes",
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

// DownloadAdWidget
Widget DownloadAd(bool mobile) {
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
                "Download and read Astra The Immortal on Toonsutra app today!",
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
            child: Image.asset(
              'assets/images/googleplay.png',
              width: w * (mobile ? 0.4 : 0.090),
              height: w * (mobile ? 0.1222 : 0.027),
            ),
          ),
          //-----------------------------------------------------------------------------------------

          // Download on the App Store Button
          Positioned(
            top: w * (mobile ? 0.41 : 0.086),
            left: w * (mobile ? 0.460 : 0.1388),
            child: Image.asset(
              'assets/images/appstore.png',
              width: w * (mobile ? 0.4 : 0.090),
              height: w * (mobile ? 0.1222 : 0.027),
            ),
          ),
          //------------------------------------------------------------------------------------------

          // Mobile Screen Pic
          Positioned(
            // top: w * 0.0111,
            top: (mobile ? 0.6103 : 0) * w,
            left: w * (mobile ? 0.0746 : 0.790),
            child: Image.asset(
              'assets/images/mobile.png',
              //  width: w * 0.1306,
              height: (mobile ? 0.7 * w : h),
            ),
          ),
          //------------------------------------------------------------------------------------------
        ],
      );
    }),
  );
}
//-------------------------------------------------------------------------------------

//ChapterBox Widget
Widget ChapterBox() {
  return AspectRatio(
    aspectRatio: 358 / 99.5,
    child: LayoutBuilder(builder: (context, constraints) {
      double w = constraints.maxWidth;
      double h = constraints.maxHeight;
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            // Comic Chapter Thumbnail Image
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: w * 0.21,
                height: w * 0.21,
                child: Image.asset(
                  'assets/images/image2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //-------------------------------------
            // Chapter Name
            Positioned(
                left: w * 0.26,
                top: 0,
                child: Text(
                  "Ch 5 - Astra The Immortal",
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
                  "10 July 2023",
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
              top: w * 0.171,
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
                  "1.5k",
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
            //Lock
            Positioned(
              left: w * 0.902,
              top: w * 0.05,
              child:
                  Icon(Icons.lock_outline, color: Colors.black, size: w * 0.06),
            ),
            //------------------------------------------------------
            //Divider
            Positioned(
                bottom: 5,
                left: 5,
                child: Divider(
                  height: 10, // Height of the divider
                  color: Colors.blue, // Color of the divider
                  thickness: 10, // Thickness of the divider
                  indent: 16, // Left indent of the divider
                  endIndent: 16, // Right indent of the divider
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
Widget ChapterBoxGrid(bool mobile) {
  return LayoutBuilder(builder: (context, constraints) {
    double w = constraints.maxWidth;
    return Container(
        width: w,
        child: Wrap(
          spacing: w * 0.01,
          children: [
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
            Container(
              width: w * (mobile ? 1 : 0.2425),
              child: ChapterBox(),
            ),
          ],
        ));
  });
}
//---------------------------------------------------------------------------------------
