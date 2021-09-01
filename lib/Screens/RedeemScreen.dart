import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
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
    Size size = MediaQuery.of(context).size;
  /*  return Scaffold(
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


                            child: Column(
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
                            ),

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
    );*/
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xff388E3C),
                image: DecorationImage(
                  image: AssetImage('assets/images/wash.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.3), BlendMode.dstATop),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 120,
                right: 20,
                left: 20,
              ),
              height: 200,
              width: double.infinity,

              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff388E3C),
                      Color(0xff388E2C),
                    ],
                  ),

                ),

                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Flexible(
                          child: Text(
                            "Loyality Balance",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        right: 20,
                        left: 20,
                      ),
                      child: AspectRatio(
                        // Use 1.0 to ensure that the custom painter
                        // will draw inside a container with width == height
                        aspectRatio: 1.0,
                        child: CustomPaint(
                          painter: RingPainter(
                            progress: 0.6,
                            taskCompletedColor: Colors.white,
                            taskNotCompletedColor: Colors.grey,
                          ),
                        ),
                      ),
                      height: 80,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        right: 20,
                        left: 120,
                      ),
                      child:  Flexible(
                          child: Text(
                            addedpoints != null
                                ? addedpoints.toString()+"pts"
                                : "0 pts",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 80,
                        right: 20,
                        left: 120,
                      ),
                      child:  Flexible(
                          child: Text(
                            "200 points till your next free exterior service",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 0,
                        left: 150,
                      ),
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logocar.png'),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(Colors.green.shade700.withOpacity(0.2), BlendMode.dstATop),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 150,
                        right:10,
                        left: 10,
                      ),
                      child:DottedLine(dashLength: 12, dashGapLength: 10, dashColor: Colors.white70,),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 160,
                        right: 20,
                        left: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text("${widget.user}",
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.w300))),
                            Flexible(
                                child: Text("${widget.id}",
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.w300))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
                top: 330,
                right: 20,
                left: 20,
              ),

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Give and get points',
                        style: GoogleFonts.nunito(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'When a friend uses your code, you will get 10 points',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    MaterialButton(
                      color: Color(0xff388E3C),
                      onPressed: () {
                      },
                      child:Text(
                        'Share invite code',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    )
                    ,
                  ],
                ),
              ),
            ),
            Container(
              height: 350,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 470,
                right: 10,
                left: 10,
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text("Redeem Offers", style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),),
              ),
            ),
            Container(
              //height: 350,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              margin: EdgeInsets.only(
                top:450,
                right: 10,
                left: 10,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index)
                  {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child:Container(
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        child: InkWell(
                          onTap: (){

                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(

                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],

                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              // our product image
                              Positioned(
                                top: 10,
                                right: 0,

                                child: Hero(
                                  tag: '11',
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 1),
                                    // image is square but we add extra 20 + 20 padding thats why width is 200
                                    width: 130,
                                    child: Image.asset(
                                      "assets/images/logocar.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // Product title and price
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 136,
                                  // our image take 200 width, thats why we set out total width - 200
                                  width: size.width - 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:10),
                                        child: Flexible(
                                          child: Text(
                                            "Dry Wash Exterior",
                                            style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:10, vertical: 5),
                                        child: Text(
                                          "200 Points",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      // it use the available space
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 3 * 1.5, // 30 padding
                                          vertical: 1 / 4, // 5 top and bottom
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(22),
                                            topRight: Radius.circular(22),
                                          ),
                                        ),
                                        child:  MaterialButton(

                                          onPressed: () {
                                          },
                                          child:Text(
                                            'Redeem',
                                            style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
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
              ),


            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
class RingPainter extends CustomPainter {
  // 1. add a constructor and properties that can be set from the parent widget
  RingPainter({
    required this.progress,
    required this.taskNotCompletedColor,
    required this.taskCompletedColor,
  });
  // a value between 0 and 1
  final double progress;
  // background color to use when the task is not completed
  final Color taskNotCompletedColor;
  // foreground color to use when the task is completed
  final Color taskCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    // 2. configure the paint and drawing properties
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 3. create and configure the background paint
    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke;
    // 4. draw a circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // 5. create and configure the foreground paint
    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;
    // 6. draw an arc that starts from the top (-pi / 2)
    // and sweeps and angle of (2 * pi * progress)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  // 7. only return true if the old progress value
  // is different from the new one
  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

