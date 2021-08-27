
import 'package:badges/badges.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AppointmentType/ActiveAppointments.dart';
import 'AppointmentType/InActiveAppointments.dart';



class AppointmentScreen extends StatefulWidget {
  final int? uid;
  AppointmentScreen({required this.uid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppointmentScreenState();
  }
}


class AppointmentScreenState extends State<AppointmentScreen>{

  final dateFormat = DateFormat.yMMMMd('en_US');

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkConnection();


  }

  checkConnection() async{
    var connection = await Connectivity().checkConnectivity();
    if(connection == ConnectivityResult.none){
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "No Internet Connection",
          confirmBtnColor: Colors.red,
          barrierDismissible: false,
          animType: CoolAlertAnimType.slideInDown,
          backgroundColor: Colors.redAccent);
    }
    else{
      print("Internet access he");
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("Appointments"),
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
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              color: Colors.white,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      labelColor: Colors.black,
                      labelPadding: EdgeInsets.all(12),
                      labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      tabs: [new Text("Active"), new Text("Canceled")],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              FirstScreen(uid:widget.uid),
              SecondScreen(uid:widget.uid),
            ],
          ),
        ),
      ),


);
          }


  }
