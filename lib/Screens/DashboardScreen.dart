

import 'package:drycarwash/Screens/AboutUsScreen.dart';
import 'package:drycarwash/Screens/AppointmentScreen.dart';
import 'package:drycarwash/Screens/BookingScreen.dart';
import 'package:drycarwash/Screens/ContactScreen.dart';
import 'package:drycarwash/Screens/OffersScreen.dart';
import 'package:drycarwash/Screens/ProfileScreen.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';


import 'LoginScreen.dart';
import 'ReferScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {



  String userName="";
  String No="";
  int? userid;

  getUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString("username")?? "";
    No = pref.getString("phone")?? "";
   userid = pref.getInt("userid")?? 0;

    print(userName);
    print(userid);
    print(No);

  }
  @override
  void initState() {
    // TODO: implement initState
    // _foundUsers = _allUsers;
    super.initState();
    getUserData();


  }




  //declare variables
  double value = 0;
  static const _yurl = "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";
  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

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
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userName,
                          style: GoogleFonts.encodeSans(
                              fontSize: 14,
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
                            },
                            leading: Icon(Icons.home, color: Colors.white),
                            title: Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap:  userName.isNotEmpty? () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ReferScreen(user: userName, id: userid)
                              )
                              );
                            }:null,
                            leading: Icon(Icons.attach_money, color: Colors
                                .white),
                            title: Text(
                              "Refer & Get Discount",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () async{
                              SharedPreferences pref =await SharedPreferences.getInstance();
                              pref.clear();

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            leading: Icon(Icons.logout, color: Colors.white),
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                    ..setEntry(3, 2, 0.001)..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: Scaffold(
                    backgroundColor: Color(0xffC3EDC5),
                    appBar: AppBar(
                      title: Text("Home"),
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

                    body: Stack(

                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: double.infinity,

                          child: GridView.count(
                            crossAxisCount: 2,
                            children: [
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => BookingScreen()));
                                  },

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/reservation.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Book a Service",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],

                                  ),
                                ),

                              ),
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentScreen(uid: userid)));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/calendar.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Appointments",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],
                                  ),
                                ),

                              ),
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ProfileScreen()));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/man.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Profile",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => OffersScreen()));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/discount.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),

                                      Text("Special Offers",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],
                                  ),
                                ),

                              ),
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => AboutUsScreen(user: userName)));
                                  },
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(

                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/info.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("About Us",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Color(0xffC3EDC5),
                                margin: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ContactScreen(user: userName, no: No)));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Color(0xff43a747),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/question.png'),
                                          backgroundColor: Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Contact",
                                          style: new TextStyle(
                                              fontSize: 17.0))
                                    ],
                                  ),
                                ),

                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Row(
                                children: [
                            Expanded(child: RaisedButton(
                            elevation: 5,
                                onPressed:(){
                                Share.share("I am $userName and inviting you to Use my Refferal link:$_url to get a reward of 20 points");
                                },
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
                                    fontSize:8,
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
                                  fontSize:8,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),

                              ),


                            ],
                          ),

                        ),
                        ),
                        Expanded(
                          child: RaisedButton(
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
                                    fontSize:8,
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
                                  fontSize:8,
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
                ),)
                ,
                )
                );
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


