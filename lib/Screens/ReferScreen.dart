
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drycarwash/Screens/DashboardScreen.dart';

import 'package:drycarwash/Screens/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class ReferScreenState extends State<ReferScreen>{
  bool isLoading = true;


  var response;
  var addedpoints ,usedpoints;


  ReferPoints() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "CustomerId": widget.id,

    });


    response = await dioRequest.post("Sale/GetCustomerPointsAccount", data: formData);
    if (response.statusCode == 200) {


      setState(() {
        addedpoints =response.data["obj"][0]["pointS_ADDED"].toDouble();
        usedpoints = response.data["obj"][0]["poinT_USED"].toDouble();
        print(addedpoints);
        print(usedpoints);
      });

      var message = response.data['message'];

      if (message == "No Record Found") {
        final snackBar =
        SnackBar(content: Text('No Record of Referral Points'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);



      }
      else if (message == "Customer Not Exist") {
        final snackBar =
        SnackBar(content: Text('Error Fetching Data'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);


      }

    } else {
      print("Error...");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // _foundUsers = _allUsers;
    super.initState();
    ReferPoints();


  }

  bool _loadChart = false;
  double value = 0;
  static const _yurl = "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";
  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("Refer & Earn"),
        centerTitle: true,
        leading: IconButton(
          icon:Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(
                    'Welcome ${widget.user}',
                    style: TextStyle(
                      color: Color(0xff388E3C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Image.asset(
                    'assets/images/logocar.png',
                    height: 80,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  SizedBox(height: 10,),
                  Image.asset(
                    'assets/images/drycarwashlogo.jpg',
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  SizedBox(height: 10,),
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
                                "Total Points": addedpoints !=null ? addedpoints : 0,
                                "Used Points": usedpoints!= null ? usedpoints : 0,
                              },
                              animationDuration: Duration(milliseconds: 200),
                              colorList: [
                                Colors.blue,
                                Colors.greenAccent,
                              ],
                              chartValuesOptions: ChartValuesOptions(
                                  decimalPlaces: 0, showChartValueBackground: false),
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
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Points',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                addedpoints !=null  ? addedpoints.toString() :"0",
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
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Used Points',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  usedpoints !=null  ? usedpoints.toString() :"0",

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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(child: RaisedButton(
                            elevation: 5,
                            onPressed:(){
                              Share.share("I am ${widget.user} and inviting you to Use my Refferal link:$_url to get a reward of 20 points");
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
                                    fontSize: 8,
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
                                      fontSize: 8,
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
    );*/
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
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DashboardScreen()
                              )
                              );
                            },
                            leading: Icon(Icons.home, color: Colors.white),
                            title: Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap:  widget.user.isNotEmpty? () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ReferScreen(user: widget.user, id: widget.id)
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
                          Divider(),

                          Container(
                              alignment: Alignment.center,
                              height: 50,
                              child:Text("Version Number 1.1.1", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),)
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 20,
                              child:Text("Made With 💚 In Pakistan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),)
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
                          SizedBox(height: 20,),
                          Text(
                            'Welcome ${widget.user}',
                            style: TextStyle(
                              color: Color(0xff388E3C),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Image.asset(
                            'assets/images/logocar.png',
                            height: 80,
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                          SizedBox(height: 10,),
                          Image.asset(
                            'assets/images/drycarwashlogo.jpg',
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                          SizedBox(height: 10,),
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
                                      "Total Points": addedpoints !=null ? addedpoints : 0,
                                      "Used Points": usedpoints!= null ? usedpoints : 0,
                                    },
                                    animationDuration: Duration(milliseconds: 200),
                                    colorList: [
                                      Colors.blue,
                                      Colors.greenAccent,
                                    ],
                                    chartValuesOptions: ChartValuesOptions(
                                        decimalPlaces: 0, showChartValueBackground: false),
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
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Points',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          addedpoints !=null  ? addedpoints.toString() :"0",
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
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Used Points',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          usedpoints !=null  ? usedpoints.toString() :"0",

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
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(child: RaisedButton(
                                    elevation: 5,
                                    onPressed:(){
                                      Share.share("I am ${widget.user} and inviting you to Use my Refferal link:$_url to get a reward of 20 points");
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
                                            fontSize: 8,
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
                                              fontSize: 8,
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