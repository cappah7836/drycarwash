import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DashboardScreen.dart';

class ContactScreen extends StatefulWidget {
  final String? no;
  final String? user;
  ContactScreen({required this.no, required this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactScreenState();

  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class ContactScreenState extends State<ContactScreen> {
  static const _yurl = "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";



  var response;

  RequestCall()async{

    var dio = Dio();
    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "username": widget.user,
      "usernumber": widget.no
    });
    response = await dio.post("Sale/CustomerCallBackRequest", data: formData);
    if (response.statusCode == 200) {
      print(response.data);

      var message = response.data['message'];


      if (message == "SMS sent successfully!") {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Request Call Message Sent",
            autoCloseDuration: Duration(seconds: 4),
            confirmBtnColor: Theme.of(context).primaryColor,
            barrierDismissible: true,
            animType: CoolAlertAnimType.slideInRight,
            backgroundColor: Colors.green);
      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("Contact Us"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/car_logo.png',
                          scale: 1, width: 50, height: 50),
                      Image.asset('assets/images/drycarwashlogo.jpg',
                          scale: 1, width: 200, height: 100),
                      Center(
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    // if you need this
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      _launchCaller();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 120,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(Icons.call, size: 50),
                                          ),
                                        ),
                                        Text(
                                          'Call Us',
                                          style: GoogleFonts.encodeSans(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    // if you need this
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      RequestCall();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 120,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(Icons.phone_callback,
                                                size: 50),
                                          ),
                                        ),
                                        Text(
                                          'Request a Call',
                                          style: GoogleFonts.encodeSans(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined,
                                                size: 20),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                MapUtils.openMap(
                                                    31.49235280810176,
                                                    74.41644167144685);
                                                print('The button is clicked!');
                                              },
                                            text:
                                                "Greenway Dry Car Wash near Airport Road, Gulshan Ali Colony Gulshan e Ali Colony, Lahore, Punjab",
                                            style: GoogleFonts.encodeSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined,
                                                size: 20),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                MapUtils.openMap(
                                                    31.46657181269577,
                                                    74.23517021225192);
                                                print('The button is clicked!');
                                              },
                                            text:
                                                "Greenway Dry Car Wash Metro Thokar Niaz Baig, Lahore, 54000, Pakistan",
                                            style: GoogleFonts.encodeSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined,
                                                size: 20),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                MapUtils.openMap(
                                                    31.47058904655662,
                                                    74.42898931040392);
                                                print('The button is clicked!');
                                              },
                                            text:
                                                "Greenway Dry Car Wash Jammu Stop, Bedian Rd, Jamun, Lahore, Punjab 54000",
                                            style: GoogleFonts.encodeSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(Icons.email, size: 20),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _sendMail();
                                                print('The button is clicked!');
                                              },
                                            text:
                                                " sales@greenwayproduct.com                                      ",
                                            style: GoogleFonts.encodeSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(Icons.phone, size: 20),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchCaller2();
                                                print('The button is clicked!');
                                              },
                                            text:
                                                " +92-42-37175882                                                            ",
                                            style: GoogleFonts.encodeSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed:_launchURL,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Invite',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURL,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURLinsta,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Instagram',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURLyoutube,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.youtube,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Youtube',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchCaller() async {
    const url = "tel:03011143779";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchCaller2() async {
    const url = "tel:+92-42-37175882";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail() async {
    // Android and iOS
    const uri = 'mailto:sales@greenwayproduct.com?subject=&body=';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
  void _launchURL() async =>
      await canLaunch(_furl)
          ? await launch(_furl)
          : throw 'Could not launch $_furl';

  void _launchURLinsta() async =>
      await canLaunch(_iurl)
          ? await launch(_iurl)
          : throw 'Could not launch $_iurl';

  void _launchURLyoutube() async =>
      await canLaunch(_yurl)
          ? await launch(_yurl)
          : throw 'Could not launch $_yurl';
}
