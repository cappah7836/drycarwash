import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DashboardScreen.dart';
import 'LoginScreen.dart';
import 'ReferScreen.dart';

class RedeemScreen extends StatefulWidget{
  final String user;
  final int? id;

  RedeemScreen({required this.user, required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RedeemScreenState();
  }

}
class RedeemScreenState extends State<RedeemScreen>{
  var response;
  var addedpoints, usedpoints;

  ReferPoints() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "CustomerId": widget.id,
    });

    response =
    await dioRequest.post("Sale/GetCustomerPointsAccount", data: formData);
    if (response.statusCode == 200) {
      setState(() {
        addedpoints = response.data["obj"][0]["pointS_ADDED"].toDouble();
        usedpoints = response.data["obj"][0]["poinT_USED"].toDouble();
        print(addedpoints);
        print(usedpoints);
      });

      var message = response.data['message'];

      if (message == "No Record Found") {
        final snackBar = SnackBar(
            content: Text('No Record of Referral Points'),
            backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (message == "Customer Not Exist") {
        final snackBar = SnackBar(
            content: Text('Error Fetching Data'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    ReferPoints();
  }
  static const _yurl =
      "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";
  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";
  double value = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff388E3C),
            ),
          ),
          SafeArea(
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/logocar.png"),
                          width: 80,
                          height: 80,
                        ),
                        Text(
                          "Welcome",
                          style: GoogleFonts.encodeSans(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.user.toString(),
                          style: GoogleFonts.encodeSans(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()));
                            },
                            leading: Icon(Icons.home, color: Colors.white),
                            title: Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: widget.user.isNotEmpty
                                ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReferScreen(
                                          user: widget.user, id: widget.id)));
                            }
                                : null,
                            leading: Icon(Icons.supervised_user_circle, color: Colors.white),
                            title: Text(
                              "Refer & Get Discount",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap:   widget.user.isNotEmpty? () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RedeemScreen(user: widget.user, id: widget.id)
                              )
                              );
                            }:null,
                            leading: Icon(Icons.attach_money, color: Colors
                                .white),
                            title: Text(
                              "Redeem Points",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              addedpoints != null
                                  ? addedpoints.toString()
                                  : "0",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              SharedPreferences pref =
                              await SharedPreferences.getInstance();
                              pref.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            leading: Icon(Icons.logout, color: Colors.white),
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Divider(),
                          Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Text(
                                "Version Number 1.1.1",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 20,
                              child: Text(
                                "Save Water 💧 Save Life",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                        ],
                      ))
                ],
              ),
            ),
          ),
          //Tweet Animation for header
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_, double val, __) {
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Redeem Points"),
                      backgroundColor: Color(0xff388E3C),
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            value == 0 ? value = 1 : value = 0;
                          });
                        },
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xffececec),
                              image: DecorationImage(
                                image: AssetImage('assets/images/wash.jpg'),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              ),
                            ),
                          ),
                          Container(
                            child: Container(

                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                                image: DecorationImage(
                                  image: AssetImage('assets/images/bb.jpg'),
                                  fit: BoxFit.cover,

                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: RichText(
                                              text: TextSpan( text:"Dry Car Wash",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                  children: [
                                                    TextSpan(text: '\nREDEEM CARD',
                                                      style: TextStyle(
                                                          color: Colors.green, fontSize: 18),

                                                    )
                                                  ]
                                              ),

                                            )),

                                        Image.asset(
                                          'assets/images/logocar.png',
                                          height: 50,

                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: Text("Total Points:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w400))),
                                        SizedBox(width: 10,),
                                        Flexible(
                                            child: Text(addedpoints != null
                                                ? addedpoints.toString()
                                                : "0",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w300))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: Text("ID:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w400))),
                                        SizedBox(width: 10,),
                                        Flexible(
                                            child: Text("${widget.id}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w300))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: Text("Username:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w400))),
                                        SizedBox(width: 10,),
                                        Flexible(
                                            child: Text("${widget.user}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w300))),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Flexible(
                                          child: Text("Classic", style: GoogleFonts.dancingScript(fontSize: 40, color: Colors.black54),)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            margin: EdgeInsets.only(
                              top: 30,
                              right: 20,
                              left: 20,
                            ),
                            height: 200,
                            width: double.infinity,


                            /*child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AvatarGlow(
                                  startDelay: Duration(milliseconds: 1000),
                                  glowColor: Color(0xff388E3C),
                                  endRadius: 70.0,
                                  duration: Duration(milliseconds: 2000),
                                  repeat: true,
                                  showTwoGlows: true,
                                  repeatPauseDuration: Duration(milliseconds: 100),
                                  child: Material(
                                    elevation: 5.0,
                                    shape: CircleBorder(),
                                    color: Colors.transparent,
                                    child:  CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[200],
                                      child: Image.asset(
                                        'assets/images/man.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  animate: true,
                                  curve: Curves.fastOutSlowIn,
                                ),


                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),

                              ],
                            ),*/

                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 240,
                              right: 20,
                              left: 20,
                            ),
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],

                            ),
                            child: Center(
                              child: Text(
                                'REDEEM OFFERS',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 350,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: 300,
                              right: 10,
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(

                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (context, index){
                                          return Card(
                                            color: Colors.white,
                                            elevation: 5,

                                            child:Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Flexible(
                                                        child: Text("Dry Wash Exterior", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                      ),
                                                      Flexible(
                                                        child: Badge(
                                                          toAnimate: false,
                                                          shape: BadgeShape.square,
                                                          badgeColor: Colors.green,
                                                          borderRadius: BorderRadius.circular(8),
                                                          badgeContent: Text('200 points', style: TextStyle(color: Colors.white)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,),
                                                Container(
                                                  height: 1,
                                                  color: Colors.grey[400],
                                                ),
                                                SizedBox(
                                                  height: 10,),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 5),

                                                  child: Column(

                                                    children: [

                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,

                                                          children: [

                                                            Text(
                                                              "Actual Amount",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                                color: Colors.redAccent,
                                                              ),
                                                            ),


                                                            Text(
                                                              "950",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14,
                                                                color: Colors.redAccent,
                                                                decoration: TextDecoration.lineThrough,
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Row(

                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Discounted Rate",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                                color: Colors.green,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Free",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14,
                                                                color: Colors.green,

                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),


                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    // optional flex property if flex is 1 because the default flex is 1
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                      },
                                                      child: Text("Redeem"),
                                                      style: ElevatedButton.styleFrom(primary: Colors.green),
                                                    ),

                                                  ),
                                                ),

                                              ],
                                            ),

                                          );
                                        }


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
                ));
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }

  void _launchURL() async => await canLaunch(_furl)
      ? await launch(_furl)
      : throw 'Could not launch $_furl';

  void _launchURLinsta() async => await canLaunch(_iurl)
      ? await launch(_iurl)
      : throw 'Could not launch $_iurl';

  void _launchURLyoutube() async => await canLaunch(_yurl)
      ? await launch(_yurl)
      : throw 'Could not launch $_yurl';
}


