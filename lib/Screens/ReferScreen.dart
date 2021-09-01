
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:url_launcher/url_launcher.dart';


class ReferScreen extends StatefulWidget {
  final String user;
  final int? id;

  ReferScreen({required this.user, required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReferScreenState();
  }
}

class ReferScreenState extends State<ReferScreen> {
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

  bool _loadChart = false;
  double value = 0;

  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
/*
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
                      title: Text("Refer & Get Discount"),
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
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Welcome ${widget.user}',
                            style: TextStyle(
                              color: Color(0xff388E3C),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/images/logocar.png',
                            height: 80,
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),


                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.7, 0.7),
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: PieChart(
                                    dataMap: {
                                      "Total Points":
                                          addedpoints != null ? addedpoints : 0,
                                      "Used Points":
                                          usedpoints != null ? usedpoints : 0,
                                    },
                                    animationDuration:
                                        Duration(milliseconds: 200),
                                    colorList: [
                                      Colors.blue,
                                      Colors.green,
                                    ],
                                    chartValuesOptions: ChartValuesOptions(
                                        decimalPlaces: 0,
                                        showChartValueBackground: false),
                                    legendOptions: LegendOptions(
                                      legendShape: BoxShape.rectangle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 120,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.7, 0.7),
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'User Stats:',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Points',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          addedpoints != null
                                              ? addedpoints.toString()
                                              : "0",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Used Points',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          usedpoints != null
                                              ? usedpoints.toString()
                                              : "0",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      elevation: 5,
                                      onPressed: () {
                                        Share.share(
                                            "I am ${widget.user} and inviting you to Use my Refferal link:$_url to get a reward of 20 points");
                                      },
                                      padding: EdgeInsets.all(15),
                                      color: Color(0xff388E3C),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.share,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            'Invite',
                                            style: TextStyle(
                                              fontSize: 8,
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
                                      onPressed: _launchURL,
                                      padding: EdgeInsets.all(15),
                                      color: Color(0xff388E3C),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            'Like',
                                            style: TextStyle(
                                              fontSize: 8,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.instagram,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            'Instagram',
                                            style: TextStyle(
                                              fontSize: 8,
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
                                      onPressed: _launchURLyoutube,
                                      padding: EdgeInsets.all(15),
                                      color: Color(0xff388E3C),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.youtube,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            'Youtube',
                                            style: TextStyle(
                                              fontSize: 8,
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

    return new Scaffold(
      body:SingleChildScrollView(

   child: Stack(
          children: [
            Container(
              height: 520,
              decoration: BoxDecoration(

                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff388E3C),
                      Colors.green,
                    ],
                  ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),

            ),
            Container(
              margin: EdgeInsets.only(
                top:80,
                right: 20,
                left: 20,
              ),
              height: 200,
              width: double.infinity,


              child: Column(
                children: [

                  Center(
                    child: Text("Refer your friends",style: GoogleFonts.kanit(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600), ),
                  ),
                  Center(
                    child: Text("and Earn",style: GoogleFonts.kanit(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600), ),
                  ),
                  Container(
                  height: 80,
                    child: Lottie.asset('assets/gifs/gift.json',
                      repeat: true,
                      reverse: true,
                      animate: true,),
                  ),
                  Container(
                    child: Column(

                      children: [
                        Center(
                          child: Text( addedpoints != null
                              ? addedpoints.toString()
                              : "0",style: GoogleFonts.kanit(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600), ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/coin.png", width: 19,),
                            SizedBox(width: 10,),
                            Center(
                              child: Text("Total Points",style: GoogleFonts.kanit(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400), ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),

            ),
            Container(
              margin: EdgeInsets.only(
                top: 290,
              ),

              height: 40,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Your friend gets 20 points on sign up\n and, you get 10 points too everytime.',
                  style: GoogleFonts.kanit(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Clipboard.setData(ClipboardData(text: "I am ${widget.user} and inviting you to Use my Refferal link:$_url to get a reward of 20 points"));
                final snackBar =
                SnackBar(content: Text('Copied'), backgroundColor: Colors.grey);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
              margin: EdgeInsets.only(
                  top: 350,
                right: 50,
                left: 50
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),

                width: double.infinity,
                child: Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(

                       children: [
                         Text(
                           'Your referral code',
                           style: GoogleFonts.kanit(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               'DZP9ScjqvvSepsat9',
                               style: GoogleFonts.kanit(fontSize: 25, color: Colors.green, fontWeight: FontWeight.w600),
                             ),
                             Icon(Icons.copy),
                           ]

                         ),

                       ],


                     ),
                   ),


                  ],

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 435,
                  right: 50,
                  left: 50
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Share your Referral Code via',
                    style: GoogleFonts.kanit(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                  ),


                ],

              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 480,
              ),
               child: Padding(
                  padding: const EdgeInsets.all(10.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     GestureDetector(
                       onTap:(){

                       },
                       child: Container(

                         height: 40,
                         width: 110,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(30),

                           boxShadow: [
                             BoxShadow(
                               color: Colors.pink.withOpacity(0.3),
                               spreadRadius: 3,
                               blurRadius: 7,
                               offset: Offset(0, 3),
                             ),
                           ],

                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Icon(
                               FontAwesomeIcons.instagram,
                               color: Colors.pinkAccent,
                               size: 20,
                             ),
                             Center(
                               child: Text(
                                 'Instagram',
                                 style: TextStyle(
                                   color: Colors.pink,
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     Container(

                       height: 40,
                       width: 110,
                       decoration: BoxDecoration(
                         color: Color(0xff0873f5),
                         borderRadius: BorderRadius.circular(30),

                         boxShadow: [
                           BoxShadow(
                             color: Colors.blue.withOpacity(0.5),
                             spreadRadius: 3,
                             blurRadius: 7,
                             offset: Offset(0, 3),
                           ),
                         ],

                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Icon(
                             FontAwesomeIcons.facebook,
                             color: Colors.white,
                             size: 20,
                           ),
                           Center(
                             child: Text(
                               'Facebook',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 14,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(

                       height: 40,
                       width: 110,
                       decoration: BoxDecoration(
                         color: Color(0xff1ea800),
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
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Icon(
                             FontAwesomeIcons.whatsapp,
                             color: Colors.white,
                             size: 20,
                           ),
                           Center(
                             child: Text(
                               'WhatsApp',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 14,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
                ),


            ),
            Container(
              margin: EdgeInsets.only(
                top: 550,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'Frequently Asked Questions',
                        style: GoogleFonts.kanit(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: (){
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ClassicGeneralDialogWidget(
                                  titleText: 'Refer & Earn',
                                  contentText: 'It is a program where you can get points to redeem offers.',
                                  positiveText: "Ok",
                                  positiveTextStyle: GoogleFonts.kanit(fontSize: 15, color: Colors.green),
                                  onPositiveClick: () {
                                    Navigator.of(context).pop();
                                  },

                                );
                              },
                              animationType: DialogTransitionType.size,
                              curve: Curves.linear,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'What is Refer and Earn Program?',
                                style: GoogleFonts.kanit(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: (){
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ClassicGeneralDialogWidget(
                                  titleText: 'How it works',
                                  contentText: 'You invite your friend with your referral code then you get 10 points everytime and your friend gets 20 points.',
                                  positiveText: "Ok",
                                  positiveTextStyle: GoogleFonts.kanit(fontSize: 15, color: Colors.green),
                                  onPositiveClick: () {
                                    Navigator.of(context).pop();
                                  },

                                );
                              },
                              animationType: DialogTransitionType.size,
                              curve: Curves.linear,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'How it works?',
                                style: GoogleFonts.kanit(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: (){
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ClassicGeneralDialogWidget(
                                  titleText: 'Point Usage',
                                  contentText: 'You can use points to get free service depending on points',
                                  positiveText: "Ok",
                                  positiveTextStyle: GoogleFonts.kanit(fontSize: 15, color: Colors.green),
                                  onPositiveClick: () {
                                    Navigator.of(context).pop();
                                  },

                                );
                              },
                              animationType: DialogTransitionType.size,
                              curve: Curves.linear,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Where can I use these Points',
                                style: GoogleFonts.kanit(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
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


}
