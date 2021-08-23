
import 'dart:async';


import 'package:drycarwash/Screens/DashboardScreen.dart';
import 'package:drycarwash/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main() {


runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  )
);
}

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}



class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.width * 0.70,//TRY TO CHANGE THIS **0.30** value to achieve your goal
                child: Container(

                  margin: EdgeInsets.all(16.0),
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/car_logo.png', scale: 1, width: 100,height: 100),
                        SizedBox(height: 20),
                      ]
                  ),
                )
            )
          ],
        )

    );

  }

  Future<Timer> loadData() async{
    return new Timer(Duration(seconds: 3),onDoneLoading);
  }

  onDoneLoading() async{
    //TODO: AUTOLOGIN
    SharedPreferences sh = await SharedPreferences.getInstance();
    var chk = sh.getInt('userid');
    print(chk);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
    chk == null?
    LoginScreen(): DashboardScreen()

    ));
  }


}